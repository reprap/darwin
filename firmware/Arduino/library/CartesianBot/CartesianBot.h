/*
	CartesianBot.h -  RepRap Cartesian Bot library for Arduino

	This library is used to interface with a RepRap Cartesian Bot (3 axis X/Y/Z machine)

	Memory Usage Estimate: 8 + 12 * POINT_QUEUE_SIZE + 3 * LinearAxis usage.

	History:
	* (0.1) Ceated initial library by Zach Smith.
	* (0.2) Optimized for smaller size and speed by Zach Smith.
	* (0.3) Rewrote and refactored all code.  Fixed major interrupt bug by Zach Smith. Special thanks to Marius Kintel for finding the bug.

	License: GPL v2.0
*/

// ensure this library description is only included once
#ifndef CartesianBot_h
#define CartesianBot_h

//#include "HardwareSerial.h"
#include "LinearAxis.h"
#include "RepStepper.h"
#include "WConstants.h"

// how big do we want our point queue?
#define POINT_QUEUE_SIZE 31

// our point structure to make things nice.
struct Point {
	int x;
	int y;
 	int z;
 	unsigned char speed;
 	unsigned char control;
};

// library interface description
class CartesianBot {
  public:

    // constructors:
    CartesianBot(
		char x_id, int x_steps, byte x_dir_pin, byte x_step_pin, byte x_min_pin, byte x_max_pin, byte x_enable_pin,
		char y_id, int y_steps, byte y_dir_pin, byte y_step_pin, byte y_min_pin, byte y_max_pin, byte y_enable_pin,
		char z_id, int z_steps, byte z_dir_pin, byte z_step_pin, byte z_min_pin, byte z_max_pin, byte z_enable_pin
	);
	
	// our queue stuff
	bool queuePoint(Point &point);
	struct Point unqueuePoint();
	void clearQueue();
	byte getQueueSize();
	bool isQueueEmpty();
	bool isQueueFull();	
	
	//cartesian bot specific.
	void setTargetPoint(Point &point);
	void setCurrentPoint(Point &point);
	void getNextPoint();
	void calculateDDA();
	bool atTarget() {
          return ((x.current == x.target) && 
                  (y.current == y.target) &&
                  (z.current == z.target));
        }

	bool atHome() {
          return (x.atMin() && y.atMin() && z.atMin());
        }
	
	//our interface methods
	void readState() {
          x.readState();
          y.readState();
          z.readState();
        }
	
	//our timer interrupt interface functions.
	void setupTimerInterrupt();
	void enableTimerInterrupt() {
          //reset our timer to 0 for reliable timing TODO: is this needed?
          //TCNT1 = 0;
          
          //then enable our interrupt!
          TIMSK1 |= (1<<OCIE1A);
        }
	void disableTimerInterrupt() {
          TIMSK1 &= ~(1<<OCIE1A);
        }
        
	void setTimer(unsigned long delay);
	void setTimerResolution(byte r);
	void setTimerCeiling(unsigned int c) {
          OCR1A = c;
        }
	byte getTimerResolution(unsigned long delay);
	unsigned int getTimerCeiling(unsigned long delay);
	
	//our variables
	LinearAxis x;
	LinearAxis y;
	LinearAxis z;

	//for DDA stuff.
	int max_delta;

	//this is the mode we're currently in... started/stopped
	byte mode;
	
	
  private:

	//this is for our queue of points.
	byte head;
	byte tail;
	byte size;

	Point point_queue[POINT_QUEUE_SIZE]; // +1 for luck... AB
};

inline byte CartesianBot::getQueueSize()
{
	return this->size;
}

inline bool CartesianBot::isQueueEmpty()
{
	return (this->size == 0);
}

inline bool CartesianBot::isQueueFull()
{
	return (this->size == POINT_QUEUE_SIZE);
}

#endif
