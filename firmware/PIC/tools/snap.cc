#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/time.h>
#include "snap.h"

SNAP::SNAP(const char *device, int sourceAddress, bool verbose)
{
  localAddress = sourceAddress; 
  this->verbose = verbose;

  struct termios terminfo;
  fd = open(device, O_RDWR | O_NONBLOCK);
  if (fd == -1) {
    perror("Opening port");
    exit(1);
  }
  
  if (tcgetattr(fd, &terminfo) == -1) {
    perror("Get attr");
    exit(1);
  }
  cfsetispeed(&terminfo, B19200);
  cfsetospeed(&terminfo, B19200);
  terminfo.c_cflag &= ~CRTSCTS;
  terminfo.c_cflag |= CLOCAL;
  terminfo.c_lflag &= ~(ICANON | ECHO);
  terminfo.c_oflag &= ~(ONLRET | OCRNL | ONLCR);
  terminfo.c_iflag &= ~(ICRNL | INLCR);
  if (tcsetattr(fd, TCSANOW, &terminfo) == -1) {
    perror("Set attr");
    exit(1);
  }
}

SNAP::~SNAP()
{
  close(fd);
}

SNAPPacket SNAP::createPacket(int destAddr, int length)
{
  SNAPPacket p;
  p.dab = destAddr;
  p.sab = localAddress;
  p.setLength(length);
  return p;
}

byte SNAP::readbyte()
{
  byte buf;
  struct timeval tout;
  tout.tv_sec = 86400;
  tout.tv_usec = 0;

  fd_set r;
  FD_ZERO(&r);
  FD_SET(fd, &r);
  int sr = select(fd + 1, &r, NULL, NULL, &tout);
  if (sr == 0) {
    // Timeout
    throw SNAPTimeoutException();
  }
  if (sr == -1)
    perror("Waiting in readbyte");

  if (read(fd, &buf, 1) < 0) {
    perror("Read failed");
    exit(1);
  }
  if (verbose) {
    printf("[%02x]", (unsigned char)buf);
    fflush(stdout);
  }
  return buf;
}

void SNAP::sendbyte(byte c)
{
  fd_set w;
  FD_ZERO(&w);
  FD_SET(fd, &w);
  int sw = select(fd + 1, NULL, &w, NULL, NULL);
  if (sw == -1)
    perror("Waiting in sendbyte");

  if (verbose) {
    printf("<%02x>", (unsigned char)c);
    fflush(stdout);
  }

  if (write(fd, &c, 1) < 0) {
    perror("Write failed");
  }
}
