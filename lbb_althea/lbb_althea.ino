

int sensorPin = A0;   
int sensorValue = 0;  // variable to store the value coming from the sensor
int pins[3] = {0, 1, 2};
int npins = 3;
int max_brightness = 255;

void setup() {
  // declare the ledPin as an OUTPUT:
  for (int i = 0; i < npins; i++) {
    pinMode(pins[i], OUTPUT);
  }
}

void loop() {
  // read the value from the sensor:
  sensorValue = readPressure(sensorPin);
  int *p = pins;
  fadedn(p, 3);
  sensorValue = readPressure(sensorPin);
  fadeup(p, 3);
}

int readPressure(int pin) {
  int s = analogRead(pin);
  Serial.println(s); 
  return s;
}

void fadedn(int* pin, int npins) {
  int bness = max_brightness;
  int inc = 1;
  while (bness > 0) {
    readPressure(sensorPin); // for serial write only
    for (int i = 0; i < npins; i++) {
      analogWrite(pin[i], bness);
    }
    bness -= inc;
    inc++;
    delay(50);
  }
}

void fadeup(int* pin, int npins) {
  int bness = 0;
  int inc = 1;
  while (bness < max_brightness) {
    sensorValue = readPressure(sensorPin);
    max_brightness = map(sensorValue, 300, 1000, 32, 255);
    max_brightness = constrain( max_brightness, 0, 255);
    for (int i = 0; i < npins; i++) {
      analogWrite(pin[i], bness);
    }
    bness += inc;
    inc++;
    delay(50);
  }
}


