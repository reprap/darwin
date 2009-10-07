// our point structure to make things nice.
struct LongPoint {
	long x;
	long y;
 	long z;
};

struct FloatPoint {
	float x;
	float y;
 	float z;
};

FloatPoint current_units;
FloatPoint target_units;
FloatPoint delta_units;

FloatPoint current_steps;
FloatPoint target_steps;
FloatPoint delta_steps;

boolean abs_mode = false;   //0 = incremental; 1 = absolute

//default to mm for units
float x_units = X_STEPS_PER_MM;
float y_units = Y_STEPS_PER_MM;
float z_units = Z_STEPS_PER_MM;
float curve_section = CURVE_SECTION_MM;

//our direction vars
byte x_direction = 1;
byte y_direction = 1;
byte z_direction = 1;

//init our string processing
void init_process_string()
{
	//init our command
	for (byte i=0; i<COMMAND_SIZE; i++)
		word[i] = 0;
	serial_count = 0;
}

//our feedrate variables.
float feedrate = 0.0;
long feedrate_micros = 0;

//Read the string and execute instructions
void process_string(char instruction[], int size)
{
	//the character / means delete block... used for comments and stuff.
	if (instruction[0] == '/')
	{
		Serial.println("ok");
		return;
	}

	//init baby!
	FloatPoint fp;
	fp.x = 0.0;
	fp.y = 0.0;
	fp.z = 0.0;

	byte code = 0;;
	
//what line are we at?
//	long line = -1;
//	if (has_command('N', instruction, size))
//		line = (long)search_string('N', instruction, size);
	
/*
	Serial.print("line: ");
	Serial.println(line);
	Serial.println(instruction);
*/		
	//did we get a gcode?
	if (
		has_command('G', instruction, size) ||
		has_command('X', instruction, size) ||
		has_command('Y', instruction, size) ||
		has_command('Z', instruction, size)
	)
	{
		//which one?
		code = (int)search_string('G', instruction, size);
		
		// Get co-ordinates if required by the code type given
		switch (code)
		{
			case 0:
			case 1:
			case 2:
			case 3:
				if(abs_mode)
				{
					//we do it like this to save time. makes curves better.
					//eg. if only x and y are specified, we dont have to waste time looking up z.
					if (has_command('X', instruction, size))
						fp.x = search_string('X', instruction, size);
					else
						fp.x = current_units.x;
				
					if (has_command('Y', instruction, size))
						fp.y = search_string('Y', instruction, size);
					else
						fp.y = current_units.y;
				
					if (has_command('Z', instruction, size))
						fp.z = search_string('Z', instruction, size);
					else
						fp.z = current_units.z;
				}
				else
				{
					fp.x = search_string('X', instruction, size) + current_units.x;
					fp.y = search_string('Y', instruction, size) + current_units.y;
					fp.z = search_string('Z', instruction, size) + current_units.z;
				}
			break;
		}

		//do something!
		switch (code)
		{
			//Rapid Positioning
			//Linear Interpolation
			//these are basically the same thing.
			case 0:
			case 1:

				//set our target.
				set_target(fp.x, fp.y, fp.z);
			
				//split up xy and z moves
				if (delta_steps.z && (delta_steps.x || delta_steps.y))
				{
					set_target(current_units.x, current_units.y, fp.z);
					figure_feedrate(instruction, size, code);
					dda_move(feedrate_micros);
				}
				
				//do the last move
				set_target(fp.x, fp.y, fp.z);
				figure_feedrate(instruction, size, code);
				dda_move(feedrate_micros);

			break;

			//Dwell
			case 4:
				delay((int)search_string('P', instruction, size));
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
				fp.x = search_string('X', instruction, size);
				fp.y = search_string('Y', instruction, size);
				fp.z = search_string('Z', instruction, size);

				//set our target.
				if(abs_mode)
				{
					if (!has_command('X', instruction, size))
						fp.x = current_units.x;
					if (!has_command('Y', instruction, size))
						fp.y = current_units.y;
					if (!has_command('Z', instruction, size))
						fp.z = current_units.z;
						
					set_target(fp.x, fp.y, fp.z);
				}
				else
					set_target(current_units.x + fp.x, current_units.y + fp.y, current_units.z + fp.z);
				
				//go there.
				dda_move(getMaxSpeed());

				//go home.
				set_target(0.0, 0.0, 0.0);
				dda_move(getMaxSpeed());
			break;

			//Absolute Positioning
			case 90:
				abs_mode = true;
			break;

			//Incremental Positioning
			case 91:
				abs_mode = false;
			break;

			//Set as home
			case 92:
				if (has_command('X', instruction, size))
					fp.x = search_string('X', instruction, size);
				else
					fp.x = current_units.x;
			
				if (has_command('Y', instruction, size))
					fp.y = search_string('Y', instruction, size);
				else
					fp.y = current_units.y;
			
				if (has_command('Z', instruction, size))
					fp.z = search_string('Z', instruction, size);
				else
					fp.z = current_units.z;

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
				Serial.println(code,DEC);
		}
	}
	
	//find us an m code.
	if (has_command('M', instruction, size))
	{
		code = search_string('M', instruction, size);
		switch (code)
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
				extruder_error = -300;
				enableTimer1Interrupt();
				enableTimer2Interrupt();
			break;

			//turn extruder on, reverse
			case 102:
				//this is not implemented, nor supported
			break;

			//turn extruder off
			case 103:
				disableTimer1Interrupt();
				disableTimer2Interrupt();
				analogWrite(EXTRUDER_MOTOR_SPEED_PIN, 0);
				extruder_error = 0;
			break;

			//custom code for temperature control
			case 104:
				extruder_set_temperature((int)search_string('S', instruction, size));

				//warmup if we're too cold.
				while (extruder_get_temperature() < extruder_target_celsius)
				{
					extruder_manage_temperature();
					Serial.print("T:");
					Serial.println(extruder_get_temperature());
					delay(1000);	
				}
				
			break;

			//custom code for temperature reading
			case 105:
				Serial.print("T:");
				Serial.println(extruder_get_temperature());
			break;
			
			//turn fan on
			case 106:
				digitalWrite(EXTRUDER_FAN_PIN, HIGH);
			break;

			//turn fan off
			case 107:
				digitalWrite(EXTRUDER_FAN_PIN, LOW);
			break;
			
			//set max extruder speed, in RPM
			case 108:
				extruder_rpm = (int)search_string('S', instruction, size);

				if (extruder_rpm)
				{
					extruder_delay = (960000000UL / EXTRUDER_ENCODER_STEPS) / extruder_rpm;
					setTimer1Ticks(extruder_delay);
				}
			break;
			
			case 110:
				Serial.println("Hi Skeinforge.");
				break;			

			//set extruder P gain
			case 120:
				extruder_pGain = (int)search_string('S', instruction, size);
			break;

			//set extruder I gain
			case 121:
				extruder_iGain = (int)search_string('S', instruction, size);
			break;

			//set extruder D gain
			case 122:
				extruder_dGain = (int)search_string('S', instruction, size);
			break;

			//set extruder iMax
			case 123:
				iMax = (int)search_string('S', instruction, size);
			break;

			//set extruder iMin
			case 124:
				iMin = (int)search_string('S', instruction, size);
			break;
			
			//set extruder iMin
			case 125:
				Serial.print("P:");
				Serial.println(extruder_pGain, DEC);
				Serial.print("I:");
				Serial.println(extruder_iGain, DEC);
				Serial.print("D:");
				Serial.println(extruder_dGain, DEC);
			break;
			
			//open the valve
			case 126:
				digitalWrite(EXTRUDER_VALVE_PIN, LOW);
			break;

			//open the valve
			case 127:
				digitalWrite(EXTRUDER_VALVE_PIN, HIGH);
			break;
			
			default:
				Serial.print("Huh? M");
				Serial.println(code);
		}		
	}
	
	//tell our host we're done.
	Serial.println("ok");
}

//look for the number that appears after the char key and return it
double search_string(char key, char instruction[], int string_size)
{
	char temp[10] = "";

	for (byte i=0; i<string_size; i++)
	{
		if (instruction[i] == key)
		{
			i++;      
			int k = 0;
			while (i < string_size && k < 10)
			{
				if (instruction[i] == 0 || instruction[i] == ' ')
					break;

				temp[k] = instruction[i];
				i++;
				k++;
			}
			return strtod(temp, NULL);
		}
	}
	
	return 0;
}

//look for the command if it exists.
bool has_command(char key, char instruction[], int string_size)
{
	for (byte i=0; i<string_size; i++)
	{
		if (instruction[i] == key)
			return true;
	}
	
	return false;
}

void figure_feedrate(char instruction[], int size, byte code)
{
	//do we have a set speed?
	if (has_command('G', instruction, size))
	{
		//adjust if we have a specific feedrate.
		if (code == 1)
		{
			//how fast do we move?
			feedrate = search_string('F', instruction, size);
			if (feedrate > 0)
				feedrate_micros = calculate_feedrate_delay(feedrate);
			//nope, no feedrate
			else
				feedrate_micros = getMaxSpeed();
		}
		//use our max for normal moves.
		else
			feedrate_micros = getMaxSpeed();
	}
	//nope, just coordinates!
	else
	{
		//do we have a feedrate yet?
		if (feedrate > 0)
			feedrate_micros = calculate_feedrate_delay(feedrate);
		//nope, no feedrate
		else
			feedrate_micros = getMaxSpeed();
	}
}
