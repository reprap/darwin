
#include<math.h>

int a_InPin = 0;    // select the input pin for the potentiometer
     
int val;

double r0;
double r1;
double r2;
double t0;
double beta;
double vadc;
double vcc;
double vs;
double rs;
double k;

double celsius;

void setup()
{
  // begin the serial communication
  Serial.begin(9600);
 
  r0 = 10000.0;
  r1 = 680;
  r2 = 1600;
  t0 = 25.0 + 273.15;
  beta = 3500.0;
  vadc = 5.0;
  vcc = 5.0;
  vs = (r1 * vcc) / (r1 + r2);
  rs = (r1 * r2) / (r1 + r2);
//  k = r0 * pow(2.178, (-beta / t0)); // 1.07527403
  k = 1.07527403;
}

void loop()
{
  
  int celhold;
  
  val = analogRead(a_InPin);    // read the value from the analog pin
  celsius = to_temp(val);
  
  Serial.println((long)celsius);            // Write the value to the serial port
  delay(1000);                  // stop the program for 1 sec

}


double to_temp(int reading)
{
  float v; 
  double r;
       
       Serial.print("reading:");
       Serial.println(reading);
       v = (float)((reading * vadc) / 1024.0);          // convert the 10 bit ADC value to a voltage
       Serial.print("voltage:");
       Serial.println((long)(v * 1000));
       r = (rs * v) / (vs - v);     // resistance of thermistor
       Serial.print("resistance:");
       Serial.println((long)r);
       return ((beta / log(r / k)) - 273.15);        // temperature
}

/*
float to_adc(int temp)
{
         "Convert a temperature into a ADC value"
       r = self.r0 * exp(self.beta * (1 / (t + 273.15) - 1 / self.t0)) # resistance of the thermistor
       v = self.vs * r / (self.rs + r)     # the voltage at the potential divider
       return round(v / self.vadc * 1024)  # the ADC reading
}
*/
