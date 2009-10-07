// -*- c++ -*-

#ifndef _snap_h
#define _snap_h

// Simplified SNAP representation. This will done properly in the Java version.
// Very simple blocking version.

#include "snap_packet.h"

class SNAP
{
public:
  SNAP(const char *device, int sourceAddress, bool verbose);
  ~SNAP();

  /// Read a single byte
  byte readbyte();

  /// Send a single byte
  void sendbyte(byte c);
  SNAPPacket createPacket(int destAddr, int length = 0);

private:
  int fd;
  int localAddress;
  bool verbose;
};

#endif
