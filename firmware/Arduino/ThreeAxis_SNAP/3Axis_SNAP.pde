/*
	3Axis_SNAP.pde - RepRap cartesian firmware for Arduino

	History:
	* (0.1) Created initial version by Zach Smith <hoeken@rrrf.org>.
	* (0.2) Rewrite by Marius Kintel <kintel@sim.no> and Philipp Tiefenbacher <wizards23@gmail.com>
	* (0.3) Updated and tested to work with current RepRap host software by Zach Smith <hoeken@rrrf.org>
	* (0.4) Updated to work the recent optimizations, ie. removal of LimitSwitch by Zach Smith.
	* (0.5) Updated with new library changes by Zach Smith.
	
	License: GPL v2.0
*/

#include "init.h"

CartesianBot bot = CartesianBot(
	'x', X_MOTOR_STEPS, X_DIR_PIN, X_STEP_PIN, X_MIN_PIN, X_MAX_PIN, X_ENABLE_PIN,
	'y', Y_MOTOR_STEPS, Y_DIR_PIN, Y_STEP_PIN, Y_MIN_PIN, Y_MAX_PIN, Y_ENABLE_PIN,
	'z', Z_MOTOR_STEPS, Z_DIR_PIN, Z_STEP_PIN, Z_MIN_PIN, Z_MAX_PIN, Z_ENABLE_PIN
);

#include <SNAP.h>
#include <RepStepper.h>
#include <LinearAxis.h>
#include <CartesianBot.h>
#include <CartesianBot_SNAP_v1.h>

void setup()
{
	Serial.begin(19200);
	
	//run any setup code we need.
	setup_cartesian_bot_snap_v1();
}

void loop()
{
	//get our state status / manage our status.
	bot.readState();

	//process our commands
	snap.receivePacket();
	if (snap.packetReady())
		process_cartesian_bot_snap_commands_v1();
}
