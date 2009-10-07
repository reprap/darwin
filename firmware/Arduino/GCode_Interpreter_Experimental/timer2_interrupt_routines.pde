//these routines provide an easy interface for controlling Timer2 interrupts
volatile int cnt = 0;
volatile int foo2 = 0;

//this handles the timer interrupt event
SIGNAL(SIG_OUTPUT_COMPARE2A)
{
  	// somewhat hacked implementation of a PID algorithm as described at:
	// http://www.embedded.com/2000/0010/0010feat3.htm - PID Without a PhD, Tim Wescott 
	
	int abs_error = abs(extruder_error);
	int pTerm = 0;
	int iTerm = 0;
	int dTerm = 0;
	int speed = 0;

/*
	//THIS WAS WAY MORE TROUBLE THAN IT WAS WORTH. ABORTED PRINTS 3/4 OF THE WAY THROUGH. ARGH.
	
	//if our error is too high, it means we cant keep up.  bail to protect the extruder motor
	if (abs_error > 750)
	{
		disableTimer1Interrupt();
		disableTimer2Interrupt();
		extruder_error = 0;
		analogWrite(EXTRUDER_MOTOR_SPEED_PIN, 0);
		Serial.println("Extruder Fail");
	}
	else
	{
*/
		//hack for extruder not keeping up, overflowing, then shutting off.
		if (extruder_error < -5000)
			extruder_error = -500;
		if (extruder_error > 5000)
			extruder_error = 500;

		if (extruder_error < 0)
		{
			//calculate our P term
			pTerm = abs_error / extruder_pGain;
	
			//calculate our I term
			iState += abs_error;
			iState = constrain(iState, iMin, iMax);
			iTerm = iState / extruder_iGain;
	
			//calculate our D term
			dTerm = (abs_error - dState) * extruder_dGain;
			dState = abs_error;

			//calculate our PWM, within bounds.
			speed = pTerm + iTerm - dTerm;
		}

		//our debug loop checker thingie
		/*
		cnt++;
		if (cnt > 250)
		{
			Serial.print("e:");
			Serial.println(extruder_error);
			Serial.print("spd:");
			Serial.println(speed);
			cnt = 0;
		}
		*/

		//figure out our real speed and use it.
		speed = constrain(speed, EXTRUDER_MIN_SPEED, EXTRUDER_MAX_SPEED);

                //debug
                //if (foo2 > 1000)
                //{
                //  foo2 = 0;
                //  Serial.print(extruder_error);
                //  Serial.print("/");
                //  Serial.println(speed);
                //}
                foo2++;

		analogWrite(EXTRUDER_MOTOR_SPEED_PIN, speed);
//	}
}
/*
SIGNAL(SIG_OUTPUT_COMPARE2A)
{
	// straight-forward implementation of a PID algorithm as described at:
	// http://www.embedded.com/2000/0010/0010feat3.htm - PID Without a PhD, Tim Wescott 

	float pTerm;
	float iTerm;
	float dTerm;
	int speed;
	int abs_error = abs(extruder_error);

	//if our error is too high, it means we cant keep up.  bail to protect the extruder motor
	if (abs_error > 1000)
	{
		disableTimer1Interrupt();
		disableTimer2Interrupt();
		extruder_error = 0;
		analogWrite(EXTRUDER_MOTOR_SPEED_PIN, 0);
		Serial.println("Extruder Fail");
	}
	else
	{
		//calculate our P term
		pTerm = extruder_pGain * (float)abs_error;
	
		//calculate our I term
		iState += -extruder_error;
		if (iState > iMax)
			iState = iMax;
		else if (iState < iMin)
			iState = iMin;
		iTerm = extruder_iGain * (float)iState;
	
		//calculate our D term
		dTerm = extruder_dGain * (float)(abs_error - dState);
		dState = abs_error;

		//calculate our PWM
		int speed = ceil(pTerm + iTerm - dTerm);

		//do some bounds checking.
		speed = max(speed, EXTRUDER_MIN_SPEED);
		speed = min(speed, EXTRUDER_MAX_SPEED);

		//our debug loop.
		cnt++;
		if (cnt > 250)
		{
			Serial.print("e:");
			Serial.println(extruder_error);
			Serial.print("spd:");
			Serial.println(speed);
			cnt = 0;
		}

		digitalWrite(EXTRUDER_MOTOR_DIR_PIN, EXTRUDER_FORWARD);
		analogWrite(EXTRUDER_MOTOR_SPEED_PIN, speed);
	}
}
*/

void enableTimer2Interrupt()
{
	//enable our interrupt!
	TIMSK2 |= (1<<OCIE2A);
}

void disableTimer2Interrupt()
{
	TIMSK2 &= ~(1<<OCIE2A);
}

void setTimer2Resolution(byte r)
{
	//from table 17-9 in that atmega168 datasheet:
	// we're setting CS22 - CS20 which correspond to the binary numbers 0-7
	// 0 = no timer
	// 1 = no prescaler
	// 2 = clock/8
	// 3 = clock/32
	// 4 = clock/64
	// 5 = clock/128
	// 6 = clock/256
	// 7 = clock/1024
	
	if (r > 7)
		r = 7;
		
	TCCR2B &= B11111000;
	TCCR2B |= r;
}

void setTimer2Ceiling(byte c)
{
	OCR2A = c;
}


byte getTimer2Ceiling(unsigned long ticks)
{
	if (ticks <= 255L)
		return (ticks & 0xff);
	else if (ticks <= 2040L)
		return ((ticks / 8) & 0xff);
	else if (ticks <= 8160L)
		return ((ticks / 32) & 0xff);
	else if (ticks <= 16320L)
		return ((ticks / 64) & 0xff);
	else if (ticks <= 32640L)
		return ((ticks / 128) & 0xff);
	else if (ticks <= 65280L)
		return ((ticks / 256) & 0xff);
	else if (ticks <= 261120L)
		return ((ticks / 1024) & 0xff);
	else
		return 255;
}

byte getTimer2Resolution(unsigned long ticks)
{
	if (ticks <= 255L)
		return 1;
	else if (ticks <= 2040L)
		return 2;
	else if (ticks <= 8160L)
		return 3;
	else if (ticks <= 16320L)
		return 4;
	else if (ticks <= 32640L)
		return 5;
	else if (ticks <= 65280L)
		return 6;
	else if (ticks <= 261120L)
		return 7;
	else
		return 7;
}

void setTimer2Ticks(unsigned long ticks)
{
	// ticks is the delay between interrupts in 4 microsecond ticks.
	//
	// we break it into 5 different resolutions based on the delay. 
	// then we set the resolution based on the size of the delay.
	// we also then calculate the timer ceiling required. (ie what the counter counts to)
	// the result is the timer counts up to the appropriate time and then fires an interrupt.

	setTimer2Ceiling(getTimer2Ceiling(ticks));
	setTimer2Resolution(getTimer2Resolution(ticks));
}

void setupTimer2Interrupt()
{
	//clear the registers
	TCCR2A = 0;
	TCCR2B = 0;
	TIMSK2 = 0;
	
	//waveform generation = 010 = CTC
	TCCR2B &= ~(1<<WGM22);
	TCCR2A |=  (1<<WGM21); 
	TCCR2A &= ~(1<<WGM20);

	//output mode = 00 (disconnected)
	TCCR2A &= ~(1<<COM2A1); 
	TCCR2A &= ~(1<<COM2A0);
	TCCR2A &= ~(1<<COM2B1); 
	TCCR2A &= ~(1<<COM2B0);

	//start off with a slow frequency.
	setTimer2Resolution(7);
	setTimer2Ceiling(255);
	disableTimer2Interrupt();
}

