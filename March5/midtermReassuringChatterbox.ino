/*
  REASSURING MESSAGE CHATTER BOX
  by Katarina Holtzapple
  5 March 2020

  made using parts of Hello World code example in the public domain
  http://www.arduino.cc/en/Tutorial/LiquidCrystalHelloWorld

  and using parts of Melody code example in the public domain
  by Tom Igoe
  http://www.arduino.cc/en/Tutorial/Tone


  The Reassuring Message Chatter Box is a spin on the traditional fortune teller chatter
  box of our elementary school years. This one interacts with an LCD screen that prompts
  users to start by rating their day on a scale of 1-10, and then choosing a mood.
  When the user flips open the flap, instead of a fortune, there will be a prompt to
  'press here' and that sends a message to the LCD.

  Set-up below:
*/


// Include the library codes:
#include <LiquidCrystal.h>
#include "pitches.h"

// Initialize library by associating needed LCD interface pin with the arduino pin number it's connected to
const int rs = 13, en = 12, d4 = 11, d5 = 10, d6 = 9, d7 = 8;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

//Set variables for force sensors
const int anxiousSensor = A5;
const int pensiveSensor = A4;
const int boredSensor = A3;
const int confusedSensor = A2;
const int lonelySensor = A1;
const int overwhelmedSensor = A0;

const int speaker = 6;

// Notes in the melody that will play when reassuring message is displayed:
int melody[] = {
  NOTE_E4, NOTE_G4, NOTE_C5
};
// Note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 4, 4
};


void setup() {
  // Initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  //Set the inputs and outputs
  pinMode(anxiousSensor, INPUT); // pin A5
  pinMode(pensiveSensor, INPUT); // pin A4
  pinMode(boredSensor, INPUT); // pin A3
  pinMode(confusedSensor, INPUT); // pin A2
  pinMode(lonelySensor, INPUT); // pin A1
  pinMode(overwhelmedSensor, INPUT); // pin A0
  pinMode(rs, OUTPUT); // LCD pin 13
  pinMode(en, OUTPUT); // LCD pin 12
  pinMode(d4, OUTPUT); // LCD pin 11
  pinMode(d5, OUTPUT); // LCD pin 10
  pinMode(d6, OUTPUT); // LCD pin 9
  pinMode(d7, OUTPUT); // LCD pin 8
  pinMode(speaker, OUTPUT); // pin 6
}

void loop() {
  // Read the anxiousSensor force sensor
  int anxiousSensorValue = analogRead(anxiousSensor);               //Displayed between 930 (touch) and 837 (no touch)
  //Map the value:
  int anxiousMappedValue;
  anxiousMappedValue = map(anxiousSensorValue, 934, 837, 0, 255);  // (Touch, No Touch) A mapped value less than 2 will prompt message
  Serial.print("anxious raw value = ");
  Serial.print(anxiousSensorValue);
  Serial.print(" mapped value = ");
  Serial.println(anxiousMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor

  // Read the pensiveSensor force sensor
  int pensiveSensorValue = analogRead(pensiveSensor);                //Displayed between 966 (touch) and 839 (no touch)
  //Map the value:
  int pensiveMappedValue;
  pensiveMappedValue = map(pensiveSensorValue, 966, 839, 0, 255);   // (Touch, No Touch) A mapped value less than 2 will prompt message
  Serial.print("pensive raw value = ");
  Serial.print(pensiveSensorValue);
  Serial.print(" mapped value = ");
  Serial.println(pensiveMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor

  // Read the boredSensor force sensor
  int boredSensorValue = analogRead(boredSensor);                   //Displayed between 3 (touch) and 3 (no touch) BUT NOT WORKING PROPERLY
  //Map the value:
  int boredMappedValue;
  boredMappedValue = map(boredSensorValue, 350, 964, 0, 255);
  Serial.print("bored raw value = ");
  Serial.print(boredSensorValue);
  Serial.print(" mapped value = ");
  Serial.println(boredMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor

  // Read the confusedSensor force sensor
  int confusedSensorValue = analogRead(confusedSensor);              //Displayed between 945 (touch) and 0 (no touch)
  //Map the value:
  int confusedMappedValue;
  confusedMappedValue = map(confusedSensorValue, 945, 0, 0, 255);
  Serial.print("confused raw value = ");
  Serial.print(confusedSensorValue);
  Serial.print(" mapped value = ");
  Serial.println(confusedMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor

  // Read the lonelySensor force sensor
  int lonelySensorValue = analogRead(lonelySensor);                   //Displayed between 932 (touch) and 0 (no touch)
  //Map the value:
  int lonelyMappedValue;
  lonelyMappedValue = map(lonelySensorValue, 932, 0, 0, 255);
  Serial.print("lonely raw value = ");
  Serial.print(lonelySensorValue);
  Serial.print(" mapped value = ");
  Serial.println(lonelyMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor

  // Read the overwhelmedSensor force sensor
  int overwhelmedSensorValue = analogRead(overwhelmedSensor);          //Displayed between 902 (touch) and 0 (no touch)
  //Map the value:
  int overwhelmedMappedValue;
  overwhelmedMappedValue = map(overwhelmedSensorValue, 902, 0, 0, 255);
  Serial.print("overwhelmed raw value = ");
  Serial.print(overwhelmedSensorValue);
  Serial.print(" mapped value = ");
  Serial.println(overwhelmedMappedValue);
  //delay(5000);                                                    //Commented out to save time, use when reading Serial Monitor


  // Print first message "How are you on a scale of 1-10?" on LCD
  if (anxiousMappedValue >= 2 && pensiveMappedValue >= 2 /* && boredMappedValue >= 2 */         // Commented out because bored sensor isn't working
      && confusedMappedValue >= 2 && lonelyMappedValue >= 2 && overwhelmedMappedValue >= 2) {

    // Set up the LCD's number of columns and rows:
    lcd.begin(20, 2);
    // Print a message to the LCD.
    lcd.print("How are you on ");
    // Set the cursor to column 0, line 1
    // (note: line 1 is the second row, since counting begins with 0):
    lcd.setCursor(0, 1);
    //Print a message to second line of LCD
    lcd.print("a scale of 1-10?");

  } // Print anxious response message and play sound
  else if (anxiousMappedValue <= 2) {
    // Set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.print("Breathe. It will");
    // Set the cursor to column 0, line 1
    // (note: line 1 is the second row, since counting begins with 0):
    lcd.setCursor(0, 1);
    // Print a message to second line of LCD
    lcd.print("be fine.");

    // Iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 3; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speaker, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(speaker);
    }

  } // Print pensive response message and play sound
  else if (pensiveMappedValue <= 2) {
    // Set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.print("I think,");
    // Set the cursor to column 0, line 1
    // (note: line 1 is the second row, since counting begins with 0):
    lcd.setCursor(0, 1);
    // Print a message to second line of LCD
    lcd.print("therefore I am.");

    // Iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 3; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speaker, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(speaker);
    }

    /*} // Print bored response message and play sound                    // Commented out because the bored sensor does not seem to be working
      else if (boredMappedValue <= 2) {                                     // It only reads at around raw value of 3, regardless of touch
      // Set up the LCD's number of columns and rows:
      lcd.begin(16, 2);
      // Print a message to the LCD.
      lcd.print("Google dad jokes");

      // Iterate over the notes of the melody:
      for (int thisNote = 0; thisNote < 3; thisNote++) {

        // to calculate the note duration, take one second divided by the note type.
        //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
        int noteDuration = 1000 / noteDurations[thisNote];
        tone(speaker, melody[thisNote], noteDuration);

        // to distinguish the notes, set a minimum time between them.
        // the note's duration + 30% seems to work well:
        int pauseBetweenNotes = noteDuration * 1.30;
        delay(pauseBetweenNotes);
        // stop the tone playing:
        noTone(speaker);
      } */

  } // Print confused response message and play sound
  else if (confusedMappedValue <= 2) {
    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.print("Give it time.");

    // Iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 3; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speaker, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(speaker);
    }
  } // Print lonely response message and play sound
  else if (lonelyMappedValue <= 2) {
    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.print("You are loved.");

    // Iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 3; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speaker, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(speaker);
    }
  }  // Print overwhelmed response message and play sound
  else if (overwhelmedMappedValue <= 2) {
    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.print("You've got this!");

    // Iterate over the notes of the melody:
    for (int thisNote = 0; thisNote < 3; thisNote++) {

      // to calculate the note duration, take one second divided by the note type.
      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speaker, melody[thisNote], noteDuration);

      // to distinguish the notes, set a minimum time between them.
      // the note's duration + 30% seems to work well:
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      // stop the tone playing:
      noTone(speaker);
    }

  }

}
