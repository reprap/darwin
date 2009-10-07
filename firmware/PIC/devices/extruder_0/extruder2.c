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

void pwmSet(byte fastOverRide);

//initialization does not work!
byte PWMPeriod;
volatile static byte currentDirection;

// Non-zero indicates seeking is in progress (and its speed)
volatile static byte seekSpeed;

volatile static byte seekNotify;

volatile static byte lastPortB;
volatile static byte lastPortA;
volatile static byte extrude_click;
volatile static byte material_click;

volatile static byte pulseCounter1 = PC1;
volatile static byte pulseCounter2 = PC2;
volatile static byte solenoid_on = 0;

volatile static byte requestedHeat0;
volatile static byte requestedHeat1;
volatile static byte heatCounter;
volatile static byte temperatureLimit0;
volatile static byte temperatureLimit1;

volatile static byte lastTemperature;
static byte temperatureVRef;
volatile static byte temperatureNotUpdatedCounter;

volatile static byte portaval;

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
#define CMD_VALVEOPEN     12
#define CMD_VALVECLOSED   13
#define CMD_PWMPERIOD     50
#define CMD_PRESCALER     51
#define CMD_SETVREF       52
#define CMD_SETTEMPSCALER 53
#define CMD_GETDEBUGINFO  54
#define CMD_GETTEMPINFO   55
#define CMD_CHECKHOSTVERSION  254
#define CMD_GETMODULETYPE 255

#define HEATER_PWM_PERIOD 255

#ifdef UNIVERSAL_PCB

/*
 * ************************************************************************
 *  New circuit design
 */

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
/* andi: RB1 == serial-receive ! should that be RB0???
  current = RB1;  // Store so it doesn't change half way through processing
  changes = lastPortB ^ current;

  if (changes) {
    // Our opto-marker changed
    if (current) {
    	extrude_click = 1;
    }
  }
  lastPortB = current;
*/
  
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
      RB6 = 1;
      //portaval |= BIN(00000001);
    else
      RB6 = 0;
	  //portaval &= BIN(11111110);
    //PORTA = portaval;
}
#pragma restore



#pragma save
#pragma nooverlay

void solenoid_delay()
{
  pwmSet(1);
  pulseCounter1 = PC1;
  pulseCounter2 = PC2; 
  solenoid_on = 1;
}

#pragma restore

#pragma save
#pragma nooverlay

void solenoid(byte on)
{
    portaval &= BIN(11111010);
	if(on)
		portaval |= BIN(00000001);
	else
		portaval |= BIN(00000100);
	PORTA = portaval;	
	solenoid_delay();
}
#pragma restore

/*
 * ********************************************************************
 *  Old circuit design
 */

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
      //portaval |= BIN(00000100);
      PORTB6 = 1;
    else
      PORTB6 = 0;
      //portaval &= BIN(11111011);
    //PORTA = portaval;
}
#pragma restore


#endif

/*
 *  End of old circuit design
 * *******************************************************************
 */

void init2()
{
  PWMPeriod = 255;
  currentDirection = 0;
  seekSpeed = 0;
  seekNotify = 255;
  lastPortB = 0;
  lastPortA = 0;
  extrude_click = 0;
  material_click = 0;
  currentPosition.bytes[0] = 0;
  currentPosition.bytes[1] = 0;
  seekPosition.bytes[0] = 0;
  seekPosition.bytes[1] = 0;
  requestedHeat0 = 0;
  requestedHeat1 = 0;
  temperatureLimit0 = 0;
  temperatureLimit1 = 0;
  heatCounter = 0;
  lastTemperature = 255;
  temperatureVRef = 0; //set to 0, should be set by the host software
  portaval = 0;
  PORTA = portaval;
  TMR1H = HEATER_PWM_PERIOD;
  TMR1L = 0;
  temperatureNotUpdatedCounter=0;
}

#pragma save
#pragma nooverlay
void pwmSet(byte fastOverRide)
{
    CCP1CON = BIN(00111100);
    CCPR1L = seekSpeed;
  	if (fastOverRide || seekSpeed == 255)
    	PR2 = 0;
  	else
    	PR2 = PWMPeriod;

_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
_endasm;
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
void setSpeed(byte direction)
{
  if (seekSpeed == 0) 
  {
    extruder_stop();
    return;
  } else 
  {
    if (direction == 0) 
      extruder_forward();
    else 
      extruder_reverse();
  }
  pwmSet(0);    
  currentDirection = direction;
 _asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
 _endasm;
}
#pragma restore

#pragma save
#pragma nooverlay
void timerTick()
{
  // There are two temperatures temperatureLimit0 and temperatureLimit1.
  // When colder than temperatureLimit0, the heater runs at
  // the power specified by requestedHeat1.  If it is between
  // temperatureLimit0 and temperatureLimit1 then it runs at the
  // lower power setting requestedHeat0.  If it is hotter than
  // temperatureLimit1, the power shuts down completely.
  if ((lastTemperature < 0x10) || (temperatureNotUpdatedCounter > 100)) { 
	  //minimum time for the measurement, we don't know if the temperature is lower
	  //or we were unable to update the measurement -> we don't know if the temperature is to high
    heater_off();  
  } else if (lastTemperature <= temperatureLimit1) {
    // Reached critical limit, so power off
    heater_off();
  } else if ((lastTemperature <= temperatureLimit0) &&
	     (heatCounter >= requestedHeat1) && (requestedHeat1 != 255)) {
    // In medium zone, heater off period (based on high heat power)
    heater_off();
  } else if ((lastTemperature > temperatureLimit0) &&
	     (heatCounter >= requestedHeat0) && (requestedHeat0 != 255)) {
    // In low zone, heater off period (based on low heat power)
    heater_off();
  } else {
    // Heater on
    heater_on();
  }
  heatCounter++;
  TMR1H = HEATER_PWM_PERIOD;
  TMR1L = 0;
  
  if(solenoid_on)
  {
  	if(pulseCounter2 == 0)
  	{
    	if(pulseCounter1 == 0)
  		{
  			portaval &= BIN(11111010);
  			PORTA = portaval;
  			solenoid_on = 0;
  		} else
  		{
  	  		pulseCounter1--;
  	  		pulseCounter2 = PC2;
  		}
  	} else
  	  pulseCounter2--;
  }

_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
_endasm;
}
#pragma restore


#pragma save
#pragma nooverlay
//will not be called with UNIVERSIAL_PCB, because RBIF will never be set
//except if connector 11 is used. RB7, RB6 are unused, RB5, RB4 are output
void motorTick()
{
  // Clear interrupt flag
  RBIF = 0;
  
  change_log();  //not correct for UNIVERSIAL_PCB

  if (extrude_click) {
      
      // Adjust counter appropriately based on last known direction
      if (currentDirection)
	currentPosition.ival--;
      else
	currentPosition.ival++;
      
      if ((seekSpeed != 0) && (currentPosition.ival == seekPosition.ival)) {
	// Turn off motor
	extruder_stop();
    }
  }
  
  if (material_click) {
    if (sendMessageISR(seekNotify)) { 
      //if we cannot send, then the notify is lost (RBIF is a onchange-Interrupt)
      //TODO: maybe save the message and send later or save it and send 
      //      in the main-loop
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


#pragma save
#pragma nooverlay
void checkTemperature()
{
  // Assumes:
  // A6 is a reference resistor
  // A7 is thermistor
  // A1 is comparator

  byte tmpLastTemperature; 
  byte i;
  
  //we need a random-faktor, otherwise we have times where the timerTick always occurs during our tempMeasurement.
  for (i=temperatureNotUpdatedCounter; i>0; i--) {
    __asm
      nop
    __endasm;
  }
  
  // Assume capacitor is discharged from previous round or powerup

  // Set Timer0 to timer mode and use watchdog prescaler
  T0CS = 0;
  PSA = 0;
  CMCON = BIN(00000010);

  // Set vref to test level and give it time to stabilise
  VRCON = BIN(10000000) | temperatureVRef;
  delay_10us();
  // Set A7 to high, float others
  // Use 8 bit Timer0 to measure time
  // Wait for cap to reach vref
  GIE = 0;
  T0IF = 0;
  portaval &= BIN(00111101);
  portaval |= BIN(10000000);
  TRISA = BIN(01000010) | PORTATRIS;
  PORTA = portaval;  //must be set after TRISA
  TMR0 = 0; 
  interruptTemp = 0;
  GIE = 1;
  
  //if lastTemperature is to low and prescaler is set to 0, then the duration of
  // the measurement inhibits, that lastTemperature is getting lower -> it could happen
  // that temperatureLimit1 is never reached and the heater is always on!!!
  // Therefore I have added a test in timerTick() for the minimal value (== minimal time for measurement)
  while (C2OUT) 
    ; 
  GIE = 0;
  tmpLastTemperature = TMR0;
  if (T0IF) {
    tmpLastTemperature = 255;
  } 
  if (interruptTemp == 1) {
    temperatureNotUpdatedCounter++;
  } else {
    lastTemperature = tmpLastTemperature;
    temperatureNotUpdatedCounter = 0;
  }
  GIE = 1;
  
  if (temperatureNotUpdatedCounter == 255)
     temperatureNotUpdatedCounter--;  //to prevent an overflow

  delay_10us(); //to handle interrupts

  //
  // Discharge cap
  // Set A7, A6, A1 to low and output
  GIE = 0;
  portaval &= BIN(00111101);
  TRISA = BIN(00000000) | PORTATRIS;
  PORTA = portaval;
  GIE = 1;

  // Set vref to low
  VRCON = BIN(10100000); //should be 1010xxxx to not output value
                         //maybe should be >0 if we cannot fully unload to 0 
			 //VRCON = BIN(10100000) do not work for me
  delay_10us();
  // Wait for voltage to reach 0
  while (!C2OUT)
    ;
  // Extra delay for full discharge
  delay_10us();
  delay_10us();

  TRISA = BIN(11000010) | PORTATRIS;
  VRCON = 0;  // Turn off vref

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
    sendDataByte(THERMOPLASTIC_EXTRUDER_TYPE);
    endMessage();
    break;

// Extrude speed takes precedence over fan speed
  case CMD_FORWARD:
    seekSpeed = buffer[1];
    setSpeed(0);
    break;

  case CMD_REVERSE:
    seekSpeed = buffer[1];
    setSpeed(1);
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
	setSpeed(1);
      else
	setSpeed(0);
    }

    break;

  case CMD_FREE:
    // Free motor.  There is no torque hold for a DC motor,
    // so all we do is switch off
    extruder_stop();
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
    GIE=0;
    requestedHeat0 = buffer[1];
    requestedHeat1 = buffer[2];
    temperatureLimit0 = buffer[3];
    temperatureLimit1 = buffer[4];
    GIE=1;
    break;

  case CMD_GETTEMP:
    sendReply();
    sendDataByte(CMD_GETTEMP);
    sendDataByte(lastTemperature);
    sendDataByte(0);
    endMessage();
    break;

  case CMD_SETCOOLER:
  	set_cooler(buffer[1]);
//#ifdef UNIVERSAL_PCB
//	if(buffer[1] && !seekSpeed)
//	{
//		seekSpeed = buffer[1];
//   	pwmSet(0);
//    }
//#endif
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
    GIE=0;
    temperatureVRef = buffer[1];
    GIE=1;
    break;

  case CMD_SETTEMPSCALER:
    GIE=0;
    OPTION_REG = (OPTION_REG & BIN(11111000)) | (buffer[1] & BIN(111));
    GIE=1;
    break;

  case CMD_GETDEBUGINFO:
    sendReply();
    sendDataByte(CMD_GETDEBUGINFO);
    sendDataByte(heatCounter);
    sendDataByte(PORTA);
    sendDataByte(TRISA);
    sendDataByte(OPTION_REG);
    sendDataByte(temperatureVRef);
    endMessage();
    break;

  case CMD_GETTEMPINFO:
    sendReply();
    sendDataByte(CMD_GETTEMPINFO);
    sendDataByte(requestedHeat0);
    sendDataByte(requestedHeat1);
    sendDataByte(temperatureLimit0);
    sendDataByte(temperatureLimit1);
    sendDataByte(lastTemperature);
    sendDataByte(temperatureNotUpdatedCounter);
    endMessage();
    break;
    
  case CMD_VALVEOPEN:
    solenoid(1);
  	break;
  	
  case CMD_VALVECLOSED:
    solenoid(0);
  	break;
											
  }

_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _currentPosition
_endasm;
}

// To work around sdcc issue
void dummy()
{
  INTCON = 0;
}
