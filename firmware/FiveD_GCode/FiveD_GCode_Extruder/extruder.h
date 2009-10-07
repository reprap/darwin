#ifndef EXTRUDER_H
#define EXTRUDER_H

#define WAIT_T 'W'        // wait_for_temperature();
#define VALVE 'V'          // valve_set(bool open, int dTime);
#define DIRECTION 'D'   // set_direction(bool direction);
#define COOL 'C'           // set_cooler(byte e_speed);
#define SET_T 'T'           // set_temperature(int temp);
#define GET_T 't'           // get_temperature();
#define STEP 'S'             // step();
#define ENABLE 'E'       // enableStep();
#define DISABLE 'e'       // disableStep();
#define PING 'P'            // Just acknowledge

class extruder
{
private:
//********************************************************************************
// Stepper motor section

// We will half-step;  coilPosition will take values between 0 and 7 inclusive

  byte coilPosition;

// This variable stores the value (0..255) of the on-board potentiometer.  This is used 
// to vary the PWM mark-space values in analogWrites() to the enable pins, hence 
// controlling the effective motor current.

  byte potValue;
  bool h1Enable;
  bool h2Enable;
  bool forward;

 
public:
   extruder();
   void wait_for_temperature();
   void valve_set(bool open);
   void set_direction(bool direction);
   void set_cooler(byte e_speed);
   void set_temperature(int temp);
   int get_temperature();
   void manage();
   void step();
   void enableStep();
   void disableStep();
   void processCommand(char command[]);
   
};

#endif

