import processing.serial.*;

/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;
import processing.sound.*;
//import java.util.locale.*;

Letter letter;
Delay delay;
SinOsc sine;
Reverb reverb;
PImage sprite;
PImage background;
int[] notes = { 880, 784, 392, 494, 330, 392, 440, 494, 165, 494, 392, 523 };
int note = 0;
int y;
PFont font;
Letter[] letters;
String english = "TOUCH";
String czeck = "DOTEK";
String french = "TOUCHE";
String german = "BERÜHREN";
String japanese = "タッチ";
String chinese = "觸摸";
String italian ="TOCCARE";
String arabic = "لمس";
String swedish = "RÖRA";
String korean = "터치";
String ukrainian = "СЕНСОРНИЙ";
String urdu = "چھو";
//String hebrew = "לָגַעַת;"
PShape part;
StringBuilder mainString;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

void setup() 
{
  //opacity should be 52%
  background = loadImage("world_map_shrinked.png");
  size(1074, 1280);

  mainString = new StringBuilder(); 
  mainString.append(english);
  mainString.append(ukrainian);
  mainString.append(french);
  mainString.append(urdu);
  mainString.append(italian);
  mainString.append(korean);
  mainString.append(japanese);
  mainString.append(german);
  mainString.append(swedish);
  mainString.append(arabic);
  mainString.append(czeck);

  //create font
  font = createFont("Arial", 17, true);

  //to create the letters.

  letters = new Letter[mainString.length()];
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  for (int i = 0; i < Serial.list().length; i++) {
    println(Serial.list()[0]);
  }
  String portName = "/dev/cu.LightBlue-Bean"; //Serial.list()[3];
  myPort = new Serial(this, portName, 57600);
  frameRate(15);

  delay = new Delay(this);

  delay.time(0.5);

  int x = 246;
  for (int i = 0; i < mainString.length(); i++) {
    letters[i] = new Letter(random(100, 1000), random(100, 850), mainString.charAt(i)); 
    x += textWidth(mainString.charAt(i));
  }
  /* reverb = new Reverb(this);
   reverb.room(1.0);
   reverb.wet(1.0);
   
   
   sine = new SinOsc(this);
   //create a delay effect
   delay = new Delay(this);
   
   
   sine.play();
   
   sine.amp(1.0);
   
   
   delay.process(reverb, 1);
   // Patch the delay
   //delay.process(sine, 5);
   delay.time(0.5);
   delay.feedback(0.5);*/

  smooth();
}

void draw()
{
  background(255);
  image(background, 0, 0);
  tint(255, 126); 
  textFont(font, 25);
  //fill(45);

  for (int i = 0; i < letters.length; i++) {
    // Display all letters
    letters[i].display();
    //letters[i].shake(0.5, 0.5);
  }

  //int xPos=200;

  if ( myPort.available() > 0) {  // If data is available,
    //val = myPort.read();         // read it and store it in val
    String myString = myPort.readStringUntil(10);
    if (myString != null ) {
      myString = trim(myString);
      println( "str before" + myString );
      if ( myString.length() > 2 &&  myString.length() < 5 ) {
        println( "str" + myString );
        val = (int)Integer.parseInt(myString);
        val = (int)map(val, 100, 1000, 0, 204);
        println("value after map" + val);
        // Display all letters
        if (val >= 10 && val <= 50) {//40 around 
          //Don't shake
        } else if(val >= 130){
          //fill(255, 0, 0, alphaValue);
          textAlign(CENTER);
          textSize(120);
          fill(102,102,0);
          text("T O U C H", 540, 560);
         
          
        } else {                 
          letters[(int)random(0, letters.length)].shake(val *2, val* 2);
        }
        
      

        //val = (int)map(val, 100, 1000, 0, 204);
        //note = (int)map(val, 0, 204, 0, 11);
        //constrain( note, 0, 11 );
        //println( "note = " + note );
      }
    }
  }

  //sine.freq(notes[note]);
  //fill(val);
}