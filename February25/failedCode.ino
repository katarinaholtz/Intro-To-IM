
#include <Servo.h>
#include "pitches.h"
// notes in the melody:
int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};

Servo myservo;                // create servo object to control a servo
int pos = 0;                  // variable to store the servo position
int val;                      // variable to read the value from the analog pin
const int lightSensor = A0;
const int servoPin = 11;
const int speakerPin = 10;
const int yellowButton = 9;

void setup() {
  // put your setup code here, to run once:
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  // Set the inputs and outputs
  pinMode(lightSensor, INPUT);  // pin A0 is one of the analogRead capable pins
  pinMode(yellowButton, INPUT); // pin 9
  myservo.attach(11);  // attaches the servo on pin 11 to the servo object
}

void loop() {

  // read the button
  int yellow_buttonstate = digitalRead(yellowButton);
  Serial.print(yellow_buttonstate);
  Serial.print("\n");

  if (yellow_buttonstate == 1) {
    // iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 8; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000 / 8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(10, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(10);

      val = map(val, 0, 1023, 0, 180);     // scale it to use it with the servo (value between 0 and 180)
      myservo.write(90);                  // sets the servo position according to the scaled value
      delay(15);                          // waits for the servo to get there
    }


  }
}


