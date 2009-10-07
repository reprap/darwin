#include "WProgram.h"
void init_extruder();
void wait_for_heater();
void valve_set(bool open, int millis);
void extruder_set_direction(bool direction);
void extruder_set_speed(byte speed);
void extruder_set_cooler(byte speed);
void extruder_set_temperature(int temp);
int extruder_get_temperature();
int extruder_read_thermistor();
int extruder_read_thermocouple();
int extruder_sample_temperature(byte pin);
void extruder_manage_temperature();
void extruder_heater_test();
void extruder_drive_test();
void extruder_valve_test();
void extruder_fan_test();
void init_process_string();
int parse_string(struct GcodeParser * gc, char instruction[], int size);
void process_string(char instruction[], int size);
int scan_float(char *str, float *valp, unsigned int *seen, unsigned int flag);
int scan_int(char *str, int *valp, unsigned int *seen, unsigned int flag);
void comms_test();
void init_steppers();
void dda_move(long micro_delay);
bool can_step(byte min_pin, byte max_pin, long current, long target, byte direction);
void do_step(byte step_pin);
bool read_switch(byte pin);
long to_steps(float steps_per_unit, float units);
void set_target(float x, float y, float z);
void set_position(float x, float y, float z);
void calculate_deltas();
long calculate_feedrate_delay(float feedrate);
long getMaxSpeed();
void enable_steppers();
void disable_steppers();
void delayMicrosecondsInterruptible(unsigned int us);
void X_motor_test();
void Y_motor_test();
void Z_motor_test();
#include "ctype.h"
#include "HardwareSerial.h"
#include "parameters.h"
#include "pins.h"
#include "ThermistorTable.h"
// Yep, this is actually -*- c++ -*-

// Sanguino G-code Interpreter
// Arduino v1.0 by Mike Ellery - initial software (mellery@gmail.com)
// v1.1 by Zach Hoeken - cleaned up and did lots of tweaks (hoeken@gmail.com)
// v1.2 by Chris Meighan - cleanup / G2&G3 support (cmeighan@gmail.com)
// v1.3 by Zach Hoeken - added thermocouple support and multi-sample temp readings. (hoeken@gmail.com)
// Sanguino v1.4 by Adrian Bowyer - switch to the Sanguino; extensive mods... (a.bowyer@bath.ac.uk)

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



// Yep, this is actually -*- c++ -*-

#define EXTRUDER_0_FORWARD true
#define EXTRUDER_0_REVERSE false

//these our the default values for the extruder.
int extruder_speed = 128;
int extruder_target_celsius = 0;
int extruder_max_celsius = 0;
byte extruder_heater_low = 64;
byte extruder_heater_high = 255;
byte extruder_heater_current = 0;

//this is for doing encoder based extruder control
int extruder_rpm = 0;
long extruder_delay = 0;
int extruder_error = 0;
int last_extruder_error = 0;
int extruder_error_delta = 0;
bool extruder_direction = EXTRUDER_0_FORWARD;
bool valve_open = false;

void init_extruder()
{
	//default to cool...
	extruder_set_temperature(-273);
	
	//setup our pins
	pinMode(EXTRUDER_0_MOTOR_DIR_PIN, OUTPUT);
	pinMode(EXTRUDER_0_MOTOR_SPEED_PIN, OUTPUT);
	pinMode(EXTRUDER_0_HEATER_PIN, OUTPUT);
	pinMode(EXTRUDER_0_FAN_PIN, OUTPUT);
	pinMode(EXTRUDER_0_VALVE_DIR_PIN, OUTPUT); 
        pinMode(EXTRUDER_0_VALVE_ENABLE_PIN, OUTPUT);

	//initialize values
	digitalWrite(EXTRUDER_0_MOTOR_DIR_PIN, EXTRUDER_0_FORWARD);
	analogWrite(EXTRUDER_0_FAN_PIN, 0);
	analogWrite(EXTRUDER_0_HEATER_PIN, 0);
	analogWrite(EXTRUDER_0_MOTOR_SPEED_PIN, 0);
	digitalWrite(EXTRUDER_0_VALVE_DIR_PIN, false);
	digitalWrite(EXTRUDER_0_VALVE_ENABLE_PIN, 0);
}

void wait_for_heater()
{
  //warmup if we're too cold.
  while (extruder_get_temperature() < (extruder_target_celsius - 5))
  {
	extruder_manage_temperature();
	//Serial.print("T: ");
        //Serial.println(extruder_get_temperature());
	delay(1000);
  }  
}

void valve_set(bool open, int millis)
{
        wait_for_heater();
	valve_open = open;
	digitalWrite(EXTRUDER_0_VALVE_DIR_PIN, open);
        digitalWrite(EXTRUDER_0_VALVE_ENABLE_PIN, 1);
        delay(millis);
        digitalWrite(EXTRUDER_0_VALVE_ENABLE_PIN, 0);
        digitalWrite(EXTRUDER_0_VALVE_DIR_PIN, 0);
}


void extruder_set_direction(bool direction)
{
	extruder_direction = direction;
	digitalWrite(EXTRUDER_0_MOTOR_DIR_PIN, direction);
}

void extruder_set_speed(byte speed)
{
        if(speed > 0)
          wait_for_heater();
	analogWrite(EXTRUDER_0_MOTOR_SPEED_PIN, speed);
}

void extruder_set_cooler(byte speed)
{
	analogWrite(EXTRUDER_0_FAN_PIN, speed);
}

void extruder_set_temperature(int temp)
{
	extruder_target_celsius = temp;
	extruder_max_celsius = (int)((float)temp * 1.1);
}

/**
*  Samples the temperature and converts it to degrees celsius.
*  Returns degrees celsius.
*/
int extruder_get_temperature()
{
	if (EXTRUDER_0_THERMISTOR_PIN > -1)
		return extruder_read_thermistor();
	else if (EXTRUDER_0_THERMOCOUPLE_PIN > -1)
		return extruder_read_thermocouple();
}

/*
* This function gives us the temperature from the thermistor in Celsius
*/

int extruder_read_thermistor()
{
	int raw = extruder_sample_temperature(EXTRUDER_0_THERMISTOR_PIN);

	int celsius = 0;
	byte i;

	for (i=1; i<NUMTEMPS; i++)
	{
		if (temptable[i][0] > raw)
		{
			celsius  = temptable[i-1][1] + 
				(raw - temptable[i-1][0]) * 
				(temptable[i][1] - temptable[i-1][1]) /
				(temptable[i][0] - temptable[i-1][0]);

			break;
		}
	}

        // Overflow: Set to last value in the table
        if (i == NUMTEMPS) celsius = temptable[i-1][1];
        // Clamp to byte
        if (celsius > 255) celsius = 255; 
        else if (celsius < 0) celsius = 0; 

	return celsius;
}

/*
* This function gives us the temperature from the thermocouple in Celsius
*/
int extruder_read_thermocouple()
{
	return ( 5.0 * extruder_sample_temperature(EXTRUDER_0_THERMOCOUPLE_PIN) * 100.0) / 1024.0;
}

/*
* This function gives us an averaged sample of the analog temperature pin.
*/
int extruder_sample_temperature(byte pin)
{
	int raw = 0;
	
	//read in a certain number of samples
	for (byte i=0; i<TEMPERATURE_SAMPLES; i++)
		raw += analogRead(pin);
		
	//average the samples
	raw = raw/TEMPERATURE_SAMPLES;

	//send it back.
	return raw;
}

/*!
  Manages motor and heater based on measured temperature:
  o If temp is too low, don't start the motor
  o Adjust the heater power to keep the temperature at the target
 */
void extruder_manage_temperature()
{
	//make sure we know what our temp is.
	int current_celsius = extruder_get_temperature();
        byte newheat = 0;
  
        //put the heater into high mode if we're not at our target.
        if (current_celsius < extruder_target_celsius)
                newheat = extruder_heater_high;
        //put the heater on low if we're at our target.
        else if (current_celsius < extruder_max_celsius)
                newheat = extruder_heater_low;
        
        // Only update heat if it changed
        if (extruder_heater_current != newheat) {
                extruder_heater_current = newheat;
                analogWrite(EXTRUDER_0_HEATER_PIN, extruder_heater_current);
        }
}

#ifdef TEST_MACHINE

bool heat_on;

void extruder_heater_test()
{
  int t = extruder_get_temperature();
  if(t < 50 && !heat_on)
  {
    Serial.println("\n *** Turning heater on.\n");
    heat_on = true;
    analogWrite(EXTRUDER_0_HEATER_PIN, extruder_heater_high);
  }

  if(t > 100 && heat_on)
  {
    Serial.println("\n *** Turning heater off.\n");
    heat_on = false;
    analogWrite(EXTRUDER_0_HEATER_PIN, 0);
  } 
 
  Serial.print("Temperature: ");
  Serial.print(t);
  Serial.print(" deg C. The heater is ");
  if(heat_on)
    Serial.println("on.");
  else
    Serial.println("off.");
  
  delay(2000);  
}

void extruder_drive_test()
{
    Serial.println("Turning the extruder motor on forwards for 5 seconds.");
    extruder_set_direction(true);
    extruder_set_speed(200);
    delay(5000);
    extruder_set_speed(0);
    Serial.println("Pausing for 2 seconds.");
    delay(2000);  
    Serial.println("Turning the extruder motor on backwards for 5 seconds.");
    extruder_set_direction(false);
    extruder_set_speed(200);
    delay(5000);
    extruder_set_speed(0);    
    Serial.println("Pausing for 2 seconds.");
    delay(2000);
}

void extruder_valve_test()
{
    Serial.println("Opening the valve.");
    valve_set(true, 500);
    Serial.println("Pausing for 2 seconds.");
    delay(2000);  
    Serial.println("Closing the valve.");
    valve_set(false, 500);
    Serial.println("Pausing for 2 seconds.");
    delay(2000);  
}

void extruder_fan_test()
{
    Serial.println("Fan on.");
    extruder_set_cooler(255);
    Serial.println("Pausing for 2 seconds.");
    delay(2000);  
    Serial.println("Fan off.");
    extruder_set_cooler(0);
    Serial.println("Pausing for 2 seconds.");
    delay(2000);  
}



#endif

// Yep, this is actually -*- c++ -*-

// our point structure to make things nice.
struct LongPoint
{
	long x;
	long y;
	long z;
};

struct FloatPoint
{
	float x;
	float y;
	float z;
};

/* gcode line parse results */
struct GcodeParser
{
    unsigned int seen;
    int G;
    int M;
    float P;
    float X;
    float Y;
    float Z;
    float I;
    float J;
    float F;
    float S;
    float R;
    float Q;
};

FloatPoint current_units;
FloatPoint target_units;
FloatPoint delta_units;

FloatPoint current_steps;
FloatPoint target_steps;
FloatPoint delta_steps;

boolean abs_mode = true; //0 = incremental; 1 = absolute

//default to mm for units
float x_units = X_STEPS_PER_MM;
float y_units = Y_STEPS_PER_MM;
float z_units = Z_STEPS_PER_MM;
float curve_section = CURVE_SECTION_MM;

//our direction vars
byte x_direction = 1;
byte y_direction = 1;
byte z_direction = 1;

int scan_int(char *str, int *valp);
int scan_float(char *str, float *valp);

//init our string processing
void init_process_string()
{
	//init our command
	//for (byte i=0; i<COMMAND_SIZE; i++)
	//	word[i] = 0;
	serial_count = 0;
        comment = false;
}

//our feedrate variables.
float feedrate = 0.0;
long feedrate_micros = 0;

/* keep track of the last G code - this is the command mode to use
 * if there is no command in the current string 
 */
int last_gcode_g = -1;

/* bit-flags for commands and parameters */
#define GCODE_G	(1<<0)
#define GCODE_M	(1<<1)
#define GCODE_P	(1<<2)
#define GCODE_X	(1<<3)
#define GCODE_Y	(1<<4)
#define GCODE_Z	(1<<5)
#define GCODE_I	(1<<6)
#define GCODE_J	(1<<7)
#define GCODE_K	(1<<8)
#define GCODE_F	(1<<9)
#define GCODE_S	(1<<10)
#define GCODE_Q	(1<<11)
#define GCODE_R	(1<<12)

#define TYPE_INT 1
#define TYPE_FLOAT 2


#define PARSE_INT(ch, str, len, val, seen, flag) \
	case ch: \
		len = scan_int(str, &val, &seen, flag); \
		break;

#define PARSE_FLOAT(ch, str, len, val, seen, flag) \
	case ch: \
		len = scan_float(str, &val, &seen, flag); \
		break;

int parse_string(struct GcodeParser * gc, char instruction[], int size)
{
	int ind;
	int len;	/* length of parameter argument */

	gc->seen = 0;

	len=0;
	/* scan the string for commands and parameters, recording the arguments for each,
	 * and setting the seen flag for each that is seen
	 */
	for (ind=0; ind<size; ind += (1+len))
	{
		len = 0;
		switch (instruction[ind])
		{
			  PARSE_INT('G', &instruction[ind+1], len, gc->G, gc->seen, GCODE_G);
			  PARSE_INT('M', &instruction[ind+1], len, gc->M, gc->seen, GCODE_M);
			PARSE_FLOAT('S', &instruction[ind+1], len, gc->S, gc->seen, GCODE_S);
			PARSE_FLOAT('P', &instruction[ind+1], len, gc->P, gc->seen, GCODE_P);
			PARSE_FLOAT('X', &instruction[ind+1], len, gc->X, gc->seen, GCODE_X);
			PARSE_FLOAT('Y', &instruction[ind+1], len, gc->Y, gc->seen, GCODE_Y);
			PARSE_FLOAT('Z', &instruction[ind+1], len, gc->Z, gc->seen, GCODE_Z);
			PARSE_FLOAT('I', &instruction[ind+1], len, gc->I, gc->seen, GCODE_I);
			PARSE_FLOAT('J', &instruction[ind+1], len, gc->J, gc->seen, GCODE_J);
			PARSE_FLOAT('F', &instruction[ind+1], len, gc->F, gc->seen, GCODE_F);
			PARSE_FLOAT('R', &instruction[ind+1], len, gc->R, gc->seen, GCODE_R);
			PARSE_FLOAT('Q', &instruction[ind+1], len, gc->Q, gc->seen, GCODE_Q);
                        default:
			  break;
		}
	}
}


//Read the string and execute instructions
void process_string(char instruction[], int size)
{

	GcodeParser gc;	/* string parse result */

	//the character / means delete block... used for comments and stuff.
	if (instruction[0] == '/')	
		return;

	//init baby!
	FloatPoint fp; 
	fp.x = 0.0;
	fp.y = 0.0;
	fp.z = 0.0;

	//get all our parameters!
	parse_string(&gc, instruction, size);
	/* if no command was seen, but parameters were, then use the last G code as 
	 * the current command
	 */
	if ((!(gc.seen & (GCODE_G | GCODE_M))) && 
	    ((gc.seen != 0) &&
		(last_gcode_g >= 0))
	)
	{
		/* yes - so use the previous command with the new parameters */
		gc.G = last_gcode_g;
		gc.seen |= GCODE_G;
	}
	//did we get a gcode?
	if (gc.seen & GCODE_G)
	{
		last_gcode_g = gc.G;	/* remember this for future instructions */
		fp = current_units;
		if (abs_mode)
		{
			if (gc.seen & GCODE_X)
				fp.x = gc.X;
			if (gc.seen & GCODE_Y)
				fp.y = gc.Y;
			if (gc.seen & GCODE_Z)
				fp.z = gc.Z;
		}
		else
		{
			if (gc.seen & GCODE_X)
				fp.x += gc.X;
			if (gc.seen & GCODE_Y)
				fp.y += gc.Y;
			if (gc.seen & GCODE_Z)
				fp.z += gc.Z;
		}

		// Get feedrate if supplied
		if ( gc.seen & GCODE_F )
			feedrate = gc.F;

		//do something!
		switch (gc.G)
		{
			//Rapid Positioning
			//Linear Interpolation
			//these are basically the same thing.
			case 0:
			case 1:
				//set our target.
				set_target(fp.x, fp.y, fp.z);

				// Use currently set feedrate if doing a G1
				if (gc.G == 1)
					feedrate_micros = calculate_feedrate_delay(feedrate);
				// Use our max for G0
				else
					feedrate_micros = getMaxSpeed();
				//finally move.
				dda_move(feedrate_micros);
				break;
#ifdef SANGUINO
// No room for this in the Arduino
			//Clockwise arc
			case 2:
			//Counterclockwise arc
			case 3:
			{
				FloatPoint cent;

				// Centre coordinates are always relative
				if (gc.seen & GCODE_I) cent.x = current_units.x + gc.I;
				else cent.x = current_units.x;
				if (gc.seen & GCODE_J) cent.y = current_units.y + gc.J;

				float angleA, angleB, angle, radius, length, aX, aY, bX, bY;

				aX = (current_units.x - cent.x);
				aY = (current_units.y - cent.y);
				bX = (fp.x - cent.x);
				bY = (fp.y - cent.y);

				// Clockwise
				if (gc.G == 2)
				{
					angleA = atan2(bY, bX);
					angleB = atan2(aY, aX);
				}
				// Counterclockwise
				else
				{
					angleA = atan2(aY, aX);
					angleB = atan2(bY, bX);
				}

				// Make sure angleB is always greater than angleA
				// and if not add 2PI so that it is (this also takes
				// care of the special case of angleA == angleB,
				// ie we want a complete circle)
				if (angleB <= angleA)
					angleB += 2 * M_PI;
				angle = angleB - angleA;

				radius = sqrt(aX * aX + aY * aY);
				length = radius * angle;
				int steps, s, step;

				// Maximum of either 2.4 times the angle in radians or the length of the curve divided by the constant specified in _init.pde
				steps = (int) ceil(max(angle * 2.4, length / curve_section));

				FloatPoint newPoint;
				float arc_start_z = current_units.z;
				for (s = 1; s <= steps; s++)
				{
					step = (gc.G == 3) ? s : steps - s; // Work backwards for CW
					newPoint.x = cent.x + radius * cos(angleA + angle
							* ((float) step / steps));
					newPoint.y = cent.y + radius * sin(angleA + angle
							* ((float) step / steps));
					set_target(newPoint.x, newPoint.y, arc_start_z + (fp.z
							- arc_start_z) * s / steps);

					// Need to calculate rate for each section of curve
					if (feedrate > 0)
						feedrate_micros = calculate_feedrate_delay(feedrate);
					else
						feedrate_micros = getMaxSpeed();

					// Make step
					dda_move(feedrate_micros);
				}
			}
			break;
#endif
			
			case 4: //Dwell
				delay((int)(gc.P + 0.5));  // Changed by AB from 1000*gc.P
				break;

				//Inches for Units
			case 20:
				x_units = X_STEPS_PER_INCH;
				y_units = Y_STEPS_PER_INCH;
				z_units = Z_STEPS_PER_INCH;
				curve_section = CURVE_SECTION_INCHES;

				calculate_deltas();
				break;

				//mm for Units
			case 21:
				x_units = X_STEPS_PER_MM;
				y_units = Y_STEPS_PER_MM;
				z_units = Z_STEPS_PER_MM;
				curve_section = CURVE_SECTION_MM;

				calculate_deltas();
				break;

				//go home.
			case 28:
				set_target(0.0, 0.0, 0.0);
				dda_move(getMaxSpeed());
				break;

				//go home via an intermediate point.
			case 30:
				//set our target.
				set_target(fp.x, fp.y, fp.z);

				//go there.
				dda_move(getMaxSpeed());

				//go home.
				set_target(0.0, 0.0, 0.0);
				dda_move(getMaxSpeed());
				break;

			// Drilling canned cycles
			case 81: // Without dwell
			case 82: // With dwell
			case 83: // Peck drilling
			{
				float retract = gc.R;
				
				if (!abs_mode)
					retract += current_units.z;

				// Retract to R position if Z is currently below this
				if (current_units.z < retract)
				{
					set_target(current_units.x, current_units.y, retract);
					dda_move(getMaxSpeed());
				}

				// Move to start XY
				set_target(fp.x, fp.y, current_units.z);
				dda_move(getMaxSpeed());

				// Do the actual drilling
				float target_z = retract;
				float delta_z;

				// For G83 move in increments specified by Q code, otherwise do in one pass
				if (gc.G == 83)
					delta_z = gc.Q;
				else
					delta_z = retract - fp.z;

				do {
					// Move rapidly to bottom of hole drilled so far (target Z if starting hole)
					set_target(fp.x, fp.y, target_z);
					dda_move(getMaxSpeed());

					// Move with controlled feed rate by delta z (or to bottom of hole if less)
					target_z -= delta_z;
					if (target_z < fp.z)
						target_z = fp.z;
					set_target(fp.x, fp.y, target_z);
					if (feedrate > 0)
						feedrate_micros = calculate_feedrate_delay(feedrate);
					else
						feedrate_micros = getMaxSpeed();
					dda_move(feedrate_micros);

					// Dwell if doing a G82
					if (gc.G == 82)
						delay((int)(gc.P * 1000));

					// Retract
					set_target(fp.x, fp.y, retract);
					dda_move(getMaxSpeed());
				} while (target_z > fp.z);
			}
			break;

			
			case 90: //Absolute Positioning
				abs_mode = true;
				break;

			
			case 91: //Incremental Positioning
				abs_mode = false;
				break;

			
			case 92: //Set position as fp
				set_position(fp.x, fp.y, fp.z);
				break;

				/*
				 //Inverse Time Feed Mode
				 case 93:

				 break;  //TODO: add this

				 //Feed per Minute Mode
				 case 94:

				 break;  //TODO: add this
				 */

			default:
				Serial.print("huh? G");
				Serial.println(gc.G, DEC);
		}
	}

	//find us an m code.
	if (gc.seen & GCODE_M)
	{
		switch (gc.M)
		{
			//TODO: this is a bug because search_string returns 0.  gotta fix that.
			case 0:
				true;
				break;
				/*
				 case 0:
				 //todo: stop program
				 break;

				 case 1:
				 //todo: optional stop
				 break;

				 case 2:
				 //todo: program end
				 break;
				 */
				//turn extruder on, forward
			case 101:
				extruder_set_direction(1);
				extruder_set_speed(extruder_speed);
				break;

				//turn extruder on, reverse
			case 102:
				extruder_set_direction(0);
				extruder_set_speed(extruder_speed);
				break;

				//turn extruder off
			case 103:
				extruder_set_speed(0);
				break;

				//custom code for temperature control
			case 104:
				if (gc.seen & GCODE_S)
				{
					extruder_set_temperature((int)gc.S);

//					//warmup if we're too cold.
//					while (extruder_get_temperature() < extruder_target_celsius)
//					{
//						extruder_manage_temperature();
//						Serial.print("T: ");
//						Serial.println(extruder_get_temperature());
//						delay(1000);
//					}
				}
				break;

				//custom code for temperature reading
			case 105:
				Serial.print("T:");
				Serial.println(extruder_get_temperature());
				break;

				//turn fan on
			case 106:
				extruder_set_cooler(255);
				break;

				//turn fan off
			case 107:
				extruder_set_cooler(0);
				break;

				//set max extruder speed, 0-255 PWM
			case 108:
				if (gc.seen & GCODE_S)
					extruder_speed = (int)gc.S;
				break;

                                // Open the valve
                        case 126:
                                valve_set(true, (int)(gc.P + 0.5));
                                break;
                                
                                // Close the valve
                        case 127:
                                valve_set(false, (int)(gc.P + 0.5));
                                break;
                                                                

			default:
				Serial.print("Huh? M");
				Serial.println(gc.M, DEC);
		}
	}

}

int scan_float(char *str, float *valp, unsigned int *seen, unsigned int flag)
{
	float res;
	int len;
	char *end;
     
	res = (float)strtod(str, &end);
      
	len = end - str;

	if (len > 0)
	{
		*valp = res;
		*seen |= flag;
	}
	else
		*valp = 0;
          
	return len;	/* length of number */
}

int scan_int(char *str, int *valp, unsigned int *seen, unsigned int flag)
{
	int res;
	int len;
	char *end;

	res = (int)strtol(str, &end, 10);
	len = end - str;

	if (len > 0)
	{
		*valp = res;
		*seen |= flag;
	}
	else
		*valp = 0;
          
	return len;	/* length of number */
}

#ifdef TEST_MACHINE

// Read and echo bytes.

void comms_test()
{
  if (Serial.available() > 0)
        Serial.print((char)Serial.read());
}

#endif



// Yep, this is actually -*- c++ -*-

//init our variables
long max_delta;
long x_counter;
long y_counter;
long z_counter;
bool x_can_step;
bool y_can_step;
bool z_can_step;
int milli_delay;

#if INVERT_ENABLE_PINS == 1
#define ENABLE_ON LOW
#else
#define ENABLE_ON HIGH
#endif

#define ENDSTOPS_MIN_ENABLED 1

void init_steppers()
{
	//turn them off to start.
#ifdef SANGUINO
	disable_steppers();
#endif
	
	//init our points.
	current_units.x = 0.0;
	current_units.y = 0.0;
	current_units.z = 0.0;
	target_units.x = 0.0;
	target_units.y = 0.0;
	target_units.z = 0.0;
	
	pinMode(X_STEP_PIN, OUTPUT);
	pinMode(X_DIR_PIN, OUTPUT);
	pinMode(Y_STEP_PIN, OUTPUT);
	pinMode(Y_DIR_PIN, OUTPUT);
	pinMode(Z_STEP_PIN, OUTPUT);
	pinMode(Z_DIR_PIN, OUTPUT);

#ifdef SANGUINO
	pinMode(X_ENABLE_PIN, OUTPUT);
	pinMode(Y_ENABLE_PIN, OUTPUT);
	pinMode(Z_ENABLE_PIN, OUTPUT);
#endif

#if ENDSTOPS_MIN_ENABLED == 1
	pinMode(X_MIN_PIN, INPUT);
	pinMode(Y_MIN_PIN, INPUT);
	pinMode(Z_MIN_PIN, INPUT);
#endif
#if ENDSTOPS_MAX_ENABLED == 1
	pinMode(X_MAX_PIN, INPUT);
	pinMode(Y_MAX_PIN, INPUT);
	pinMode(Z_MAX_PIN, INPUT);
#endif
	
	//figure our stuff.
	calculate_deltas();
}

void dda_move(long micro_delay)
{
	//turn on steppers to start moving =)
#ifdef SANGUINO
	enable_steppers();
#endif
	
	//figure out our deltas
	max_delta = max(delta_steps.x, delta_steps.y);
	max_delta = max(delta_steps.z, max_delta);

	//init stuff.
	long x_counter = -max_delta/2;
	long y_counter = -max_delta/2;
	long z_counter = -max_delta/2;
	
	//our step flags
	bool x_can_step = 0;
	bool y_can_step = 0;
	bool z_can_step = 0;

	//how long do we delay for?
	if (micro_delay >= 16383)
		milli_delay = micro_delay / 1000;
	else
		milli_delay = 0;

	//do our DDA line!
	do
	{
		x_can_step = can_step(X_MIN_PIN, X_MAX_PIN, current_steps.x, target_steps.x, x_direction);
		y_can_step = can_step(Y_MIN_PIN, Y_MAX_PIN, current_steps.y, target_steps.y, y_direction);
		z_can_step = can_step(Z_MIN_PIN, Z_MAX_PIN, current_steps.z, target_steps.z, z_direction);

		if (x_can_step)
		{
			x_counter += delta_steps.x;
			
			if (x_counter > 0)
			{
				do_step(X_STEP_PIN);
				x_counter -= max_delta;
				
				if (x_direction)
					current_steps.x++;
				else
					current_steps.x--;
			}
		}

		if (y_can_step)
		{
			y_counter += delta_steps.y;
			
			if (y_counter > 0)
			{
				do_step(Y_STEP_PIN);
				y_counter -= max_delta;

				if (y_direction)
					current_steps.y++;
				else
					current_steps.y--;
			}
		}
		
		if (z_can_step)
		{
			z_counter += delta_steps.z;
			
			if (z_counter > 0)
			{
				do_step(Z_STEP_PIN);
				z_counter -= max_delta;
				
				if (z_direction)
					current_steps.z++;
				else
					current_steps.z--;
			}
		}
		
		//keep it hot =)
		extruder_manage_temperature();
				
		//wait for next step.
		if (milli_delay > 0)
			delay(milli_delay);			
		else
			delayMicrosecondsInterruptible(micro_delay);
	}
	while (x_can_step || y_can_step || z_can_step);
	
	//set our points to be the same
	current_units.x = target_units.x;
	current_units.y = target_units.y;
	current_units.z = target_units.z;
	calculate_deltas();
}

bool can_step(byte min_pin, byte max_pin, long current, long target, byte direction)
{
	//stop us if we're on target
	if (target == current)
		return false;
#if ENDSTOPS_MIN_ENABLED == 1
	//stop us if we're at home and still going 
	else if (read_switch(min_pin) && !direction)
		return false;
#endif
#if ENDSTOPS_MAX_ENABLED == 1
	//stop us if we're at max and still going
 	else if (read_switch(max_pin) && direction)
 		return false;
#endif

	//default to being able to step
	return true;
}

void do_step(byte step_pin)
{
	digitalWrite(step_pin, HIGH);
	delayMicroseconds(5);
	digitalWrite(step_pin, LOW);
}

bool read_switch(byte pin)
{
	//dual read as crude debounce
	#if ENDSTOPS_INVERTING == 1
		return !digitalRead(pin) && !digitalRead(pin);
	#else
		return digitalRead(pin) && digitalRead(pin);
	#endif
}

long to_steps(float steps_per_unit, float units)
{
	return steps_per_unit * units;
}

void set_target(float x, float y, float z)
{
	target_units.x = x;
	target_units.y = y;
	target_units.z = z;
	
	calculate_deltas();
}

void set_position(float x, float y, float z)
{
	current_units.x = x;
	current_units.y = y;
	current_units.z = z;
	
	calculate_deltas();
}

void calculate_deltas()
{
	//figure our deltas.
	delta_units.x = abs(target_units.x - current_units.x);
	delta_units.y = abs(target_units.y - current_units.y);
	delta_units.z = abs(target_units.z - current_units.z);
				
	//set our steps current, target, and delta
	current_steps.x = to_steps(x_units, current_units.x);
	current_steps.y = to_steps(y_units, current_units.y);
	current_steps.z = to_steps(z_units, current_units.z);

	target_steps.x = to_steps(x_units, target_units.x);
	target_steps.y = to_steps(y_units, target_units.y);
	target_steps.z = to_steps(z_units, target_units.z);

	delta_steps.x = abs(target_steps.x - current_steps.x);
	delta_steps.y = abs(target_steps.y - current_steps.y);
	delta_steps.z = abs(target_steps.z - current_steps.z);
	
	//what is our direction
	x_direction = (target_units.x >= current_units.x);
	y_direction = (target_units.y >= current_units.y);
	z_direction = (target_units.z >= current_units.z);

	//set our direction pins as well
#if INVERT_X_DIR == 1
	digitalWrite(X_DIR_PIN, !x_direction);
#else
	digitalWrite(X_DIR_PIN, x_direction);
#endif
#if INVERT_Y_DIR == 1
	digitalWrite(Y_DIR_PIN, !y_direction);
#else
	digitalWrite(Y_DIR_PIN, y_direction);
#endif
#if INVERT_Z_DIR == 1
	digitalWrite(Z_DIR_PIN, !z_direction);
#else
	digitalWrite(Z_DIR_PIN, z_direction);
#endif
}


long calculate_feedrate_delay(float feedrate)
{
	//how long is our line length?
	float distance = sqrt(delta_units.x*delta_units.x + 
                              delta_units.y*delta_units.y + 
                              delta_units.z*delta_units.z);
	long master_steps = 0;
	
	//find the dominant axis.
	if (delta_steps.x > delta_steps.y)
	{
		if (delta_steps.z > delta_steps.x)
			master_steps = delta_steps.z;
		else
			master_steps = delta_steps.x;
	}
	else
	{
		if (delta_steps.z > delta_steps.y)
			master_steps = delta_steps.z;
		else
			master_steps = delta_steps.y;
	}

	//calculate delay between steps in microseconds.  this is sort of tricky, but not too bad.
	//the formula has been condensed to save space.  here it is in english:
        // (feedrate is in mm/minute)
	// distance / feedrate * 60000000.0 = move duration in microseconds
	// move duration / master_steps = time between steps for master axis.

	return ((distance * 60000000.0) / feedrate) / master_steps;	
}

long getMaxSpeed()
{
	if (delta_steps.z > 0)
		return calculate_feedrate_delay(FAST_Z_FEEDRATE);
	else
		return calculate_feedrate_delay(FAST_XY_FEEDRATE);
}

#ifdef SANGUINO
void enable_steppers()
{
	// Enable steppers only for axes which are moving
	// taking account of the fact that some or all axes
	// may share an enable line (check using macros at
	// compile time to avoid needless code)
	if ( target_units.x == current_units.x
		#if X_ENABLE_PIN == Y_ENABLE_PIN
		     && target_units.y == current_units.y
		#endif
		#if X_ENABLE_PIN == Z_ENABLE_PIN
		     && target_units.z == current_units.z
		#endif
	)
		digitalWrite(X_ENABLE_PIN, !ENABLE_ON);
	else
		digitalWrite(X_ENABLE_PIN, ENABLE_ON);
	if ( target_units.y == current_units.y
		#if Y_ENABLE_PIN == X_ENABLE_PIN
		     && target_units.x == current_units.x
		#endif
		#if Y_ENABLE_PIN == Z_ENABLE_PIN
		     && target_units.z == current_units.z
		#endif
	)
		digitalWrite(Y_ENABLE_PIN, !ENABLE_ON);
	else
		digitalWrite(Y_ENABLE_PIN, ENABLE_ON);
	if ( target_units.z == current_units.z
		#if Z_ENABLE_PIN == X_ENABLE_PIN
			&& target_units.x == current_units.x
		#endif
		#if Z_ENABLE_PIN == Y_ENABLE_PIN
			&& target_units.y == current_units.y
		#endif
	)
		digitalWrite(Z_ENABLE_PIN, !ENABLE_ON);
	else
		digitalWrite(Z_ENABLE_PIN, ENABLE_ON);
}

void disable_steppers()
{
	//disable our steppers
	digitalWrite(X_ENABLE_PIN, !ENABLE_ON);
	digitalWrite(Y_ENABLE_PIN, !ENABLE_ON);
	digitalWrite(Z_ENABLE_PIN, !ENABLE_ON);
}
#endif

void delayMicrosecondsInterruptible(unsigned int us)
{

#if F_CPU >= 16000000L
    // for the 16 MHz clock on most Arduino boards

	// for a one-microsecond delay, simply return.  the overhead
	// of the function call yields a delay of approximately 1 1/8 us.
	if (--us == 0)
		return;

	// the following loop takes a quarter of a microsecond (4 cycles)
	// per iteration, so execute it four times for each microsecond of
	// delay requested.
	us <<= 2;

	// account for the time taken in the preceeding commands.
	us -= 2;
#else
    // for the 8 MHz internal clock on the ATmega168

    // for a one- or two-microsecond delay, simply return.  the overhead of
    // the function calls takes more than two microseconds.  can't just
    // subtract two, since us is unsigned; we'd overflow.
	if (--us == 0)
		return;
	if (--us == 0)
		return;

	// the following loop takes half of a microsecond (4 cycles)
	// per iteration, so execute it twice for each microsecond of
	// delay requested.
	us <<= 1;
    
    // partially compensate for the time taken by the preceeding commands.
    // we can't subtract any more than this or we'd overflow w/ small delays.
    us--;
#endif

	// busy wait
	__asm__ __volatile__ (
		"1: sbiw %0,1" "\n\t" // 2 cycles
		"brne 1b" : "=w" (us) : "0" (us) // 2 cycles
	);
}

#ifdef TEST_MACHINE

void X_motor_test()
{
    Serial.println("Moving X forward by 100 mm at half maximum speed.");
    set_target(100, 0, 0);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_XY_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds.");
    delay(2000);
    
    Serial.println("Moving X back to the start.");
    set_target(0, 0, 0);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_XY_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds."); 
    delay(2000);   
}

void Y_motor_test()
{

    Serial.println("Moving Y forward by 100 mm at half maximum speed.");
    set_target(0, 100, 0);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_XY_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds.");
    delay(2000);
    
    Serial.println("Moving Y back to the start.");
    set_target(0, 0, 0);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_XY_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds."); 
    delay(2000);     
}

void Z_motor_test()
{
    Serial.println("Moving Z down by 5 mm at half maximum speed.");
    set_target(0, 0, 5);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_Z_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds.");
    delay(2000);
    
    Serial.println("Moving Z back to the start.");
    set_target(0, 0, 0);
    enable_steppers();
    dda_move(calculate_feedrate_delay(FAST_Z_FEEDRATE/2));
    
    Serial.println("Pause for 2 seconds."); 
    delay(2000);     
}

#endif

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

