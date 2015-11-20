/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;
import processing.sound.*;

Delay delay;
SinOsc sine;
Reverb reverb;

int[] notes = { 880, 784, 392, 494, 330, 392, 440, 494, 165, 494, 392, 523 };
int note = 0;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

void setup() 
{
  size(1100, 1100);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  for (int i = 0; i < Serial.list().length; i++) {
    println(Serial.list()[0]);
  }
  String portName = "/tmp/cu.LightBlue-Bean"; //Serial.list()[3];
  myPort = new Serial(this, portName, 57600);
  frameRate(15);

  delay = new Delay(this);

  delay.time(0.5);

  reverb = new Reverb(this);
  reverb.room(1.0);
  reverb.wet(1.0);


  sine = new SinOsc(this);
  // create a delay effect
  // delay = new Delay(this);


  sine.play();

  sine.amp(1.0);


  delay.process(reverb, 1);
  // Patch the delay
  //delay.process(sine, 5);
  delay.time(0.5);
  delay.feedback(0.5);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    //val = myPort.read();         // read it and store it in val
    String myString = myPort.readStringUntil(10);
    if (myString != null ) {
      myString = trim(myString);
      if ( myString.length() > 2 &&  myString.length() < 5 ) {
        println( "str" + myString );
        val = (int)Integer.parseInt(myString);
        val = (int)map(val, 100, 1000, 0, 204);
        note = (int)map(val, 0, 204, 0, 11);
        constrain( note, 0, 11 );
        println( "note = " + note );
      }
    }
  }

  sine.freq(notes[note]);
  background(255);             // Set background to white
  println( val );
  fill(val);
  rect(50, 50, 1000, 1000);
}