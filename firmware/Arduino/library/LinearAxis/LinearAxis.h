/*
	LinearAxis.h - RepRap Linear Axis library for Arduino

	The interface for controlling a linear axis: stepper motor + min/max sensors + optional encoder

	Memory Usage Estimate: 25 + repstepper usage.

	History:
	* (0.1) Created library by Zach Smith.
	* (0.2) Optimized for less memory usage and faster performance
	* (0.3) Rewrote and refactored all code.  Fixed major interrupt bug by Zach Smith.

	License: GPL v2.0
*/

// ensure this library description is only included once
#ifndef LinearAxis_h
#define LinearAxis_h

#include <RepStepper.h>

// library interface description
class LinearAxis {
  public:
    
	// constructors:
    LinearAxis(char id, int steps, byte dir_pin, byte step_pin, byte min_pin, byte max_pin, byte enable_pin);

	//these are our other object variables.
	RepStepper stepper;

	//various guys to interface with class
	void readState();
	void doStep();
	bool atMin();
	bool atMax();
	
	//various position things.
	void setPosition(long position);
	void setTarget(long t);
	void forward1();
	void reverse1();
	
	//dda functions
	void initDDA(long max_delta);
	void ddaStep(long max_delta);

	char id;					//what is our id? x, y, z, etc.
	bool can_step;				//are we capable of taking a step yet?

	long delta;					//our delta for our DDA moves.
	long current;				//this is our current position.
	long target;				//this is our target position.
	long max;					//this is our max coordinate.
	long counter;				//this is our counter variable for dda.

  private:
	
	byte min_pin;
	byte max_pin;
};

inline bool LinearAxis::atMin()
{
	return digitalRead(this->min_pin);
}

/*
 * NB!!!  Turned off by Adrian to free up pins
*/
inline bool LinearAxis::atMax()
{
	return 0;
	//return digitalRead(this->max_pin);
}

inline void LinearAxis::doStep()
{
	//gotta call readState() before you can step again!
	//this->can_step = false;
	
	//record our step
	if (this->stepper.direction == RS_FORWARD)
		this->forward1();
	else
		this->reverse1();
}

inline void LinearAxis::forward1()
{
	stepper.setDirection(RS_FORWARD);
	stepper.pulse();
	
	this->current++;
}

inline void LinearAxis::reverse1()
{
	stepper.setDirection(RS_REVERSE);
	stepper.pulse();
	
	this->current--;
}

inline void LinearAxis::setPosition(long p)
{
	this->current = p;
	
	//recalculate stuff.
	this->setTarget(this->target);
}



inline void LinearAxis::initDDA(long max_delta)
{
	this->counter = -max_delta/2;
}




#endif
