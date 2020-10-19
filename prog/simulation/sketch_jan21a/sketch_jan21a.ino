#include "TimerOne.h"

void setup() {
  Serial.begin(38400); 
  Timer1.initialize(100);         // 1 000 000 = 1s  (freq. ech.)
  Timer1.pwm(10, 512);                // setup pwm on pin 9, 50% duty cycle
  Timer1.attachInterrupt(maxrequete);  // attaches callback() as a timer overflow interrupt
}

float i=0;

void loop() {
  
  
}

void maxrequete()
{
  i+=0.005;
  Serial.println(String(i)+":");
}






