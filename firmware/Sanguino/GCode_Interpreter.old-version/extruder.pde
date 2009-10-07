// Yep, this is actually -*- c++ -*-

#include "ThermistorTable.h"

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
