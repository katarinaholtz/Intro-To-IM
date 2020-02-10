// Naming the pins:
int yellowButton = 2;
int blueButton = 3;
int yellowLED = 13;
int blueLED = 12;
int greenLED = 11;

// The setup routine runs once when you press reset:
void setup() {

  // Initializing serial communication at 9600 bits per second:
  Serial.begin(9600);

  // Making the button pins inputs and LEDs an output:
  pinMode(yellowButton, INPUT);
  pinMode(blueButton, INPUT);
  
  pinMode(yellowLED, OUTPUT);
  pinMode(blueLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
}


// The loop routine runs over and over again forever:
void loop() {

  // Read the input pin:
  int yellowButtonState = digitalRead(yellowButton);
  int blueButtonState = digitalRead(blueButton);

    // Both buttons are pressed:
    if (yellowButtonState == 1 && blueButtonState == 1) {
      digitalWrite(greenLED, 1);
      digitalWrite(yellowLED, 0);
      digitalWrite(blueLED, 0);
    }

    // Yellow button is pressed:
    else if (yellowButtonState == 1) { 
      digitalWrite(yellowLED, yellowButtonState);
      digitalWrite(greenLED, !yellowButtonState);
      digitalWrite(blueLED, !yellowButtonState);
    } 

    // Blue button is pressed:
    else if (blueButtonState == 1) {
      digitalWrite(blueLED, blueButtonState);
      digitalWrite(greenLED, !blueButtonState);
      digitalWrite(yellowLED, !blueButtonState);
    } 

    // No button is pressed:
    else {
      digitalWrite(yellowLED, LOW);
      digitalWrite(blueLED, LOW);
      digitalWrite(greenLED, LOW);
    }
}
