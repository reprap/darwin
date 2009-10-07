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


#include "extruder.h"
#include "serial.h"

#define PC1 100
#define PC2 20

byte PWMPeriod = 255;
volatile static byte currentDirection = 0;

// Non-zero indicates seeking is in progress (and its speed)
volatile static byte seekSpeed = 0;

volatile static byte seekNotify = 255;

volatile static byte lastPortB = 0;
volatile static byte lastPortA = 0;
volatile static byte extrude_click = 0;
volatile static byte material_click = 0;

static byte requestedHeat0 = 0;
static byte requestedHeat1 = 0;
volatile static byte heatCounter = 0;
volatile static byte pulseCounter1 = PC1;
volatile static byte pulseCounter2 = PC2;
volatile static byte solenoid_on = 0;
static byte temperatureLimit0 = 0;
static byte temperatureLimit1 = 0;

volatile static byte delay_counter;
static byte lastTemperature = 0;
static byte lastTemperatureRef = 0;

static byte temperatureVRef = 3;

static byte portaval = 0;

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

#define CMD_VERSION       0
#define CMD_FORWARD       1
#define CMD_REVERSE       2
#define CMD_SETPOS        3
#define CMD_GETPOS        4
#define CMD_SEEK          5
#define CMD_FREE          6
#define CMD_NOTIFY        7
#define CMD_ISEMPTY       8
#define CMD_SETHEAT       9
#define CMD_GETTEMP       10
#define CMD_SETCOOLER     11
#define CMD_PWMPERIOD     50
#define CMD_PRESCALER     51
#define CMD_SETVREF       52
#define CMD_SETTEMPSCALER 53
#define CMD_CHECKHOSTVERSION  254
#define CMD_GETMODULETYPE 255

#define HEATER_PWM_PERIOD 255



#ifdef UNIVERSAL_PCB

void extruder_stop()
{
    RB4 = 0;
    RB5 = 0;
}
void extruder_forward()
{
    RB5 = 0;
    RB4 = 1;
}
void extruder_reverse()
{
    RB4 = 0;
    RB5 = 1;
}
void heater_off()
{
	portaval &= BIN(11110111);
	PORTA = portaval;
}
void heater_on()
{
	portaval |= BIN(00001000);
	PORTA = portaval;
}

#pragma save
#pragma nooverlay
void change_log()
{
  char changes, current;
  extrude_click = 0;
  material_click = 0;
  current = RB1;  // Store so it doesn't change half way through processing
  changes = lastPortB ^ current;

  if (changes) {
    // Our opto-marker changed
    if (current) {
    	extrude_click = 1;
    }
  }
  lastPortB = current;
  
  current = RA5;  // Store so it doesn't change half way through processing
  changes = lastPortA ^ current;  
  if (changes) {
    // Material detector changed
    if (!current && seekNotify != 255) {
		material_click = 1;
    }
  }
  lastPortA = current;

}

void set_cooler(byte b)
{
    if (b)
      portaval |= BIN(00000001);
    else
	  portaval &= BIN(11111110);
    PORTA = portaval;
}
#pragma restore


#else
void extruder_stop()
{
    RB4 = 0;
    RB5 = 0;
}
void extruder_forward()
{
    RB5 = 0;
    RB4 = 1;
}
void extruder_reverse()
{
    RB4 = 0;
    RB5 = 1;
}
void heater_off()
{
	RB0 = 0;
}
void heater_on()
{
	RB0 = 1;
}

#pragma save
#pragma nooverlay
void change_log()
{
  char changes, current;
  extrude_click = 0;
  material_click = 0;
  current = PORTB;  // Store so it doesn't change half way through processing
  PORTB = current;  // properly reset change ??
  changes = lastPortB ^ current;

  if (changes & 0x80) {
    // Our opto-marker changed
    if (current & 0x80) {
    	extrude_click = 1;
    }
  }
  if (changes & 0x40) {
    // Material detector changed
    if (!RB6 && seekNotify != 255) { //***AB Shouldn't this be (!(current & 0x40) && seekNotify != 255)
		material_click = 1;
    }
  }

  lastPortB = current;
}

void set_cooler(byte b)
{
    if (b)
      portaval |= BIN(00000100);
    else
      portaval &= BIN(11111011);
    PORTA = portaval;
}
#pragma restore


#endif

void init2()
{
  PWMPeriod = 255;
  currentDirection = 0;
  seekSpeed = 0;
  seekNotify = 255;
  lastPortB = 0;
  lastPortA = 0;
  currentPosition.bytes[0] = 0;
  currentPosition.bytes[1] = 0;
  seekPosition.bytes[0] = 0;
  seekPosition.bytes[1] = 0;
  requestedHeat0 = 0;
  requestedHeat1 = 0;
  heatCounter = 0;
  lastTemperature = 0;
  lastTemperatureRef = 0;
  temperatureVRef = 3;
  portaval = 0;
  solenoid_on = 0;
  PORTA = portaval;
  TMR1H = HEATER_PWM_PERIOD;
  TMR1L = 0;
}

#pragma save
#pragma nooverlay
void pwmSet()
{
    CCP1CON = BIN(00111100);
//    CCPR1L = seekSpeed;
    CCPR1L = 255;
//  	if (seekSpeed == 255)
    	PR2 = 0;
//  	else
//   	PR2 = PWMPeriod;
}
#pragma restore

//#pragma save
//#pragma nooverlay
//void pwmOff()
//{
//    CCP1CON = BIN(00000000);
//    PR2 = 255;
//    RB3 = 0;
//    CCPR1L = 0;
//}
//#pragma restore

#pragma save
#pragma nooverlay

void solenoid_delay()
{
  pwmSet();
  pulseCounter1 = PC1;
  pulseCounter2 = PC2; 
  solenoid_on = 1;
}

#pragma restore

#pragma save
#pragma nooverlay

void solenoid(byte on)
{
	if(on)
		extruder_forward();
	else
		extruder_reverse();
	solenoid_delay();
}

/*void setSpeed(byte direction)
{
  if (seekSpeed == 0) 
  {
  	extruder_reverse();
    //extruder_stop();
    //return;
  } else 
  {
//    if (direction == 0) 
      extruder_forward();
//    else 
//      extruder_reverse();
  }
  pwmSet();
  pulseCounter1 = PC1;
  pulseCounter2 = PC2;    
  currentDirection = direction;
 _asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
 _endasm;
}*/
#pragma restore

#pragma save
#pragma nooverlay
void timerTick()
{
/*
  // There are two temperatures temperatureLimit0 and temperatureLimit1.
  // When colder than temperatureLimit0, the heater runs at
  // the power specified by requestedHeat1.  If it is between
  // temperatureLimit0 and temperatureLimit1 then it runs at the
  // lower power setting requestedHeat0.  If it is hotter than
  // temperatureLimit1, the power shuts down completely.
  if (lastTemperature <= temperatureLimit1) {
    // Reached critical limit, so power off
    heater_off();
  } else if (lastTemperature <= temperatureLimit0 &&
	     heatCounter >= requestedHeat0 && requestedHeat0 != 255) {
    // In medium zone, heater off period (based on low heat)
    heater_off();
  } else if (lastTemperature > temperatureLimit0 &&
	     heatCounter >= requestedHeat1 && requestedHeat1 != 255) {
    // In low zone, heater off period (based on high heat)
    heater_off();
  } else {
    // Heater on
    heater_on();
  }
  */
  
  if(solenoid_on)
  {
  	if(pulseCounter2 == 0)
  	{
    	if(pulseCounter1 == 0)
  		{
  			extruder_stop();
  			solenoid_on = 0;
  		} else
  		{
  	  		pulseCounter1--;
  	  		pulseCounter2 = PC2;
  		}
  	} else
  	  pulseCounter2--;
  }
  
  heatCounter++;
  TMR1H = HEATER_PWM_PERIOD;
  TMR1L = 0;

_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
_endasm;
}
#pragma restore


#pragma save
#pragma nooverlay
void motorTick()
{
  // Clear interrupt flag
  RBIF = 0;
  
  change_log();

  if (extrude_click) {
      
      // Adjust counter appropriately based on last known direction
      if (currentDirection)
	currentPosition.ival--;
      else
	currentPosition.ival++;
      
      if (seekSpeed != 0 && currentPosition.ival == seekPosition.ival) {
	// Turn off motor
	extruder_stop();
    }
  }
  if (material_click) {
      if (sendMessageISR(seekNotify)) { //TODO: if sending is not possible, what todo?
        sendDataByteISR(CMD_ISEMPTY);
        sendDataByteISR(1);
        endMessageISR();
      }
  }

 _asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
 _endasm;
}
#pragma restore


void checkTemperature()
{
/*
  // Assumes:
  // A6 is a reference resistor
  // A7 is thermistor
  // A1 is comparator

  // Remember what PORTA should be
  byte val = portaval;

  // Assume capacitor is discharged from previous round or powerup

  // Set Timer0 to timer mode and use watchdog prescaler
  T0CS = 0;
  PSA = 0;

  // Set vref to test level and give it time to stabilise
  VRCON = BIN(10000000) | temperatureVRef;
  CMCON = BIN(00000010);
  delay_10us();

  T0IF = 0;

  // Set A6 to high, float others
  // Don't allow interrupts to mess with these
  GIE = 0;   
  TRISA = BIN(10000010) | PORTATRIS;
  portaval = val | BIN(01000000);
  PORTA = portaval;
  GIE = 1;
 	
  // Wait for cap to reach vref
  TMR0 = 0;
  while (C2OUT)
    ;
  if (T0IF)
    lastTemperatureRef = 255;
  else
    lastTemperatureRef = TMR0;

  // Discharge cap
  // Set A1 to low, float others
  GIE = 0;
  portaval = val;
  PORTA = portaval;
  TRISA = BIN(11000000) | PORTATRIS;
  GIE = 1;
  
  // Set vref to low
  VRCON = BIN(10100001); // should be 1010xxxx to not output value
  delay_10us();
  // Wait for voltage to go low
  while (!C2OUT)
    ;
  // Extra delay for full discharge
  delay_10us();

  // Set vref to test level and give it time to stabilise
  VRCON = BIN(10000000) | temperatureVRef;
  delay_10us();

  T0IF = 0;
  // Set A7 to high, float others
  GIE = 0;
  portaval = val | BIN(10000000);
  PORTA = portaval;
  TRISA = BIN(01000010) | PORTATRIS;
  GIE = 1;
  
  // Use 8 bit Timer0 to measure time
  // Wait for cap to reach vref
  TMR0 = 0;
  while (C2OUT)
    ;
  if (T0IF)
    lastTemperature = 255;
  else
    lastTemperature = TMR0;

  // Discharge cap
  // Set A1 to low, float others
  // Restore PORTA to its original value
  GIE = 0;
  portaval = val;
  PORTA = portaval;
  TRISA = BIN(11000000) | PORTATRIS;
  GIE = 1;

  // Set vref to low
  VRCON = BIN(10100001); // should be 1010xxxx to not output value
  delay_10us();
  // Wait for voltage to reach 0
  while (!C2OUT)
    ;
  // Extra delay for full discharge
  delay_10us();

  TRISA = BIN(11000010) | PORTATRIS;
  VRCON = 0;  // Turn off vref
*/
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
_endasm;
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
    sendDataByte(SUPPORT_EXTRUDER_TYPE);
    endMessage();
    break;

// Extrude speed takes precedence over fan speed
  case CMD_FORWARD:
  	solenoid(buffer[1]);
 //   seekSpeed = buffer[1];
 //   setSpeed(0);
    break;

  case CMD_REVERSE:
//    seekSpeed = buffer[1];
//    setSpeed(1);
  	solenoid(0);
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

//  if (seekPosition.ival != currentPosition.ival) {
//      seekSpeed = buffer[1];
//      if (currentPosition.ival > seekPosition.ival)
//	setSpeed(1);
//      else
//	setSpeed(0);
//    }

    break;

  case CMD_FREE:
    // Free motor.  There is no torque hold for a DC motor,
    // so all we do is switch off
//    extruder_stop();
	solenoid(0);
    break;

  case CMD_NOTIFY:
    // Set seek completion (and calibration) notification
    seekNotify = buffer[1];
    break;

  case CMD_ISEMPTY:
    sendReply();
    sendDataByte(CMD_ISEMPTY);
#ifdef UNIVERSAL_PCB
     sendDataByte(!RA5);   
#else
     sendDataByte(!RB6);
#endif
    endMessage();
    break;

  case CMD_SETHEAT:
    requestedHeat0 = buffer[1];
    requestedHeat1 = buffer[2];
    temperatureLimit0 = buffer[3];
    temperatureLimit1 = buffer[4];
    break;

  case CMD_GETTEMP:
    sendReply();
    sendDataByte(CMD_GETTEMP);
    sendDataByte(lastTemperature);
    sendDataByte(lastTemperatureRef);
    endMessage();
    break;

  case CMD_SETCOOLER:
  	set_cooler(buffer[1]);
#ifdef UNIVERSAL_PCB
	if(buffer[1] && !seekSpeed)
	{
		seekSpeed = buffer[1];
    	pwmSet();
    }
#endif
    break;

// "Hidden" low level commands
  case CMD_PWMPERIOD:
    // Set PWM period
    PWMPeriod = buffer[1];
    PR2 = PWMPeriod;
    break;

  case CMD_PRESCALER:
    // Set timer prescaler (for PWM)
    T2CON = BIN(00000100) | (buffer[1] & 3);
    break;

  case CMD_SETVREF:
    temperatureVRef = buffer[1];
    break;

  case CMD_SETTEMPSCALER:
    OPTION_REG = (OPTION_REG & BIN(11111000)) | (buffer[1] & BIN(111));
    break;

  }

}

// To work around sdcc issue
void dummy()
{
  INTCON = 0;
}
