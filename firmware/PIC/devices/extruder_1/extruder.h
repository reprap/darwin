#ifndef _extruder_h
#define _extruder_h

#include "pic14.h"

#define UNIVERSAL_PCB

void init2();
void processCommand();
void motorTick();
void timerTick();
void checkTemperature();

extern byte PWMPeriod;

#ifdef UNIVERSAL_PCB
// RA0 is L298 4 (Fan)
// RA1 is Thermistor
// RA2 is L298 3 (Fan)   
// RA3 is Heater
// RA4 is the indicator LED
// RA5 is Material sensor
// RA6 is Thermistor
// RA7 is Thermistor       

// RB0 is Extrude speed sensor
// RB1 is Rx
// RB2 is Tx 
// RB3 is PWM output to L298      
// RB4 is L298 2 (Extrude)
// RB5 is L298 1 (Extrude)
// RB6 is not used
// RB7 is not used 

#define PORTATRIS BIN(00100000)

#else
// RA1 is A/D converter input
// RA3 is cooler output
// RA4 is LED output
// RA6,7 are used for A/D converter
//#define PORTATRIS BIN(00101001)
#define PORTATRIS BIN(00100001)
#endif

#endif
