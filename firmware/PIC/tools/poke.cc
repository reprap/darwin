#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <termios.h>
#include <getopt.h>
#include <string>
#include <iostream>

#include "snap.h"

using namespace std;

void outputData(const SNAPPacket &p)
{
  for(int i = 0; i < p.getLength(); i++) {
    if (i > 0)
      cout << " ";
    cout << (int)p.payload[i];
  }
  cout << endl;
}

int main(int argc, char **argv)
{
  bool wait = false;
  int dest = 1;
  const char *tty = "/dev/ttyS1";
  bool verbose = false;


  int opt;
  while((opt = getopt(argc, argv, "hwd:t:v")) != -1) {
    switch(opt) {
    case 'h':
      printf("poke - a test tool for Simon's SNAP RepRap protocol\n"
	"\tw\tWait.\n"
	"\td n\tSend to device n\n"
	"\tv\tVerbose mode - show serial data\n"
	"\tt xxx\tUse serial port xxx\n\n");
      exit(-1);

     case 'w':
      wait = true;
      break;
    case 'd':
      dest = atoi(optarg);
      break;
    case 'v':
      verbose = true;
      break;
    case 't':
      tty = optarg;
    }
  }

  SNAP snap(tty, 0, verbose);
    
  string cmd;
  int dataidx = 0;

  SNAPPacket toSend = snap.createPacket(dest);

  for(;;) {
    cin >> cmd;
    if (cin.eof())
      break;

    if (cmd == ".") {
      toSend.setLength(dataidx);
      toSend.send(snap, verbose);
      dataidx = 0;
    } else if (cmd == "w") {
      SNAPPacket response(snap);
      outputData(response);
    } else if (cmd[0] == 'p' && cmd.length() > 1) {
      int pause = strtol(cmd.c_str() + 1, NULL, 0);
      usleep(pause * 1000);
    } else if (dataidx < 16)
      toSend.payload[dataidx++] = strtol(cmd.c_str(), NULL, 0);
  }
  if (dataidx > 0) {
    toSend.setLength(dataidx);
    toSend.send(snap, verbose);
  }

  if (wait) {
    SNAPPacket response(snap);
    outputData(response);
  }

  return 0;
}
