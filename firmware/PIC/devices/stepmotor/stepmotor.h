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

#ifndef _stepmotor_h
#define _stepmotor_h

#include "pic14.h"

// Half-stepping not needed for 400-step-per-rev motors.
// Enable this for 200-step-per-rev motors (also for 400 step
// for smoother but slower running).
//#define HALFSTEP

#define UNIVERSAL_PCB

void init2();
void timerTick();
void processCommand();
void syncStrobe();
void setPower(byte p);

extern byte syncEnabled;
extern byte syncCounter;

#ifdef UNIVERSAL_PCB
#define SYNCA       RA1
#define SYNCA_TRIS  TRISA1
#else
#define SYNCA       RA2
#define SYNCA_TRIS  TRISA2
#endif

#define MINSENSOR   RB0
#define MAXSENSOR   RA5

#define PULLUPS     BIN(00000001)

#define PWM         RB3
#define PWM_TRIS    TRISB3



#endif
