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

// Simple stepper controller.
//
// This is for a bipolar stepper - either 4 coils with pairs wired
// in series, or two coils.
//
// A total of 8 steps are achieved for finer movement by also making
// use of "half-steps".
//

// I/O ports - old design:

//   B0 - Min optointerrupter (optional)
//   B1 - UART Receive
//   B2 - UART Transmit
//   B3 - PWM output for motor current control
//   B4-B7 - Stepper motor connections
//   A2 - Sync A input/output (optional)
//   A3 - Sync B input/output (optional)
//   A5 - Max optointerrupter (optional)

// I/O ports - Universal PCB (new design):

// RA0 is L298 4
// RA1 is Sync
// RA2 is L298 3                                                            
// RA3 is Sync
// RA4 is the indicator LED
// RA5 is Max sensor
// RA6 is not used for the stepper
// RA7 is not used for the stepper  
                              
// RB0 is Min sensor
// RB1 is Rx
// RB2 is Tx 
// RB3 is PWM output to L298                                                                                       
// RB4 is L298 2
// RB5 is L298 1
// RB6 is not used
// RB7 is not used


#ifdef HALFSTEP
#define stepCount 8
#else
#define stepCount 4
#endif

typedef union {
  int ival;
  byte bytes[2];
} addressableInt;

volatile static byte coilPosition = 0;

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
#define CMD_FORWARD1  12
#define CMD_BACKWARD1 13
#define CMD_SETPOWER  14
#define CMD_GETSENSOR 15
#define CMD_HOMERESET 16
#define CMD_CHECKHOSTVERSION  254
#define CMD_GETMODULETYPE 255

enum functions {
  func_idle,
  func_forward,
  func_reverse,
  func_syncwait,   // Waiting for sync prior to seeking
  func_seek,
  func_findmin,    // Calibration, finding minimum
  func_findmax,    // Calibration, finding maximum
  func_ddamaster,
  func_homereset   // Move to min position and reset
};
volatile static byte function = func_idle;

volatile static byte speed = 0;

volatile static byte seekNotify = 255;

// Uncomment this when we have more memory...
//volatile static byte stepPower = 32;

volatile static addressableInt currentPosition, seekPosition, maxPosition;

volatile static addressableInt dda_deltay;
volatile static int dda_error;
static int dda_deltax;

enum sync_modes {
  sync_none,     // no sync (default)
  sync_seek,     // synchronised seeking
  sync_inc,      // inc motor on each pulse
  sync_dec       // dec motor on each pulse
};
static byte sync_mode = sync_none;

void init2()
{
  /// @todo Remove some of these when intialisers fixed
  speed = 0;
  function = func_idle;
  coilPosition = 0;
  sync_mode = sync_none;
  seekNotify = 255;

  currentPosition.bytes[0] = 0;
  currentPosition.bytes[1] = 0;
  seekPosition.bytes[0] = 0;
  seekPosition.bytes[1] = 0;
  maxPosition.bytes[0] = 0;
  maxPosition.bytes[1] = 0;
}

#ifdef UNIVERSAL_PCB

#pragma save
#pragma nooverlay

void motor_stop()
{
	PORTB = PORTB & BIN(11001111);
	PORTA = PORTA & BIN(11111010);
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#pragma save
#pragma nooverlay

// This will adjust the motor power on the half steps to
// get the same (lower) torque as on the full steps
// to get the smoothest running.
// See http://www.sxlist.com/techref/io/stepper/linistep/halfstep.htm
// Uncomment the setPower() lines when we have more memory.

void motor_click()
{
  byte cp;
#ifdef HALFSTEP
  cp = coilPosition;
#else
  cp = coilPosition << 1;
#endif
  switch(cp) {
  case 7:
    //setPower((stepPower >> 1) + (stepPower >> 3));
    RB5 = 1;
    RB4 = 0;
    RA2 = 1;
    RA0 = 0;
    break;
  case 6:
    //setPower(stepPower);
    RB5 = 1;
    RB4 = 0;
    RA2 = 0;
    RA0 = 0;
    break;    
  case 5:
    //setPower((stepPower >> 1) + (stepPower >> 3));
    RB5 = 1;
    RB4 = 0;
    RA2 = 0;
    RA0 = 1;
    break;     
  case 4:
    //setPower(stepPower);
    RB5 = 0;
    RB4 = 0;
    RA2 = 0;
    RA0 = 1;
    break;     
  case 3:
    //setPower((stepPower >> 1) + (stepPower >> 3));
    RB5 = 0;
    RB4 = 1;
    RA2 = 0;
    RA0 = 1;
    break;     
  case 2:
    //setPower(stepPower);
    RB5 = 0;
    RB4 = 1;
    RA2 = 0;
    RA0 = 0;
    break;    
  case 1:
    //setPower((stepPower >> 1) + (stepPower >> 3));
    RB5 = 0;
    RB4 = 1;
    RA2 = 1;
    RA0 = 0;
    break;    
  case 0:
    //setPower(stepPower);
    RB5 = 0;
    RB4 = 0;
    RA2 = 1;
    RA0 = 0;
    break;    
  }
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#else

#ifdef HALFSTEP
byte stepValue()
{
  // The low bits are set to ensure pullups are enabled for those ports
  switch(coilPosition) {
  case 0:
    return BIN(00010000) | PULLUPS;
  case 1:
    return BIN(00110000) | PULLUPS;
  case 2:
    return BIN(00100000) | PULLUPS;
  case 3:
    return BIN(01100000) | PULLUPS;
  case 4:
    return BIN(01000000) | PULLUPS;
  case 5:
    return BIN(11000000) | PULLUPS;
  case 6:
    return BIN(10000000) | PULLUPS;
  case 7:
    return BIN(10010000) | PULLUPS;
  }
  return 0;
}
#else
byte stepValue()
{
  // The low bits are set to ensure pullups are enabled for those ports
  switch(coilPosition) {
  case 0:
    return BIN(00010000) | PULLUPS;
  case 1:
    return BIN(00100000) | PULLUPS;
  case 2:
    return BIN(01000000) | PULLUPS;
  case 3:
    return BIN(10000000) | PULLUPS;
  }
  return 0;
}
#endif

#pragma save
#pragma nooverlay
void motor_stop()
{
	PORTB = PULLUPS;
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void motor_click()
{
    PORTB = stepValue();
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#endif



#pragma save
#pragma nooverlay

void forward1()
{
  flashLED();
  if (MAXSENSOR) {
    // We hit the end so go idle
    motor_stop();
    function = func_idle;
  } else {
    currentPosition.ival++;
    coilPosition = (coilPosition + 1) & (stepCount - 1);
    motor_click();
  }
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void reverse1()
{
  flashLED();
  if (MINSENSOR) {
    // We hit the end so go idle
    motor_stop();
    function = func_idle;
  } else {
    currentPosition.ival--;
    coilPosition = (coilPosition + stepCount - 1) & (stepCount - 1);
    motor_click();
  }
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition;
_endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void setTimer(byte newspeed)
{
  speed = newspeed;
  if (speed) {
    TMR1ON = 0;  //TMR1H, TMR1L should only be set, when TMR1ON is off
    TMR1H = speed;
    TMR1L = 0;
    TMR1ON = 1;
  } else {
    TMR1ON = 0;
  }
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void strobe_sync() {
  byte delay;
  
  SYNCA = 0; // Pull low
  SYNCA_TRIS = 0; // Set to output during stobe

  // Spin for a few cycles
  for(delay = 0; delay <= 254; delay++)
    ;

  SYNCA_TRIS = 1; // Back to input so we don't drive the sync line
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore


#pragma save
#pragma nooverlay
// Perform a single DDA step
static void dda_step()
{
  if (currentPosition.ival == seekPosition.ival) {
    function = func_idle;
  } else if (currentPosition.ival < seekPosition.ival) {
    forward1();
  } else {
    reverse1();
  }
  if (function == func_idle && seekNotify != 255) {
    if (sendMessageISR(seekNotify)) { 
      sendDataByteISR(CMD_DDA);
      sendDataByteISR(currentPosition.bytes[0]);
      sendDataByteISR(currentPosition.bytes[1]);
      endMessageISR();
    } else {
      //sending is not possible, call this function again!
      function = func_ddamaster;
    }
  } else if (function != func_idle) {
    dda_error += dda_deltay.ival;
    if ((dda_error + dda_error) > dda_deltax) {
      // Y needs to be stepped, so signal
      strobe_sync();
      dda_error -= dda_deltax;
    }
  }
}
#pragma restore

#pragma save
#pragma nooverlay
// if speed is set to 0, then TMR1ON should also be set to 0, therefore
//   set function to func_idle and then next round both will be set to 0
void timerTick()
{
  switch(function) {
  case func_idle:
    TMR1ON = 0;
    speed = 0;
    LEDon();
    break;
  case func_forward:
    forward1();
    break;
  case func_reverse:
    reverse1();
    break;
  case func_seek:
    if (currentPosition.ival < seekPosition.ival) {
      forward1();
    } else if (currentPosition.ival > seekPosition.ival) {
      reverse1();
    } else {
      // Reached
      LEDon();
      // Uncomment next line to remove torque on arrival
      //motor_stop();
      function=func_idle;
    }
    if (function == func_idle && seekNotify != 255) {
      if (sendMessageISR(seekNotify)) {
        sendDataByteISR(CMD_SEEK);
        sendDataByteISR(currentPosition.bytes[0]);
        sendDataByteISR(currentPosition.bytes[1]);
        endMessageISR();
      } else {
        //sending is not possible, call this function again!
        function=func_seek;
      }
    }
    break;
  case func_findmin:
    if (MINSENSOR) {
      currentPosition.bytes[0] = 0;
      currentPosition.bytes[1] = 0;
      function = func_findmax;
    } else {
      reverse1();
    }
    break;
  case func_findmax:
    if (MAXSENSOR) {
      maxPosition.bytes[0] = currentPosition.bytes[0];
      maxPosition.bytes[1] = currentPosition.bytes[1];
      function = func_idle;
    } else {
      forward1();
    }
    if (function == func_idle && seekNotify != 255) {
      if (sendMessageISR(seekNotify)) {
        sendDataByteISR(CMD_CALIBRATE);
        sendDataByteISR(currentPosition.bytes[0]);
        sendDataByteISR(currentPosition.bytes[1]);
        endMessageISR();
      } else {
        //sending is not possible, call this function again!
        function = func_findmax;
      }
    }
    break;
  case func_syncwait:
    // Do nothing, we're still waiting
    break;
  case func_ddamaster:
    dda_step();
    break;
  case func_homereset:
    if (MINSENSOR) {
      currentPosition.bytes[0] = 0;
      currentPosition.bytes[1] = 0;
      function = func_idle;
    } else {
      reverse1();
    }
    if (function == func_idle && seekNotify != 255) {
      if (sendMessageISR(seekNotify)) {
        sendDataByteISR(CMD_HOMERESET);
        endMessageISR();
      } else {
        //sending is not possible, call this function again!
        function = func_homereset;
      }
    }      
    break;
  }
  setTimer(speed);
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
#pragma restore

/// Called when the sync line is strobed (pulled briefly low)
void syncStrobe() {
  switch(sync_mode) {
  case sync_none:
    break;
  case sync_seek:
    if (function = func_syncwait) {
      sync_mode = sync_none;
      function = func_seek;
    }
    break;
  case sync_inc:
    forward1();
    break;
  case sync_dec:
    reverse1();
    break;
  }
}

void setPower(byte p)
{
    // This is a value from 0 to 63 (6 bits)
    // The low two bits are stored in CCP1CON, and the remaining
    // four bits in CCPR1L
    CCPR1L = p >> 2;
    PR2 = 16;  // The maximum range
    // Store low 2 bits and turn on PWM
    CCP1CON = BIN(1100) | ((p & BIN(11)) << 4);
}

void processCommand()
{
  switch(buffer[0]) {
  case CMD_VERSION:
    sendReply();
    sendDataByte(CMD_VERSION);  // Response type 0
    sendDataByte(MAJOR_VERSION_NUMBER);
    sendDataByte(MINOR_VERSION_NUMBER);
    endMessage();
    break;

  case CMD_CHECKHOSTVERSION:
    sendReply();
    sendDataByte(CMD_CHECKHOSTVERSION);    
    if(buffer[1] > OLDHOST_MAJOR_VERSION_NUMBER)
       sendDataByte(0xff);    
    else if (buffer[1] == OLDHOST_MAJOR_VERSION_NUMBER)
    {
       if (buffer[2] >= OLDHOST_MINOR_VERSION_NUMBER)
          sendDataByte(0xff);
       else
          sendDataByte(0);    
    } else
       sendDataByte(0);
    sendDataByte(OLDHOST_MAJOR_VERSION_NUMBER);
    sendDataByte(OLDHOST_MINOR_VERSION_NUMBER);
    endMessage();
    break;    

  case CMD_GETMODULETYPE:
    sendReply();
    sendDataByte(CMD_GETMODULETYPE);
    sendDataByte(LINEAR_AXIS_TYPE);
    endMessage();
    break;

  case CMD_FORWARD:
    // Forward speed
    function = func_forward;
    setTimer(buffer[1]);
    break;

  case CMD_REVERSE:
    // Reverse speed
    function = func_reverse;
    setTimer(buffer[1]);    
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

    if (sync_mode == sync_seek)
      function = func_syncwait;
    else
      function = func_seek;
    setTimer(buffer[1]);
    break;

  case CMD_FREE:
    // Free motor (release torque)
    motor_stop();
    function = func_idle;
    break;

  case CMD_NOTIFY:
    // Set seek completion (and calibration) notification
    seekNotify = buffer[1];
    break;

  case CMD_SYNC:
    // Set sync mode
    sync_mode = buffer[1];
    break;

  case CMD_CALIBRATE:
    // Request calibration (search at given speed)
    function = func_findmin;
    setTimer(buffer[1]);
    break;

  case CMD_GETRANGE:
    // Request range
    sendReply();
    sendDataByte(CMD_GETRANGE);
    sendDataByte(maxPosition.bytes[0]);
    sendDataByte(maxPosition.bytes[1]);
    endMessage();
    break;

  case CMD_DDA:
    // Master a DDA
    // Assumes head is already positioned correctly at x0 and extrusion
    // is starting

    seekPosition.bytes[0] = buffer[2];
    seekPosition.bytes[1] = buffer[3];
    dda_deltay.bytes[0] = buffer[4];
    dda_deltay.bytes[1] = buffer[5];
    dda_error = 0;

    dda_deltax = seekPosition.ival - currentPosition.ival;
    if (dda_deltax < 0) dda_deltax = -dda_deltax;

    function = func_ddamaster;
    setTimer(buffer[1]);
    break;

  case CMD_FORWARD1:
    forward1();
    break;

  case CMD_BACKWARD1:
    reverse1();
    break;

  case CMD_SETPOWER:
    // Uncomment these when we have more memory
    //stepPower = buffer[1];
    //setPower(stepPower);
    setPower(buffer[1]);
    break;

  case CMD_GETSENSOR:
    sendReply();
    sendDataByte(CMD_GETSENSOR);
    sendDataByte(PORTA);
    sendDataByte(PORTB);
    endMessage();
    break;

  case CMD_HOMERESET:
    // Seek to home position and reset (search at given speed)
    function = func_homereset;
    setTimer(buffer[1]);
    break;

  }
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _coilPosition
_endasm;
}
