// -*- c++ -*-
#ifndef _snap_packet_h
#define _snap_packet_h

typedef unsigned char byte;

class SNAP;

class SNAPTimeoutException {
};

class SNAPPacket
{
public:

  /// An empty packet
  SNAPPacket();

  SNAPPacket(SNAP &snap) {
    readPacket(snap);
  }

  /// Read a packet
  bool readPacket(SNAP &snap);

  /// Create a reply packet
  SNAPPacket reply();

  /// Send our content
  bool send(SNAP &snap, bool verbose);

  /// Length helper functions
  int getLength() const {
    int l = hdb1 & 0x0f;
    if (l & 8) return 8 << (l & 7);
    return l;
  }
  void setLength(int length) {
    hdb1 = (hdb1 & 0xf0) | (length > 7 ? 8 : length);
  }

  bool isAck() {
    return ((hdb2 & 3) == 2);
  }

  bool isNak() {
    return ((hdb2 & 3) == 3);
  }

  byte sync;
  byte hdb2;
  byte hdb1;
  byte dab;
  byte sab;
  byte payload[16];
  byte crc;

private:
  byte computeCRC(byte dataval);
};


#endif
