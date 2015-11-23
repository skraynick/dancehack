class Letter {
  char letter;
  // The object knows its original "home" location
  float homex,homey;
  // As well as its current location
  float x,y;
  //float xspeed = 0.5;
  //float yspeed = 0.5;
  StringBuilder builder;

  Letter (float x_, float y_, char letter_) {
    homex = x = x_;
    homey = y = y_;
    letter = letter_; 
  }

  // Display the letter
  void display() {
     // Add the current speed to the location.
     
    fill(0);
    textAlign(LEFT);
    text(letter,x,y);
  }

  // Move the letter randomly
  //TODO fix animation to fit area.
  void shake(float xspeed, float yspeed) {
      x = x + xspeed;
     y = y + yspeed;
     // Check for bouncing
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
    //x += random(-1,3);
    //y += random(-1,3);
  }

  // Return the letter home
  void home() {
    x = homex;
    y = homey; 
  }
  
  public StringBuilder bringLettersBackTogether(String toAppend) {
    builder = new StringBuilder();
    builder.append(toAppend);
    return builder;
  }
  
  
    
}