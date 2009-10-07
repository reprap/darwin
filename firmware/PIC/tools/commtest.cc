#include <iostream>
#include <list>
#include <iomanip>
#include <boost/test/unit_test.hpp>
#include <boost/thread/thread.hpp>
#include <unistd.h>

using namespace std;
using namespace boost::unit_test_framework;

#define BIT_AT
#include "pic14.h"

byte OERR, CREN, RCIF = 0, TXIF = 0;
#define deviceAddress 1

void serialInterruptHandler();

class receive {
public:
  receive()
  {
  }

  operator byte()
  {
    if (m_queue.size() == 0) {
      cerr << "Receive underflow" << endl;
      return 0;
    }
    byte c = m_queue.front();
    m_queue.pop_front();
    cout << "< " << setw(2) << setfill('0') << hex << (int)c << endl;
    if (m_queue.size() == 0)
      RCIF = 0;
    return c;
  }

  void queue(byte c)
  {
    m_queue.push_back(c);
    RCIF = 1;
  }

  private:
  std::list<byte> m_queue;

};

class send
{
public:
  send()
  {
    m_enabled = false;
  }

  byte operator=(const byte &b)
  {
    m_queue.push_back(b);
    cout << ">   " << setw(2) << setfill('0') << hex << (int)b << endl;
    TXIF = 1;
    return b;
  }

  void enable(bool b)
  {
    if (!m_enabled && b) {
      // enabling
      TXIF = 1;
    }
    m_enabled = b;
  }

  bool enabled()
  {
    return m_enabled;
  }

  void processTransmits()
  {
    for(;;) {
      if (m_enabled && TXIF) {
	serialInterruptHandler();
      }
      usleep(1000);
    }
  }

  bool expect(byte v, int maxwait)
  {
    while(m_queue.size() == 0) {
      
    }
    byte c = m_queue.front();
    m_queue.pop_front();
    return c == v;
  }

private:
  bool m_enabled;
  std::list<byte> m_queue;
};

class sendEnable
{
public:
  sendEnable(send *sender)
  {
    m_sender = sender;
  }

  byte operator=(const byte &b)
  {
    m_sender->enable(b);
    return b;
  }
  operator byte() 
  {
    return m_sender->enabled();
  }

private:
  send *m_sender;
};

receive RCREG;
send TXREG;
sendEnable TXIE(&TXREG);

#include "serial-inc.c"
#include "serial-inc2.c"

bool waitForLock()
{
  for(;;) {
    serialInterruptHandler();
    if (processingLock)
      break;
    usleep(1000);
  }
  return true;
}

void rxbytes(string bytes)
{
  // not very robust :)
  int idx = 0;
  while(idx < bytes.length()) {
    int newidx = bytes.find(' ', idx + 1);
    if (newidx == string::npos) newidx = bytes.length();
    const char *p = bytes.substr(idx, newidx - idx).c_str();
    RCREG.queue(strtol(p, NULL, 16));
    idx = newidx + 1;
  }
}

void expectbytes(string bytes)
{
  // not very robust :)
  int idx = 0;
  while(idx < bytes.length()) {
    int newidx = bytes.find(' ', idx + 1);
    if (newidx == string::npos) newidx = bytes.length();
    const char *p = bytes.substr(idx, newidx - idx).c_str();
    BOOST_CHECK(TXREG.expect(strtol(p, NULL, 16), 1));
    idx = newidx + 1;
  }
}

void simple_test()
{
  cout << "simple_test" << endl;
  rxbytes("54 51 31 01 00 00 34");
  waitForLock();
  expectbytes("54 52 30 00 01 5f");
  releaseLock();
}

void send_test()
{
  cout << "send_test" << endl;
  rxbytes("54 51 31 01 00 00 34");
  waitForLock();
  expectbytes("54 52 30 00 01 5f"); // The ack
  sendReply();
  sendDataByte('t');
  sendDataByte('e');
  sendDataByte('s');
  sendDataByte('t');
  endMessage();
  expectbytes("54 51 34 00 01 74 65 73 74 3f"); // The real reply
  releaseLock();
}

void passon_test()
{
  // This tests what happens when bytes are received for another
  // node (they should be forwarded on)
  cout << "passon_test" << endl;
  rxbytes("54 51 31 02 00 00 30");
  waitForLock();
  expectbytes("54 52 30 00 01 00");
  releaseLock();
}

void noresponse_test()
{
  // This tests what happens when a packet is received sent
  // from a nodes own address.  It should be treated as a NAK
  // and resent.
  cout << "noresponse_test" << endl;
  rxbytes("54 51 31 02 01 30");
  expectbytes("54 52 30 00 01 00");
}

void txthread()
{
  TXREG.processTransmits();
}

test_suite *init_unit_test_suite(int argc, char *argv[])
{
  boost::thread thrd(&txthread);

  test_suite *logic = BOOST_TEST_SUITE("Communication tests");
  
  logic->add(BOOST_TEST_CASE(&simple_test));
  logic->add(BOOST_TEST_CASE(&send_test));
  logic->add(BOOST_TEST_CASE(&passon_test));
  logic->add(BOOST_TEST_CASE(&noresponse_test));

  return logic;
  
}
