/*
 * Class to handle internal communications in the machine via RS485
 *
 * Adrian Bowyer 3 July 2009
 *
 */

#include "intercom.h"

intercom::intercom()
{
  reset();
  pinMode(RX_ENABLE_PIN, OUTPUT);
  pinMode(TX_ENABLE_PIN, OUTPUT);
  digitalWrite(RX_ENABLE_PIN, 0); //always listen.
  serialInterface.begin(RS485_BAUD);  
}

void intercom::sendPacket(char* to, char* string)
{
  digitalWrite(TX_ENABLE_PIN, 1);
  serialInterface.print(to[0]); // Make sure we send exactly two bytes
  serialInterface.print(to[1]);
  serialInterface.print(MY_NAME); // This should be two bytes
  serialInterface.println(string);
  digitalWrite(TX_ENABLE_PIN, 0);
}

void intercom::sendPacketWithReply(char* to, char* string, char* resp, int len)
{
  sendPacket(to, string);
  getPacket(resp, len);  
}

void intercom::getPacket(char* string, int len)
{
  int i = -1;
  ok = true;
  do
  {
    while(!serialInterface.available());
    i++;
    // Stop runaway buffer overflow
    if(i >= len)
    {
      ok = false; 
      i--;
    } else
      string[i] = serialInterface.read();
  } while(string[i] != '\n' && ok);
  string[i] = 0;
}

void intercom::reset()
{
   buf_pointer = 0;
   reply[0] = 0;   
}

void intercom::acknowledgeAndReset(char* to)
{
  if(!reply[0])
    reply[1] = 0;
  reply[0] = ACK;
  talker.sendPacket(to, reply);
  reset();
}
  
void intercom::getAndProcessCommand()
{
  if(!serialInterface.available())
    return;
  buffer[buf_pointer] = serialInterface.read();
  if(buffer[buf_pointer] == '\n')
  {
      buffer[buf_pointer] = 0;
      if(!sameName(buffer, MY_NAME)) // For me?
      {
        reset(); // No
        return;
      }
      ex.processCommand(&buffer[4]);
      acknowledgeAndReset(&buffer[2]);
  }else
      buf_pointer++;
  if(buf_pointer >= BUF_LEN)
  {
     reset();
     setReply(" !Buffer overrun");
  }
}

void intercom::setReply(char* string)
{
  strcpy(reply, string);
}

void intercom::addReply(char* string)
{
  strcat(reply, string);  
}

char* intercom::getReply()
{
  return reply;  
}
