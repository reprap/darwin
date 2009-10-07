// Yep, this is actually -*- c++ -*-

// Sanguino G-code Interpreter
// Arduino v1.0 by Mike Ellery - initial software (mellery@gmail.com)
// v1.1 by Zach Hoeken - cleaned up and did lots of tweaks (hoeken@gmail.com)
// v1.2 by Chris Meighan - cleanup / G2&G3 support (cmeighan@gmail.com)
// v1.3 by Zach Hoeken - added thermocouple support and multi-sample temp readings. (hoeken@gmail.com)
// Sanguino v1.4 by Adrian Bowyer - added the Sanguino; extensive mods... (a.bowyer@bath.ac.uk)

#include <ctype.h>
#include <HardwareSerial.h>
#include "WProgram.h"
#include "parameters.h"
#include "pins.h"
#include "extruder.h"



byte extruder_in_use = 0;
extruder ex0(EXTRUDER_0_MOTOR_DIR_PIN, EXTRUDER_0_MOTOR_SPEED_PIN , EXTRUDER_0_HEATER_PIN,
            EXTRUDER_0_FAN_PIN,  EXTRUDER_0_TEMPERATURE_PIN, EXTRUDER_0_VALVE_DIR_PIN,
            EXTRUDER_0_VALVE_ENABLE_PIN, EXTRUDER_0_STEP_ENABLE_PIN);
                     
extruder* ex[EXTRUDER_COUNT];

// Our interrupt function


SIGNAL(SIG_OUTPUT_COMPARE1A)
{
  ex[extruder_in_use]->interrupt();
}


void setup()
{
        ex[0] = &ex0;
	Serial.begin(19200);
	Serial.println("start");
	
	//other initialization.
	init_process_string();
	init_steppers();
}

void loop()
{
#ifndef TEST_MACHINE  


	//keep it hot!
	manage_all_extruders();
        get_and_do_command();
        
#else

// Run the parts of the machine as a test

// Do the comms test first.  It should echo
// what you type in a terminal window connected
// to the Sanguino.

#ifdef COMMS_TEST

  comms_test();
  
#else
  byte c = 0;
  if (Serial.available() > 0)
  {
        c = Serial.read();
        Serial.println(c);
  }
  if(c >= '0' && c <= '9')
  {
     extruder_in_use = c - '0';
     if(extruder_in_use >= EXTRUDER_COUNT)
        extruder_in_use = EXTRUDER_COUNT - 1;
  } else
  {
    switch(c)
    {      
      case 'x':
        X_motor_test();
        break;
      case 'y':
        Y_motor_test();
        break;
      case 'z':
        Z_motor_test();
        break;
      case 'h':
        ex[extruder_in_use]->heater_test();
        break;
      case 'e':
        ex[extruder_in_use]->drive_test();
        break;
      case 'v':
        ex[extruder_in_use]->valve_test();
        break;
      case 'f':
        ex[extruder_in_use]->fan_test();
        break;
      
    default:
      Serial.println("Commands:\n");
      Serial.println(" x - X motor test");
      Serial.println(" y - Y motor test");
      Serial.println(" z - Z motor test");
      Serial.println(" h - extruder heater test");
      Serial.println(" e - extruder drive test");
      Serial.println(" v - extruder valve test");
      Serial.println(" f - extruder fan test");
      Serial.println(" 0..9 - select extruder");
      Serial.println(" s - stop current test at the end of its cycle then print this list\n\n");
      Serial.print("Command: ");
    }
  }

#endif
    
#endif        
}
