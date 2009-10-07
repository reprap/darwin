#include <iostream>
#include "snap_packet.h"
#include "snap.h"

SNAPPacket::SNAPPacket()
{
  sync = 0x54;
  hdb2 = 0x51;
  hdb1 = 0x30;
  dab = 0;
  sab = 0;
  crc = 0;
}

bool SNAPPacket::readPacket(SNAP &snap)
{
  crc = 0;
  byte actualCRC;
  try {
    for(;;) {
      sync = snap.readbyte();
      if (sync == 0x54) break;
    }
    hdb2 = computeCRC(snap.readbyte());
    hdb1 = computeCRC(snap.readbyte());
    dab = computeCRC(snap.readbyte());
    sab = computeCRC(snap.readbyte());
    for(int i = 0; i < getLength(); i++) {
      payload[i] = computeCRC(snap.readbyte());
    }
    actualCRC = snap.readbyte();
  } catch(SNAPTimeoutException) {
    std::cerr << "Timeout waiting for receive" << std::endl;
    return false;
  }
  if (crc != actualCRC) {
    std::cerr << "CRC fail, got " << (int)actualCRC << " expected " << (int)crc
	      << std::endl;
    crc = actualCRC;
    return false;
  }
  return true;
}

SNAPPacket SNAPPacket::reply()
{
  SNAPPacket p;
  p.dab = sab;
  p.sab = dab;
  return p;
}

bool SNAPPacket::send(SNAP &snap, bool verbose)
{
  for(int retries = 0; retries < 5; retries++) {
    crc = 0;
    snap.sendbyte(sync);
    snap.sendbyte(computeCRC(hdb2));
    snap.sendbyte(computeCRC(hdb1));
    snap.sendbyte(computeCRC(dab));
    snap.sendbyte(computeCRC(sab));
    for(int i = 0; i < getLength(); i++) {
      snap.sendbyte(computeCRC(payload[i]));
    }
    snap.sendbyte(crc);

    SNAPPacket p;
    if (!p.readPacket(snap)) {
      std::cerr << "Read fail 1" << std::endl;
      continue;
    }
      
    if (p.isAck()) {
      if (verbose)
	std::cout << "[ACK Received]" << std::endl;
      return true;
    }

    if (p.isNak()) {
      std::cerr << "Got NAK" << std::endl;
      continue;
    }
    std::cerr << "Read fail 2" << std::endl;
  }
  return false;
}

byte SNAPPacket::computeCRC(byte dataval)
{
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

}
