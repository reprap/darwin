
int pwm_a = 9;
int pwm_b = 10;
int pwm_c = 11;
int i;

void setup()
{
	pinMode(pwm_a, OUTPUT);
	pinMode(pwm_b, OUTPUT);
	pinMode(pwm_c, OUTPUT);	

	Serial.begin(9600);
}

void loop()
{
	//
	//fade all channels up and down.
	//
	Serial.println("Fading all pwm channels up to max.");
	for (i=0; i<=255; i++)
	{
		analogWrite(pwm_a, i);
		analogWrite(pwm_b, i);
		analogWrite(pwm_c, i);
	
		delay(100);
	}
	
        Serial.println("All pwm channels at max.");
	delay(1000);
        Serial.println("Fading all channels to 0");
        
        for (i=255; i>=0; i--)
	{
		analogWrite(pwm_a, i);
		analogWrite(pwm_b, i);
		analogWrite(pwm_c, i);

		delay(100);	
	}

	Serial.println("All pwm channels at zero.");
        delay(1000);
	
        fade_channel(pwm_a);
        fade_channel(pwm_b);
        fade_channel(pwm_c);
}

void fade_channel(int channel)
{
	Serial.println("Fading pwm channel to max: ");
        Serial.println(channel);
                
	for (i=0; i<=255; i++)
	{
		analogWrite(pwm_a, i);
		delay(100);
	}

	Serial.println("pwm channel at max.");
        delay(1000);
        Serial.println("fading down.");
	
        for (i=255; i>=0; i--)
	{
		analogWrite(pwm_a, i);
		delay(100);	
	}

	Serial.println("pwm channel at 0.");
        delay(1000);
}
