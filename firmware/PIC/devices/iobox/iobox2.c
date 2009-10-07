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

#include "iobox.h"
#include "serial.h"

// Simple networked IO box for experimenting
// I/O ports:
//   B0 - B7: Outputs
//   A0 - A7: Inputs

#define CMD_VERSION    0
#define CMD_SETOUTPUTS 1
#define CMD_GETINPUTS  2

void init2()
{
}

void processCommand()
{
  switch(buffer[0]) {
  case CMD_VERSION:
    sendReply();
    sendDataByte(CMD_VERSION);  // Response type 0
    sendDataByte(0);  // Minor
    sendDataByte(1);  // Major
    endMessage();
    break;

  case CMD_SETOUTPUTS:
    PORTB = buffer[1];
    break;

  case CMD_GETINPUTS:
    sendReply();
    sendDataByte(CMD_GETINPUTS);  // Response type 0
    sendDataByte(PORTA);
    endMessage();
    break;
  }
}
