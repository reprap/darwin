int dir_pin_a = 4;
int speed_pin_a = 5;
int dir_pin_b = 6;
int speed_pin_b = 7;

int i;

void setup()
{
	pinMode(dir_pin_a, OUTPUT);
	pinMode(speed_pin_a, OUTPUT);
	pinMode(dir_pin_b, OUTPUT);
	pinMode(speed_pin_b, OUTPUT);
	
	Serial.begin(9600);

	//make the motors rotate in opposite directions so show that they're working independantly.
	digitalWrite(dir_pin_a, HIGH);
	digitalWrite(dir_pin_b, LOW);
}

void loop()
{
	Serial.println("Speeding motors up to max.");
	
	for (i=0; i<=255; i++)
	{
		analogWrite(speed_pin_a, i);
		analogWrite(speed_pin_b, i);
		
		delay(100);
	}

        Serial.println("Motors at max.");
        delay(1000);
	Serial.println("Slowing down to 0;");

	for (i=255; i>=0; i--)
	{
		analogWrite(speed_pin_a, i);
		analogWrite(speed_pin_b, i);
		
		delay(100);
	}

	Serial.println("Motors stopped.");
        delay(1000);
        Serial.println("Switching directions.");

	digitalWrite(dir_pin_a, !digitalRead(dir_pin_a));
	digitalWrite(dir_pin_b, !digitalRead(dir_pin_b));
}
