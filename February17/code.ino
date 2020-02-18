/* Based on the built-in example analogReadSerial
  and class example by Michael Shiloh on 13 February 2020

  GOAL: Turn on all the lights
  Start
*/

const int redButton = 13;
const int greenButton = 12;
const int blueButton = 11;
const int lightSensor = A0;
const int potentiometer = A1;
const int redLED = 3;
const int yellowLED = 5;
const int greenLED = 6;
const int blueLED = 9;

void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  // Set the inputs and outputs
  pinMode(lightSensor, INPUT);  // pin A0 is one of the analogRead capable pins
  pinMode(redButton, INPUT); // pin 13
  pinMode(greenButton, INPUT); // pin 12
  pinMode(blueButton, INPUT); // pin 11
  pinMode(potentiometer, INPUT); // pin A1
  pinMode(redLED, OUTPUT);  // one of the analogWrite (PWM) capable pins
  pinMode(yellowLED, OUTPUT);  // one of the analogWrite (PWM) capable pins
  pinMode(greenLED, OUTPUT);  // one of the analogWrite (PWM) capable pins
  pinMode(blueLED, OUTPUT);  // one of the analogWrite (PWM) capable pins
}

void loop() {

  // read the light
  int sensorValue = analogRead(lightSensor); // 0-1023 as it uses 10 bits

  // smallest number in class was 50
  // biggest number in class was 1006

  // Here we map the value from the sensor to the allowable range of analogWrite(), which is only 0 to 255.

  int mappedValue;
  mappedValue = map(sensorValue, 400, 1020, 0, 255);
  Serial.print("raw value = ");
  Serial.print(sensorValue);
  Serial.print(" mapped value = ");
  Serial.println(mappedValue);

  if (mappedValue >= 200) {
    analogWrite(blueLED, 255); // light sensor turns on Blue LED
    analogWrite(redLED, 255); // light sensor turns on Red LED
  }



  // Read the input pin:
  int redButtonState = digitalRead(redButton);
  int greenButtonState = digitalRead(greenButton);
  int blueButtonState = digitalRead(blueButton);

  // Green button is pressed:
  if (greenButtonState == 1) {
    digitalWrite(redLED, !greenButtonState);
    digitalWrite(yellowLED, !greenButtonState);
    digitalWrite(greenLED, !greenButtonState);
    digitalWrite(blueLED, !greenButtonState);
  }

  // Both are pressed:
  else if (redButtonState == 1 && blueButtonState == 1) {
    digitalWrite(redLED, 1);
    digitalWrite(yellowLED, 1);
    digitalWrite(blueLED, 1);
  }

  // No button is pressed:
  else {
    digitalWrite(redLED, LOW);
    digitalWrite(yellowLED, LOW);
    digitalWrite(greenLED, LOW);
    digitalWrite(blueLED, LOW);
  }

  // Potentiometer to turn on Green LED
  // read the input on analog pin 3:
  int potentiometerValue = analogRead(potentiometer); // 0-1023 as it uses 10 bits

  int mappedPotentiometerValue;
  mappedPotentiometerValue = map(potentiometerValue, 800, 1023, 0, 255);
  mappedPotentiometerValue = constrain(mappedPotentiometerValue, 0, 255);

  Serial.print("potentiometer value = ");
  Serial.print(potentiometerValue);
  Serial.print(" potentiometer mapped value = ");
  Serial.println(mappedPotentiometerValue);

  analogWrite(greenLED, mappedPotentiometerValue);


}
