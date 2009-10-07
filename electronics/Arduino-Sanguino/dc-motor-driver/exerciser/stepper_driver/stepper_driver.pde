/*
 Stepper Motor Controller
 language: Wiring/Arduino

 This program drives a unipolar or bipolar stepper motor.
 The motor is attached to digital pins 8 and 9 of the Arduino.

 The motor moves 100 steps in one direction, then 100 in the other.

 Created 11 Mar. 2007 by Tom Igoe
 Modified 7 Apr. 2007 by Tom Igoe
 Modified 25 Oct. 2007 by Zach Smith

*/

#include <Stepper.h>

// change this depending on the number of steps per revolution of your motor
#define motorSteps 200

// define the pins that the motor is attached to. You can use any digital I/O pins.
#define motorPin1 8
#define motorPin2 9

// initialize of the Stepper library:
Stepper myStepper(motorSteps, motorPin1, motorPin2); 

void setup()
{
	Serial.begin(9600);
	Serial.println('Starting stepper exerciser.');
}

void loop()
{
	int i;

	for (i=25; i<=60; i+=5)
	{
		//set our new motor speed
		Serial.print("Speed ");
		Serial.println(i);
		myStepper.setSpeed(i);

		// Step forward 200 steps:
		Serial.println("Forward");
		myStepper.step(200);
		delay(500);

		// Step backward 200 steps:
		Serial.println("Backward");
		myStepper.step(-200);
		delay(500); 

	}

	for (i=60; i>=; i-=5)
	{
		//set our new motor speed
		Serial.print("Speed ");
		Serial.println(i);
		myStepper.setSpeed(i);

		// Step forward 200 steps:
		Serial.println("Forward");
		myStepper.step(200);
		delay(500);

		// Step backward 200 steps:
		Serial.println("Backward");
		myStepper.step(-200);
		delay(500); 
	}
}
