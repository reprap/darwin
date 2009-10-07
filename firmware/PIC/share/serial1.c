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


/**
 * Implementation of interrupt driven SNAP communications routines for
 * use in a token ring configuration.  Being completely interrupt
 * driven improves performance and simplifies development of the core
 * logic in each device.  This is not really a true token ring in that
 * there is no token frame and the procedure for ring insertion etc.
 * is trivial -- it is however a network with ring topology.
 *
 * Overview/notes:
 *
 * A receive buffer accepts payload data as it arrives.  Upon
 * completion, a global flag is set that acts as a lock to prevent
 * further receives occuring until the lock is removed.  If a receive
 * does occur, but it is for somebody else, it is passed onto the next
 * node in the loop.  If the receive is for ourself then we fail and
 * NAK the packet so that it will be re-sent at a time we can
 * hopefully act on it.
 *
 * The lock flag also indicates to the main loop that data is awaiting
 * and the main loop is responsible for calling any processing on the
 * data.  It is not called directly by the ISR to prevent re-entrancy
 * problems.  The act of receiving the byte will wake the CPU and
 * allow it to check for the present of the lock.  After processing is
 * complete it may sleep if it wishes.  It will be woken after every
 * byte is received but can just repeatedly sleep again if it likes.
 *
 * The main loop that is acting on the lock flag must process the
 * command and send any necessary data.  It must also wait for an ACK
 * or NAK before finally removing the lock and allowing further
 * receives.
 *
 * When sending any packet (including ACK or NAK packets), a timeout
 * is started.  If the timeout expires, the response is considered to
 * be a NAK and the ACK/NAK is resent.  The timeout should be generous
 * enough to allow for full ring propagation with worst-case delays.
 * If the packets comes back to the sender, it is also treated as a
 * NAK.  An error counter should limit the number of re-sends before
 * dropping the packet and returning an error.
 *
 * When data is received, only the payload is available to the main
 * loop.  A copy of the source address is also saved until the lock is
 * released.  This allows replies to be sent regardless of other
 * packets received or forwarded during processing.
 *
 * For the moment, data packets will not have ACK/NAK piggybacked
 * with them and each will be sent separately.  This is because
 * ACKs are automatically and immediately sent by the ISR routines
 * before a response is even computed.
 *
 * @todo NAKing a packet while busy should ideally send a special NAK
 * that indicates busy as opposed to failed CRC, etc.  This would allow
 * a small pause before re-sending, rather than resending immediately
 * and probably causing the same problem again.
 *
 * General API:
 *
 * - Main loop inspects processingLock flag.  If set, it actions the data
 *   in buffer.
 *
 * - A reply is optionally constructed by calling sendReply.  This uses
 *   the saved source address to send appropriate header bytes.  Nothing
 *   much happens here because the header can't be constructed until
 *   the packet is complete (length is unknown).
 *
 * - Packet payload is sent by repeatedly calling sendDataByte
 *
 * - The sending is completed by calling endMessage, which will
 *   send the actual packet by constructing a header, length, body and
 *   CRC for the message.
 *
 * - awaitDelivery is called to wait for a response. A duplicate of
 *   the entire packet is kept in an additional buffer so that if a NAK
 *   arrives the same data can be re-sent without bothering the client.
 *   This method should do very little as the handling of this is
 *   interrupt driven.  If called, it will block until the delivery is
 *   complete and return fail/success.
 *
 * - When sending a new message rather than a reply, the sendMessage
 *   function is called with the destination address.
 *
 * - Call releaseLock to indicate processing is complete amd allow
 *   any necessary cleanups.  If no ACK is received yet, this
 *   will block until it arrives.  If endMessage is not called,
 *   the packet is dropped.
 *
 * In order for the routines to work the ISR must call the interrupt
 * handler serialInterruptHandler()
 *
 * When we get a packet not destined for us or with headers we don't
 * understand, we just pass them on.  In theory, a corrupt packet
 * could therefore just be passed on by everybody, forever.  To get
 * around this we could buffer the packet and check the CRC, then only
 * send it on if all is well.  However in doing so we greatly increase
 * the latency.  To prevent the possible long-term buildup of rogue
 * packets it is assumed that there is a node in the ring (such as a
 * more powerful PC) that will check things more thoroughly and mop up
 * any problem packets that are cycling the network.  By only having
 * one such node in the network, the latency effects are minimised.
 *
 * @todo An enhancement that may be needed is something to deal with
 * too much data arriving.  eg if fully occupied with incoming data
 * and a local transmit is occasionally needed, eventually
 * transmitting will block while waiting for the TSR to become free
 * (it won't be able to contain all the outgoing data).  This will
 * mean received data is lost and the packet will become corrupted.
 * However at least the next packet will also become corrupted.  This
 * situation should be detected and if anything arrives during
 * blocking transmits, they should be cleanly dropped up until the
 * packet ending.  This improvement just decreases the number of lost
 * packets, but is a little complex so it may or may not be worth
 * doing.  Also in most cases for a local transmit to be needed, there
 * would also be a command received, which would be consumed leaving
 * more buffer space.  Also responses from slave devices are not
 * expected to overwhelm the network so badly.
 *
 *
 * Problems with SNAP:
 *
 * Error correction is optional.  That means the flag itself could be
 * corrupted and no error correction will take place.  It should
 * be mandatory and cover the header.
 *
 * The destination address should occur sooner so packets can be
 * passed on in the network as soon as possible to decrease latency (only
 * relevant in a token ring situation).
 *
 * The lengths are not continuous up to the sizes we want.
 *
 * A lot of the other stuff is superfluous.
 *
 * An ARP protocol like SMBus has might be nice.
 *
 */

/// @bug There are problems with addresses 3,9,17,19,26 and 28 for
/// some currently unknown reason.  If you send a message to one of
/// these addresses, it will not be chained on correctly.

/* 
 * andreas, 2007-09-16: 
 *   simplify the communication to get rid of corrupt messages:
 *   synchronize the communication so that only one message can be in the ring. 
 *   the host-software is the master, the devices are the slaves.
 *   the master sends messages to set values in a device (setMessages) or to request information from a device
 *     (requestMessages). 
 *   only the master requires an ACK. If the master doesn't get an correct answer in a given time,
 *     he should resend his message. 
 *   the devices gets a message and ACK it, if requested. If the message requires an
 *     answer then the device sends the answer in the processCommand-loop.
 *   if the master sends an requestMessage, then the master has to wait for the answer. it is not allowed to send
 *     another message until the answer is received, otherwise the device will reset the serial-communication with
 *     sending MAX_TRANSMIT_BUFFER bytes of the value 0.
 *   it is not allowed to call sendDataByte() or endMessage() from within an interrupt-routine!
 *
 *   messages are synchronized to prevent mixing up messages (e.g. mixing of isr-messages with normal-messages and 
 *     forwarding messages)
 */
#include "serial.h"

enum SNAP_states {
  SNAP_idle = 0x30,
  SNAP_haveSync,
  SNAP_haveHDB2,
  SNAP_haveHDB1,
  SNAP_haveDAB,
  SNAP_readingData,
  SNAP_dataComplete,

  // The *Pass states below represent states where
  // we should just be passing the data on to the next node.
  // This is either because we bailed out, or because the
  // packet wasn't destined for us.
  SNAP_haveHDB2Pass,
  SNAP_haveHDB1Pass,
  SNAP_haveDABPass,
  SNAP_readingDataPass
};

#define SNAP_SYNC BIN(01010100)

//initialization do not work!
static volatile byte uartState = SNAP_idle; ///< Current SNAP state machine state
static volatile byte in_hdb1;  ///< Temporary buffers needed to
static volatile byte in_hdb2;  ///  pass packets on from various states
static volatile byte packetLength; ///< Length of packet being received
static volatile byte sourceAddress;///< Source of packet being received
static volatile byte receivedSourceAddress; ///< Source of packet previously received
static volatile byte bufferIndex;  ///< Current receive buffer index
static volatile byte crc; ///< Incrementally calculated CRC value

/// Circular transmit buffer.
/// Tail has the buffer index that will next be written to.  Head is
/// the buffer index that will next be transmitted.
/// If head == tail, the buffer is empty.
/// The purpose of this buffer is to allow background sending of
/// data rather than busy looping.
extern volatile byte transmitBuffer[];
static volatile byte transmitBufferHead; ///< Start of circular transmit buffer
static volatile byte transmitBufferTail; ///< End of circular transmit buffer

/// This buffer stores the last complete packet body (not the headers
/// as they can be reconstructed).  This is to allow automatic re-sending
/// if a NAK is received.
static byte sendPacketDestination;
extern byte sendPacket[];
static byte sendPacketLength;
/// When sending a packet this is set to 0 and incremented for
/// every NAK.  After too many have occurred, the packet is just
/// dropped.
//static byte nakCount;

/// General flags:
/// @bug these should be "sbit" rather than "byte" but sdcc is breaking a bit
//static volatile byte ackRequested;

extern byte deviceAddress;

volatile byte serialStatus; //flags for checking status of the serial-communication
#define serialErrorBit     BIN(00000001)
        //Bit0 is for serialError-flag for checking if an serial error has occured,
	//  if set, we will reset the communication
	//
#define inTransmitMsgBit   BIN(00000010)
	//Bit1 is set if we are currently transmitting a message, that means bytes of 
	//  a message have been put in the transmitBuffer, but the message is not 
	//  finished.
#define inSendQueueMsgBit  BIN(00000100)
	//Bit2 is set if we are currently building a send-message

#define msgAbortedBit  BIN(00001000)
	//Bit3 is set if we are busy with the last command and have to abort the message
	
#define wrongStateErrorBit BIN(00010000)
	//Bit4 is set when we have a wrong uartState
#define wrongByteErrorBit  BIN(00100000)
	//Bit5 is set when we receive a wrong byte
#define ackRequestedBit    BIN(01000000)
	//Bit6 is set if we have to acknowledge a received message
#define processingLockBit  BIN(10000000)
        //Bit7 is set if we have received a message for local processing


//===============================================================================

// LED flash code added by Adrian

// flashON and flashOFF set the duty cycle
// Call flashLED in a loop, or in a repeatedly-called
// interrupt function.

volatile static byte flash_count;
volatile static byte flash;
volatile static byte flashON;
volatile static byte flashOFF;

void flashLED()
{
	flash_count--;
	if(flash_count <= 0)
	{
		flash = 1 - flash;
		if(flash)
		{
			LED = 0;
			flash_count = flashOFF;
		} else
		{
			LED = 1;
			flash_count = flashON;
		}
	}
}

void LEDon()
{
	LED = 0;
}

void setFlash(byte on, byte off)
{
	flashON = on;
	flashOFF = off;
}

// ======================================================================

/// @todo Remove when sdcc initialisers fixed
void serial_init()
{
  uartState = SNAP_idle;
  transmitBufferHead = 0;
  transmitBufferTail = 0;
  serialStatus = 0;
  crc = 0;
  flash = 0;
  flashON = FLASHRATE;
  flashOFF = FLASHRATE;
}

//===========================================================================//

#pragma save
#pragma nooverlay
byte computeCRC(byte dataval)
{
#ifdef SDCC_DISABLED_FOR_NOW
_asm
  ;derived from code by T. Scott Dattalo
  ;w contains dataval
     movwf	crctemp
     xorwf	_crc,f
     clrw
     btfsc	_crc,0
     xorlw	0x5e
     btfsc	_crc,1
     xorlw	0xbc
     btfsc	_crc,2
     xorlw	0x61
     btfsc	_crc,3
     xorlw	0xc2
     btfsc	_crc,4
     xorlw	0x9d
     btfsc	_crc,5
     xorlw	0x23
     btfsc	_crc,6
     xorlw	0x46
     btfsc	_crc,7
     xorlw	0x8c
     movwf	_crc
     movf	crctemp, w
     return
_endasm;
#else
  // Less efficient version in C
  byte i = dataval ^ crc;

  crc = 0;

  if(i & 1)
    crc ^= 0x5e;
  if(i & 2)
    crc ^= 0xbc;
  if(i & 4)
    crc ^= 0x61;
  if(i & 8)
    crc ^= 0xc2;
  if(i & 0x10)
    crc ^= 0x9d;
  if(i & 0x20)
    crc ^= 0x23;
  if(i & 0x40)
    crc ^= 0x46;
  if(i & 0x80)
    crc ^= 0x8c;
  return dataval;
#endif
}
#pragma restore



//===========================================================================//
#pragma save
#pragma nooverlay
void uartReceiveError()
{
  byte i;


  if ((serialStatus & msgAbortedBit) == 0) {
    //wipe the corrupt-message out of the receive-buffers of the nodes
    for (i=0; i<8; i++) { //if we are sending too much for the transmit-buffer, it is discarded
      uartTransmit(0);
    }
    //TODO: remove
    //uartTransmit(serialStatus);
  }

  /*
    serialStatus &= ~serialErrorBit;  //clear
    serialStatus &= ~inTransmitMsgBit; //clear
    serialStatus &= ~ackRequestedBit; //clear
    serialStatus &= ~inSendQueueMsgBit; //clear
    serialStatus &= ~processingLockBit; //clear, maybe we should not do that
  */
  serialStatus = (serialStatus & msgAbortedBit); //clear all bits except msgAbortedBit;

  uartState = SNAP_idle;
}
#pragma restore

//===========================================================================//
#pragma save
#pragma nooverlay
void uartNotifyReceive()
{
  byte c; 

  
  c = RCREG;

  // If error occurred then reset by clearing CREN, but
  // attempt to continue processing anyway.
  /// @todo Should we do something else in this situation?
  if (OERR) {
    CREN = 0;
    //don't set the error: serialStatus |= serialErrorBit
    //because c and the next RCREG will be ok and maybe
    //we got a correct message
  }
  CREN = 1;

  if (serialStatus & serialErrorBit) {
    uartReceiveError();
    return;
  }
  

  switch(uartState) {

  // ----------------------------------------------------------------------- //
  case SNAP_idle:
    // In the idle state, we wait for a sync byte.  If none is
    // received, we remain in this state.
    if (c == SNAP_SYNC) {
      uartState = SNAP_haveSync;
      serialStatus &= ~msgAbortedBit; //clear
    }
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveSync:
    // In this state we are waiting for header definition bytes. First
    // HDB2.  We currently insist that all packets meet our expected
    // format which is 1 byte destination address, 1 byte source
    // address, and no protocol specific bytes.  The ACK/NAK bits may
    // be anything.
    in_hdb2 = c;
    if ((c & BIN(11111100)) != BIN(01010000)) {
      // Unsupported header.  Drop it an reset
      serialStatus |= serialErrorBit;  //set serialError
      serialStatus |= wrongByteErrorBit; 
      uartReceiveError();
    } else {
      // All is well
      if ((c & BIN(00000011)) == BIN(00000001))
	serialStatus |= ackRequestedBit;  //set ackRequested-Bit
      else
	serialStatus &= ~ackRequestedBit; //clear
      crc = 0;
      computeCRC(c);
      uartState = SNAP_haveHDB2;
    }
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveHDB2:
    // For HDB1, we insist on high bits are 0011 and low bits are the length 
    //   of the payload.
    in_hdb1 = c;
    if ((c & BIN(11110000)) != BIN(00110000)) {
      serialStatus |= serialErrorBit;  //set serialError
      serialStatus |= wrongByteErrorBit; 
      uartReceiveError();
    } else {
      packetLength = c & 0x0f;
      if (packetLength > MAX_PAYLOAD)
	packetLength = MAX_PAYLOAD;
      computeCRC(c);
      uartState = SNAP_haveHDB1;
    }
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveHDB1:
    // We should be reading the destination address now
    if (c != deviceAddress) {
      uartTransmit(SNAP_SYNC);
      uartTransmit(in_hdb2);
      uartTransmit(in_hdb1);
      uartTransmit(c);
      uartState = SNAP_haveDABPass;
      serialStatus &= ~ackRequestedBit; //clear
      serialStatus |= inTransmitMsgBit; 
    } else {
      computeCRC(c);
      uartState = SNAP_haveDAB;
    }
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveDAB:
    // We should be reading the source address now
    if (c == deviceAddress) {
      // If we receive a packet from ourselves, that means it went
      // around the ring and was never picked up, ie the device we
      // sent to is off-line or unavailable.

      /// @todo Deal with this situation
    }
    if (serialStatus & processingLockBit) {
      //we have not finished the last order, reject
      uartTransmit(SNAP_SYNC);
      crc = 0;
      uartTransmit(computeCRC(BIN(01010011))); //HDB2
      // HDB1: 0 bytes, with 8 bit CRC
      uartTransmit(computeCRC(BIN(00110000)));  //HDB1
      uartTransmit(computeCRC(sourceAddress));  // Return to sender
      uartTransmit(computeCRC(deviceAddress));  // From us
 //TODO: remove
 /*for debugging add serialStatus
 uartTransmit(computeCRC(BIN(00110001)));   //HDB1
 uartTransmit(computeCRC(sourceAddress));  // Return to sender
 uartTransmit(computeCRC(deviceAddress));  // From us
 uartTransmit(computeCRC(serialStatus));  // Return to sender
 */
      uartTransmit(crc);  // CRC
      serialStatus &= ~ackRequestedBit; //clear
      serialStatus |= msgAbortedBit; //set
      uartState = SNAP_idle;
    } else {
      sourceAddress = c;
      bufferIndex = 0;
      computeCRC(c);
      uartState = SNAP_readingData;
    }
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_readingData:
    buffer[bufferIndex] = c;
    bufferIndex++;
    computeCRC(c);

    if (bufferIndex == packetLength)
      uartState = SNAP_dataComplete;
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_dataComplete:
    // We should be receiving a CRC after data, and it
    // should match what we have already computed
    {
      byte hdb2 = BIN(01010000); // 1 byte addresses
      
      if (c == crc) {
	// All is good, so process the command.  Rather than calling the
	// appropriate function directly, we just set a flag to say
	// something is ready for processing.  Then in the main loop we
	// detect this and process the command.  This allows further
	// comms processing (such as passing other tokens around the
	// ring) while we're actioning the command.
	
	hdb2 |= BIN(10);
	serialStatus |= processingLockBit;  //set processingLockBit
	receivedSourceAddress = sourceAddress;
      } else {
	// CRC mismatch, so we will NAK the packet
	hdb2 |= BIN(11);
      }
      if (serialStatus & ackRequestedBit) {
	// Send ACK or NAK back to source
	uartTransmit(SNAP_SYNC);
	crc = 0;
	uartTransmit(computeCRC(hdb2));
	// HDB1: 0 bytes, with 8 bit CRC
	uartTransmit(computeCRC(BIN(00110000)));
	uartTransmit(computeCRC(sourceAddress));  // Return to sender
	uartTransmit(computeCRC(deviceAddress));  // From us
	uartTransmit(crc);  // CRC
	serialStatus &= ~ackRequestedBit; //clear
      }
    }
    uartState = SNAP_idle;
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveHDB2Pass:
    uartTransmit(c);  // We will be reading HDB1; pass it on
    packetLength = c & 0x0f;
    if (packetLength > MAX_PAYLOAD)
      packetLength = MAX_PAYLOAD;
    uartState = SNAP_haveHDB1Pass;
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveHDB1Pass:
    uartTransmit(c);  // We will be reading dest addr; pass it on
    uartState = SNAP_haveDABPass;
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_haveDABPass:
    uartTransmit(c);  // We will be reading source addr; pass it on

    // Increment data length by 1 so that we just copy the CRC
    // at the end as well.
    packetLength++;

    uartState = SNAP_readingDataPass;
    break;

  // ----------------------------------------------------------------------- //
  case SNAP_readingDataPass:
    uartTransmit(c);  // This is a data byte; pass it on
    if (packetLength > 1)
      packetLength--;
    else {
      uartState = SNAP_idle;
      serialStatus &= ~inTransmitMsgBit; //clear
    }
    break;

  default:
    serialStatus |= serialErrorBit;  //set serialError
    serialStatus |= wrongStateErrorBit;  
    uartReceiveError();
  }


}
#pragma restore

//===========================================================================//
/// Low level routine that queues a byte directly for the hardware
//GIE must be disabled
#pragma save
#pragma nooverlay
void uartTransmit(byte c)
{

  byte newTail;

  newTail = transmitBufferTail + 1;
  if (newTail >= MAX_TRANSMIT_BUFFER)
     newTail = 0;

  //only do it if we have one free space in the buffer
  //if the buffer is full, discard it
  if (newTail != transmitBufferHead) {
    transmitBuffer[transmitBufferTail] = c;
    transmitBufferTail = newTail;

    if (TXIE == 0) {
      TXIE=1; //enabling TXIE sets also TXIF
    }
  }


_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _uartState;
_endasm;

}
#pragma restore

//===========================================================================//
#pragma save
#pragma nooverlay
static void sendDataByteIntern(byte c)
{
  if (serialStatus & inSendQueueMsgBit)  {
    // Put byte into packet sending buffer.  Don't calculated CRCs
    // yet as we don't have complete information.
    // Drop if trying to send too much
    if (sendPacketLength < MAX_PAYLOAD)
      sendPacket[sendPacketLength++] = c;
  } //else serialError has cleared the inSendQueueMsgBit

_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _uartState;
_endasm;
}
#pragma restore

//===========================================================================//
//High level routine that queues a byte during construction of a packet
//Should only be called between sendMessage() and endMessage() 
void sendDataByte(byte c)
{
  GIE=0;
  sendDataByteIntern(c);
  GIE=1;
}

//===========================================================================//
//High level routine that queues a byte during construction of a packet 
//  in an interrupt-routine
//Should only be called between sendMessageISR() and endMessageISR() 
void sendDataByteISR(byte c)
{
  sendDataByteIntern(c);
}

//===========================================================================//
//should not be called from an interrupt-routine!
#pragma save
#pragma nooverlay
void releaseLock()
{
  GIE=0;
  serialStatus &= ~processingLockBit; //clear
  GIE=1;
}
#pragma restore



//===========================================================================//
//GIE must be disabled
static void sendMessageIntern(byte dest)
{
  serialStatus |= inSendQueueMsgBit; //set bit
  sendPacketDestination = dest;
  sendPacketLength = 0;
}

//===========================================================================//
//High level routine that queues a byte during construction of a packet 
//in an interrupt-routine
//
//because we are in an isr we cannot block.
//we return 1 if we can send instantly otherwise we do nothing and return 0;
//  
byte sendMessageISR(byte dest)
{
  //send if transmitBuffer is empty and we are not already forwarding a message
  //  or queuing a message
  //because we are in the isr, we will not receive other data,
  //  this means, forwarding would not interfer because we are finished before the next byte 
  //  will be received
  if ((serialStatus & inSendQueueMsgBit) || (serialStatus & inTransmitMsgBit) ||
      (transmitBufferHead != transmitBufferTail)) {
    return 0; 
  } else {
   sendMessageIntern(dest);	  
  }
  return 1;
}


//===========================================================================//
//High level routine that queues a byte during construction of a packet 
//should not be called within an interrupt-routine!
//we are blocking until we can send the message
//we are also blocking in endMessage, therefor other bytes can be received 
//after sendMessage()
//
//GIE must be enabled
#pragma save
#pragma nooverlay
void sendMessage(byte dest)
{
  GIE=0;
  while (serialStatus & inSendQueueMsgBit) { 
    //wait until we can use the buffer
    GIE=1;
    delay_10us();
    delay_10us();
    delay_10us();
    delay_10us();
    delay_10us();
    GIE=0;
  }
  
  sendMessageIntern(dest);
  GIE=1;
}
#pragma restore

//===========================================================================//
//should not be called within an interrupt!
void sendReply()
{
  sendMessage(receivedSourceAddress);
}



//===========================================================================//
//returns 1 if a packet for processing has been received 
//should not be called from an interrupt-routine!
#pragma save
#pragma nooverlay
byte packetReady()
{  byte ready;
   GIE=0;
   ready = (serialStatus & processingLockBit);
   if (transmitBufferHead != transmitBufferTail)
     ready = 0;
   GIE=1;
   return ready;
}
#pragma restore


//===========================================================================//
//sends the message in the queue
//after sending we are freeing the sendQueueLock: inSendQueueMsgBit
//GIE must be disabled
#pragma save
#pragma nooverlay
static void endMessageIntern()
{
  byte i;
  if (serialStatus & inSendQueueMsgBit) {  
    //test if inSendQueueMsgBit is set, otherwise it has been resetted by serialError
    
    // Send the message
    uartTransmit(SNAP_SYNC);
    crc = 0;
    uartTransmit(computeCRC(BIN(01010001)));   // Request ACK
    uartTransmit(computeCRC(BIN(00110000) | sendPacketLength));
    uartTransmit(computeCRC(sendPacketDestination));
    uartTransmit(computeCRC(deviceAddress));
    for(i = 0; i < sendPacketLength; i++)
      uartTransmit(computeCRC(sendPacket[i]));
    uartTransmit(crc); /// @todo crc here
    
    serialStatus &= ~inSendQueueMsgBit;  //clear 
  }
}
#pragma restore

//===========================================================================//
//High level routine that sends the queued message
//GIE must be disabled
//we should have a free transmitBuffer, we checked this in sendMessageISR();
#pragma save
#pragma nooverlay
void endMessageISR()
{
  endMessageIntern();
}
#pragma restore

//===========================================================================//
//High level routine that sends the queued message
//should not be called within an interrupt-routine!
//GIE must be enalbled
//we are waiting until inTransmitMsgBit is clear,
//  (otherwise we would interfer with forwarding messages
#pragma save
#pragma nooverlay
void endMessage()
{
  GIE=0;
  //wait until forwarding-Message is complete
  while (serialStatus & inTransmitMsgBit) {
    GIE=1;
    delay_10us();
    delay_10us();
    delay_10us();
    delay_10us();
    delay_10us();
    GIE=0;
  }
  endMessageIntern();
  GIE=1;
}
#pragma restore


//===========================================================================//
#pragma save
#pragma nooverlay
void serialInterruptHandler()
{
  // Process serial
  // Finished sending something?
  if (TXIF && TXIE) {
    if (transmitBufferHead == transmitBufferTail) {
      // If empty now and transfer is completed (TRMT==1), disable XMIT interrupts
      if (TRMT) 
         TXIE = 0;
    } else {
      TXREG = transmitBuffer[transmitBufferHead];
      transmitBufferHead++;
      if (transmitBufferHead >= MAX_TRANSMIT_BUFFER)
	transmitBufferHead = 0;
    }
  }
/* also working
  if (TXIF  && (transmitBufferHead != transmitBufferTail)) {
      byte c = transmitBuffer[transmitBufferHead];
      transmitBufferHead++;
      if (transmitBufferHead >= MAX_TRANSMIT_BUFFER)
	transmitBufferHead = 0;
      TXREG = c;
  }
*/
  
  // Any data received?
  if (RCIF) {
    uartNotifyReceive();
  }
  
_asm  /// @todo Remove when sdcc bug fixed
  BANKSEL _uartState;
_endasm;
}
#pragma restore
