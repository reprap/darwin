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


