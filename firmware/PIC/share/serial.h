/*
 *
 * RepRap, The Replicating Rapid Prototyper Project
 *
 * http://reprap.org/
 *
 * RepRap is copyright (C) 2005-6 University of Bath, the RepRap
 * researchers (see the project's People webpage), and other contributors.
 *
 * RepRap is free; you can redistribute it and/or modify it under the
 * terms of the GNU Library General Public Licence as published by the
 * Free Software Foundation; either version 2 of the Licence, or (at your
 * option) any later version.
 *
 * RepRap is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
 * Licence for more details.
 *
 * For this purpose the words "software" and "library" in the GNU Library
 * General Public Licence are taken to mean any and all computer programs
 * computer files data results documents and other copyright information
 * available from the RepRap project.
 *
 * You should have received a copy of the GNU Library General Public
 * Licence along with RepRap (in reports, it will be one of the
 * appendices, for example); if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA, or see
 *
 * http://www.gnu.org/
 *
 */

#ifndef _serial_h
#define _serial_h

#include "pic14.h"

// This firmware version

#define MAJOR_VERSION_NUMBER 1
#define MINOR_VERSION_NUMBER 0

// The oldest host s/w this'll work with

#define OLDHOST_MAJOR_VERSION_NUMBER 0
#define OLDHOST_MINOR_VERSION_NUMBER 8

//type definitions.  see: http://reprap.org/bin/view/Main/Modules
#define LINEAR_AXIS_TYPE 0
#define THERMOPLASTIC_EXTRUDER_TYPE 1
#define SUPPORT_EXTRUDER_TYPE 2
#define CARTESIAN_ROBOT_TYPE 3
#define LASER_CUTTER_ETCHER_TYPE 4
#define CUTTING_TOOLHEAD_TYPE 5

#define MAX_TRANSMIT_BUFFER 16  ///< Transmit buffer size.

#define MAX_PAYLOAD 16          ///< Size of largest possible message.

#define LED			RA4      ///< Port to which the LED is attached - 0 is on
#define FLASHRATE   50          ///< Default flashrate
void flashLED();
void LEDon();
void setFlash(byte on, byte off);

void uartTransmit(byte c);
void sendReply();
void sendMessage(byte dest);
void sendDataByte(byte c);
void endMessage();
byte sendMessageISR(byte dest);
void sendDataByteISR(byte c);
void endMessageISR();
void releaseLock();
void serialInterruptHandler();

byte packetReady();

extern volatile byte buffer[];
extern volatile byte serialStatus;

void uartNotifyReceive();
void serial_init();

void delay_10us();
void clearwdt();

#endif
