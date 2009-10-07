/*
 *
 * RepRap, The Replicating Rapid Prototyper Project
 *
 * http://reprap.org/
 *
 * RepRap is copyright (C) 2005-6 University of Bath, the RepRap
 * researchers (see the project's People webpage), and other contributors.
 *
 * RepRap is free; you can redistribute it and/or modify it under the
 * terms of the GNU Library General Public Licence as published by the
 * Free Software Foundation; either version 2 of the Licence, or (at your
 * option) any later version.
 *
 * RepRap is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
 * Licence for more details.
 *
 * For this purpose the words "software" and "library" in the GNU Library
 * General Public Licence are taken to mean any and all computer programs
 * computer files data results documents and other copyright information
 * available from the RepRap project.
 *
 * You should have received a copy of the GNU Library General Public
 * Licence along with RepRap (in reports, it will be one of the
 * appendices, for example); if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA, or see
 *
 * http://www.gnu.org/
 *
 */

#include "motor.h"
#include "serial.h"

typedef unsigned int config;
config at 0x2007 __CONFIG = _CP_OFF &
 _WDT_OFF &
 _BODEN_OFF &
 _PWRTE_ON &
 _INTRC_OSC_NOCLKOUT &
 _MCLRE_OFF &
 _LVP_OFF;

byte deviceAddress = PORT;

static void isr() interrupt 0 {
  serialInterruptHandler();

  if (RBIF)
    motorTick();
}

void init1()
{
  byte v = 0;

  OPTION_REG = BIN(01011111); // Disable TMR0 on RA4, 1:128 WDT, pullups on
  CMCON = 0xff;               // Comparator module defaults
  TRISA = BIN(00100000);      // Port A outputs (except 5)
                              // RA5 can only be used as an input
  TRISB = BIN(10000110);      // Port B outputs, except 1/2 for serial and
                              // RB7 for optointerrupter input
  // Note port B3 will be used for PWM output (CCP1)
  PIE1 = BIN(00000000);       // All peripheral interrupts initially disabled
  INTCON = BIN(00000000);     // Interrupts disabled
  PIR1 = 0;                   // Clear peripheral interrupt flags
  SPBRG = 12;                 // 12 = ~19200 baud @ 4MHz
  TXSTA = BIN(00000100);      // 8 bit high speed 
  RCSTA = BIN(10000000);      // Enable port for 8 bit receive

  RCIE = 1;  // Enable receive interrupts
  CREN = 1;  // Start reception

  TXEN = 1;  // Enable transmit
  RBIE = 1;  // Enable RB port change interrupt

  PEIE = 1;  // Peripheral interrupts on
  GIE = 1;   // Now turn on interrupts

  PORTB = 0x80;  // Pullup on RB7 for opto-input
  PORTA = 0;

  PR2 = PWMPeriod;          // Initial PWM period
  CCP1CON = BIN(00111100);  // Enable PWM mode
  CCPR1L = 0;               // Start turned off
  
  T2CON = BIN(00000100);    // Enable timer 2 and set prescale to 1
}

void main() {
  init1();
  init2();
  serial_init();

  // Clear up any boot noise from the TSR
  uartTransmit(0);

  for(;;) {
    waitForPacket();
    processCommand();
    releaseLock();
  }
}
