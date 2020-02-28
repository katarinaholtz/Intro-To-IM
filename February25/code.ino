
#include <Servo.h>
#include "pitches.h"
// notes in the melody:
int melody[] = {
  NOTE_C4, NOTE_D4, NOTE_E4, NOTE_C4,
  NOTE_C4, NOTE_D4, NOTE_E4, NOTE_C4,
  NOTE_E4, NOTE_F4, NOTE_G4,
  NOTE_E4, NOTE_F4, NOTE_G4,
  NOTE_G4, NOTE_A4, NOTE_G4, NOTE_F4, NOTE_E4, NOTE_C4,
  NOTE_G4, NOTE_A4, NOTE_G4, NOTE_F4, NOTE_E4, NOTE_C4,
  NOTE_C4, NOTE_G3, NOTE_C4, 0
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 4, 4, 4,
  4, 4, 4, 4,
  4, 4, 2,
  4, 4, 2,
  8, 8, 8, 8, 4, 4,
  8, 8, 8, 8, 4, 4,
  4, 4, 2, 4
};

Servo myservo;                // create servo object to control a servo
int pos = 0;                  // variable to store the servo position
const int servoPin = 11;
const int speakerPin = 10;
const int yellowButton = 9;

void setup() {
  // put your setup code here, to run once:
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  // Set the inputs and attach servo
  pinMode(yellowButton, INPUT); // pin 9
  myservo.attach(11);  // attaches the servo on pin 11 to the servo object

  // move servo to starting position
  myservo.write(90);
}

void loop() {

  // read the button
  int yellow_buttonstate = digitalRead(yellowButton);
  //  Serial.print(yellow_buttonstate);
  //  Serial.print("\n");

  if (yellow_buttonstate == 1) {
    //  the  button was pressed,  start doing t hings

    // frist play the melody:
    for (int thisNote = 0; thisNote < 30; thisNote++) {
      Serial.print("thisNote =  ");
      Serial.print(thisNote);

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000 / 8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      Serial.print(" note = ");
      Serial.print(melody[thisNote]);
      Serial.print(" duration = ");
      Serial.print(noteDuration);

      Serial.println();

      tone(10, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(1);
    }

    // now ring the bell
    Serial.println("ring the bell");
    myservo.write(180);                 // first bell
    delay(500);                       // waits for the servo to get there
    myservo.write(90);                // second bell
    delay(500);
    myservo.write(180);                // third bell
    delay(500);


  }
}
