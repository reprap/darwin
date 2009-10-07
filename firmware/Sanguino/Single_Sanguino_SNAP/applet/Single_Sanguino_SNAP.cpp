#include "WProgram.h"
#include "init.h"
#include "HardwareSerial.h"
#include "SNAP.h"
#include "RepStepper.h"
#include "LinearAxis.h"
#include "CartesianBot.h"
#include "ThermoplastExtruder.h"
#include "ThermoplastExtruder_SNAP_v1.h"
#include "CartesianBot_SNAP_v1.h"
/*
	Single_Arduino_SNAP.pde - Combined cartesian bot + extruder firmware.

	History:
	* (0.1) Created initial version by Zach Smith.
	* (0.2) Updated to work with the various optimizations and extruder emulation by Zach Smith
	* (0.3) Updated with new library changes by Zach Smith.
	
	License: GPL v2.0
*/

//our config file
//our library includes.
ThermoplastExtruder extruder(EXTRUDER_MOTOR_DIR_PIN, EXTRUDER_MOTOR_SPEED_PIN, EXTRUDER_HEATER_PIN, 
  EXTRUDER_FAN_PIN, EXTRUDER_THERMISTOR_PIN, VALVE_DIR_PIN, VALVE_ENABLE_PIN);

CartesianBot bot = CartesianBot(
	'x', X_MOTOR_STEPS, X_DIR_PIN, X_STEP_PIN, X_MIN_PIN, X_MAX_PIN, X_ENABLE_PIN,
	'y', Y_MOTOR_STEPS, Y_DIR_PIN, Y_STEP_PIN, Y_MIN_PIN, Y_MAX_PIN, Y_ENABLE_PIN,
	'z', Z_MOTOR_STEPS, Z_DIR_PIN, Z_STEP_PIN, Z_MIN_PIN, Z_MAX_PIN, Z_ENABLE_PIN
);

void setup()
{
	snap.begin(19200);
	
	//run any setup code we need.
	setup_cartesian_bot_snap_v1();
	setup_extruder_snap_v1();
	
	snap.debug();
	Serial.println("BEGIN");
}

void loop()
{	
	//do the loop commands.
	cartesian_bot_snap_v1_loop();
	extruder.manageTemperature();
	
	//process our commands
	if (snap.packetReady())
	{
  		//who is it for?
		byte dest = snap.getDestination();

		//route the command to the proper object.
		if (dest == EXTRUDER_ADDRESS)
			process_thermoplast_extruder_snap_commands_v1();
		else if(dest == X_ADDRESS || dest == Y_ADDRESS || dest == Z_ADDRESS)
			process_cartesian_bot_snap_commands_v1();
		
		snap.releaseLock();
	}
	else
		snap.receivePacket();
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

