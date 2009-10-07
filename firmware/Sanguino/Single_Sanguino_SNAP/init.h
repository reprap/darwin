// This version is for the Sanguino.

// THIS IS THE DISTRIBUTION HEADER FILE.
// Please rename to init.h and make local customizations there.
// Thanks -- Zach Hoeken

/****************************************************************************************
* digital i/o pin assignment

****************************************************************************************/

//cartesian bot pins
#define X_STEP_PIN 1
#define X_DIR_PIN 2
#define X_MIN_PIN 3
#define X_MAX_PIN 4
#define X_ENABLE_PIN 15
#define Y_STEP_PIN 26
#define Y_DIR_PIN 27
#define Y_MIN_PIN 28
#define Y_MAX_PIN 10
#define Y_ENABLE_PIN 15
#define Z_STEP_PIN 11
#define Z_DIR_PIN 24
#define Z_MIN_PIN 25
#define Z_MAX_PIN 18
#define Z_ENABLE_PIN 15

//extruder pins
#define EXTRUDER_MOTOR_SPEED_PIN  13
#define EXTRUDER_MOTOR_DIR_PIN    20
#define EXTRUDER_HEATER_PIN       12
#define EXTRUDER_FAN_PIN          19
#define EXTRUDER_THERMISTOR_PIN   0
#define VALVE_DIR_PIN             21
#define VALVE_ENABLE_PIN          22  

// how many steps do our motors have?
#define X_MOTOR_STEPS 400
#define Y_MOTOR_STEPS 400
#define Z_MOTOR_STEPS 400
