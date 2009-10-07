// Yep, this is actually -*- c++ -*-

// Sanguino G-code Interpreter
// Arduino v1.0 by Mike Ellery - initial software (mellery@gmail.com)
// v1.1 by Zach Hoeken - cleaned up and did lots of tweaks (hoeken@gmail.com)
// v1.2 by Chris Meighan - cleanup / G2&G3 support (cmeighan@gmail.com)
// v1.3 by Zach Hoeken - added thermocouple support and multi-sample temp readings. (hoeken@gmail.com)
// Sanguino v1.4 by Adrian Bowyer - switch to the Sanguino; extensive mods... (a.bowyer@bath.ac.uk)

#include <ctype.h>
#include <HardwareSerial.h>

// Uncomment the next line to run stand-alone tests on the machine (also see the 
// ends of this, the process_string, the extruder, and the stepper_control tabs).
//#define TEST_MACHINE


//our command string
#define COMMAND_SIZE 128
char word[COMMAND_SIZE];
char c = '?';
byte serial_count = 0;
boolean comment = false;

void setup()
{
	//Do startup stuff here
	Serial.begin(19200);
	Serial.println("start");
	
	//other initialization.
	init_process_string();
	init_steppers();
	init_extruder();
}

void loop()
{
#ifndef TEST_MACHINE  


	//keep it hot!
	extruder_manage_temperature();

	//read in characters if we got them.
	if (Serial.available())
	{
		c = Serial.read();
                if(c == '\r')
                  c = '\n';
                // Throw away control chars except \n
                if(c >= ' ' || c == '\n')
                {

		  //newlines are ends of commands.
		  if (c != '\n')
		  {
			// Start of comment - ignore any bytes received from now on
			if (c == ';')
				comment = true;
				
			// If we're not in comment mode, add it to our array.
			if (!comment)
				word[serial_count++] = c;
		  }

                }
	}

        // Data runaway?
        if(serial_count >= COMMAND_SIZE)
          init_process_string();

	//if we've got a real command, do it
	if (serial_count && c == '\n')
	{
                // Terminate string
                word[serial_count] = 0;
                
		//process our command!
		process_string(word, serial_count);

		//clear command.
		init_process_string();

                // Say we're ready for the next one
                
                Serial.println("ok");
	}

#else

// Run the parts of the machine as a test

// Do the comms test first.  It should echo
// what you type in a terminal window connected
// to the Sanguino.

// If that works, comment out the next line to test the rest:
#define COMMS_TEST

#ifdef COMMS_TEST

  comms_test();
  
#else
  
  if (Serial.available() > 0)
  {
        c = Serial.read();
        Serial.println(c);
  }
        
  switch(c)
  {
    case 0:
      break;
      
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
      extruder_heater_test();
      break;
    case 'e':
      extruder_drive_test();
      break;
    case 'v':
      extruder_valve_test();
      break;
    case 'f':
      extruder_fan_test();
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
      Serial.println(" s - stop current test at the end of its cycle then print this list\n\n");
      Serial.print("Command: ");
      c = 0;
  }

#endif
    
#endif        
}
