/*
 * Class to handle internal communications in the machine via RS485
 *
 * Adrian Bowyer 3 July 2009
 *
 */
 
 /* 
 
   A data packet looks like this:
 
     T T F F d a t a '\n'
     
   All these are printable characters.  TT is the two-char name of the destination, FF is the two-char name
   of the source, data is a char string containing the message, which is terminated by a '\n' character.
   If users wish they can include checksum and length information in the data, as long as it is all printable.
   The total length of a packet with all of that should not exceed BUF_LEN (defined in configuration.h) 
   characters.  When a packet is received the '\n' character is replaced by 0, thus forming a standard C string.
 
 */
 
#ifndef INTERCOM_H
#define INTERCOM_H

// Our RS485 driver

#define serialInterface Serial

// compare two names
#define sameName(a, b) ((a)[0] == (b)[0] && (a)[1] == (b)[1])

// The acknowledge character
#define ACK 'A'                       

// Size of the transmit and receive buffers
#define BUF_LEN 30

class intercom
{
  private:
  
  // The input buffer for incoming packets
    char buffer[BUF_LEN];
    int buf_pointer;

/*
 Any short message can be returned with the next acknowledgement in this string.
 This includes things like temperatures and so on.
 
 Assign to it like this: 
 
    setReply(" My message");
    
 with a blank first character.  This will be overwritten with the ACK
 character.  
 
 Errors should be flagged with '!': 
 
    setReply(" !Horrible error.");
    
 You can append extra information on the end with
 
    addReply("additional info");
    
 Don't exceed BUF_LEN - 4
 
*/
    char reply[BUF_LEN];
    bool ok;
    void getPacket(char* string, int len);
    void sendPacket(char* to, char* string);
    void sendPacketWithReply(char* to, char* string, char* resp, int len);
    void reset();
    void acknowledgeAndReset(char* to);
    
  public:
    intercom();
    void getAndProcessCommand();
    void setReply(char* string);
    void addReply(char* string);
    char* getReply();
};

extern intercom talker;

#endif

