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

#include "stepmotor.h"
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
  
  if (TMR1IF) {
    timerTick();
    TMR1IF = 0;
  }
}

void init1()
{

  OPTION_REG = BIN(01011111); // Disable TMR0 on RA4, 1:128 WDT, pullups on
  CMCON = 0xff;               // Comparator module defaults
#ifdef UNIVERSAL_PCB  
  TRISA = BIN(00101010);      // Port A outputs except 1,3 (sync) and 5 (Max)
                              // RA0 is L298 4
                              // RA1 is Sync
                              // RA2 is L298 3                                                            
                              // RA3 is Sync
                              // RA4 is the indicator LED
                              // RA5 is Max sensor
                              // RA6 is not used for the stepper
                              // RA7 is not used for the stepper                                                                                        
  TRISB = BIN(00000011);      // Port B 0,1 input, 2-7 outputs
                              // RB0 is Min sensor
                              // RB1 is Rx
                              // RB2 is Tx 
                              // RB3 is PWM output to L298                                                                                       
                              // RB4 is L298 2
                              // RB5 is L298 1
                              // RB6 is not used
                              // RB7 is not used 
#else
  TRISA = BIN(00101100);      // Port A outputs except 2,3 (sync)
                              // RA3 is input for max limit sensor
                              // RA4 is the indicator LED
                              // RA5 can only be used as an input                              
  TRISB = BIN(00000111);      // Port B 0-2 input, 3-7 outputs
                              // Port B3 is PWM output
#endif                              
  PIE1 = BIN(00000000);       // All peripheral interrupts initially disabled
  INTCON = BIN(00000000);     // Interrupts disabled
  PIR1 = 0;                   // Clear peripheral interrupt flags
  SPBRG = 12;                 // 12 = 19200 (actually 19230) baud @ 4MHz

  TXSTA = BIN(00000100);      // 8 bit high speed 
  RCSTA = BIN(10000000);      // Enable port for 8 bit receive

  PORTB = PULLUPS;      // Turn on pullups for B0,3

  RCIE = 1;  // Enable receive interrupts
  CREN = 1;  // Start reception

  TXEN = 1;  // Enable transmit
  PEIE = 1;  // Peripheral interrupts on
  GIE = 1;   // Now turn on interrupts

  PORTB = 0;
  PORTA = 0;

  TMR1IE = 0;

  TMR2 = 0;
  CCPR1L = 4;  // Default power-up current limiting (25%)
  PR2 = 16;
  CCP1CON = BIN(00001100);   // PWM mode
  T2CON = BIN(00000100);     // Start timer 1:1 prescale, 1:1 postscale

  T1CON = BIN(00000000);  // Timer 1 in clock mode with 1:1 scale
  TMR1IE = 1;  // Enable timer interrupt

}

void main() {
  byte syncEnabled = 0;

  init1();
  init2();
  serial_init();

  // Clear up any boot noise from the TSR
  GIE=0;
  uartTransmit(0);
  GIE=1;
 
  if (SYNCA) // Only enable if SYNCA is by default high
    syncEnabled = 1;

  for(;;) {
    if (packetReady()) {
      processCommand();
      releaseLock();
    }
    if (syncEnabled && !SYNCA) {
      // Sync line has dropped
      // Spin until it goes high again (we trigger on the rising edge)
      while(!SYNCA)
	;
      syncStrobe();
    }
    clearwdt();
  }
}
