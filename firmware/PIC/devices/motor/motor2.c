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

byte PWMPeriod = 255;
volatile static byte currentDirection = 0;

// Non-zero indicates seeking is in progress (and its speed)
volatile static byte seekSpeed = 0;

volatile static byte lastPortB = 0;

// Note: when reversing motor direction, the speed should be set to 0
// and then delayed long enough for the motor to come to rest.
// Failing to do this could result in miscalculated motor position
// because the code bases the calculation on expected direction, not
// actual direction (and the motor may take a little while to actually
// reverse direction).

typedef union {
  int ival;
  byte bytes[2];
} addressableInt;

volatile static addressableInt currentPosition, seekPosition;

#define CMD_VERSION   0
#define CMD_FORWARD   1
#define CMD_REVERSE   2
#define CMD_SETPOS    3
#define CMD_GETPOS    4
#define CMD_SEEK      5
#define CMD_FREE      6
#define CMD_NOTIFY    7
#define CMD_SYNC      8
#define CMD_CALIBRATE 9
#define CMD_GETRANGE  10
#define CMD_DDA       11
#define CMD_PWMPERIOD 50
#define CMD_PRESCALER 51


void init2()
{
  PWMPeriod = 255;
  currentDirection = 0;
  seekSpeed = 0;
  lastPortB = 0;
  currentPosition.bytes[0] = 0;
  currentPosition.bytes[1] = 0;
  seekPosition.bytes[0] = 0;
  seekPosition.bytes[1] = 0;
}

#pragma save
#pragma nooverlay
void setSpeed(byte speed, byte direction)
{
  if (speed == 0) {
    PORTB = 0;
    // Also turn off PWM completely
    CCP1M2 = 0;
    CCP1M3 = 0;
  } else {
    if (direction == 0)
      PORTB = BIN(00010000);  // Set forward output enable
    else
      PORTB = BIN(00100000);  // Set reverse output enable
    // Turn on PWM if it wasn't already
    CCP1M2 = 1;
    CCP1M3 = 1;
  }
  CCPR1L = speed;
  if (speed == 255)
    PR2 = 0;
  else
    PR2 = PWMPeriod;
    
  currentDirection = direction;
 _asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
 _endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void motorTick()
{
  char changes, current;

  // Clear interrupt flag
  RBIF = 0;

  current = PORTB;  // Store so it doesn't change half way through processing
  PORTB = current;  // properly reset change ??
  changes = lastPortB ^ current;

  if (changes & 0x80) {
    // Our opto-marker changed
    if (current & 0x80) {
      // If input is set, we hit the opto-marker.  If it's not set
      // it's come off the marker, and we only want to deal with one
      // of them or we'll double increment everything
      
      // Adjust counter appropriately based on last known direction
      if (currentDirection)
	currentPosition.ival--;
      else
	currentPosition.ival++;
      
      if (seekSpeed != 0 && currentPosition.ival == seekPosition.ival) {
	seekSpeed = 0;
	PORTB = 0;
	CCPR1L = 0;
      }
    }
  }

  lastPortB = current;
 _asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
 _endasm;
}
#pragma restore

void processCommand()
{
  switch(buffer[0]) {
  case CMD_VERSION:
    sendReply();
    sendDataByte(CMD_VERSION);  // Response type 0
    sendDataByte(0);  // These don't really mean much right now
    sendDataByte(2);
    endMessage();
    break;

  case CMD_FORWARD:
    // Forward speed
    setSpeed(buffer[1], 0);
    break;

  case CMD_REVERSE:
    // Reverse speed
    setSpeed(buffer[1], 1);
    break;

  case CMD_SETPOS:
    // Set (reset) position counter
    currentPosition.bytes[0] = buffer[1];
    currentPosition.bytes[1] = buffer[2];
    break;

  case CMD_GETPOS:
    // Get position counter
    sendReply();
    sendDataByte(CMD_GETPOS);
    sendDataByte(currentPosition.bytes[0]);
    sendDataByte(currentPosition.bytes[1]);
    endMessage();
    break;

  case CMD_SEEK:
    // Goto position
    seekPosition.bytes[0] = buffer[2];
    seekPosition.bytes[1] = buffer[3];

    if (seekPosition.ival != currentPosition.ival) {
      seekSpeed = buffer[1];
      if (currentPosition.ival > seekPosition.ival)
	setSpeed(seekSpeed, 1);
      else
	setSpeed(seekSpeed, 0);
    }

    break;

  case CMD_FREE:
    // Free motor.  There is no torque hold for a DC motor,
    // so all we do is switch off
    setSpeed(0, 0);
    break;

  case CMD_NOTIFY:
    // To be implemented
    break;

  case CMD_SYNC:
    // To be implemented
    break;

  case CMD_CALIBRATE:
    // To be implemented
    break;

  case CMD_GETRANGE:
    // To be implemented
    break;

  case CMD_DDA:
    // To be implemented
    break;

// "Hidden" low level commands
  case CMD_PWMPERIOD:
    // Set PWM period
    PWMPeriod = buffer[1];
    PR2 = PWMPeriod;
    break;

  case CMD_PRESCALER:
    // Set timer prescaler
    T2CON = BIN(00000100) | (buffer[1] & 3);
    break;
  }
}

// To work around sdcc issue
void dummy()
{
  INTCON = 0;
}
