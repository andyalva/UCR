/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */
 
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led = 13;
int d12 = 12;

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(led, OUTPUT);
  pinMode(d12, OUTPUT);  
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(d12, HIGH);   // turn the LED on (HIGH is the voltage level)
  //delay(1);               // wait for a second/100p6
  digitalWrite(d12, LOW);    // turn the LED off by making the voltage LOW
  //delay(1);               // wait for a second/100
}
