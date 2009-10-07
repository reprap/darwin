

#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#define MY_NAME "TP"           // Two byte string representing the name of this device

// Communication speed

#define RS485_BAUD 38400

//******************************************************************************************************

// Pin defintion section.  This is for the RepRap Extruder Controler V2.2

//our RS485 pins

#define RX_ENABLE_PIN 4
#define TX_ENABLE_PIN 16

// Control pins for the A3949 chips

#define H1D 7
#define H1E 5
#define H2D 8
#define H2E 6

// Analogue read of this pin gets the potentiometer setting

#define POT 0

#endif
