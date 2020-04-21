/*
Messing with Aaron Sherwood's example
 April 20, 2020
 */

Rotator [] rotators;

void setup() {
  size(640, 360);
  stroke(random(250), random(250), random(250));    //set lines to a random color
  rotators = new Rotator[200];                      //make an array of rotators
  for (int i=0; i< rotators.length; i++) {
    float x = random(width);
    float y = random(height);
    float lineDistance = random(20, 100);
    rotators[i] = new Rotator(x, y, i, lineDistance);
  }
}

void draw() {           
  background(0, 30, 50);            //set background color
  for (Rotator r : rotators) {      //call class, call functions for all the rotators
    r.rotateLine();                
    r.checkMouse();                 //function that checks the cursor/mouse position
    r.drawLine(rotators);           //function that draws the line
    r.mousePressed();               //function that speeds up if mouse is pressed
  }
}

//Start of Rotator class:
class Rotator {
  // Declare properties of objects of this type
  float x, y, centerX, centerY, angle, acceleration, velocity, radius, direction, lineDistance;
  int index;

  Rotator(float _x, float _y, int i, float lineLength) {    // Constructor
    centerX = _x;
    centerY = _y;
    angle = acceleration = velocity = 0;
    radius = random(10, 80);
    x = y = angle = 0;
    index = i;
    float coinflip = random(1);
    if (coinflip > .5) {
      direction = 1;
    } else {
      direction = -1;
    }
  }

//This function sets how fast and how the lines will move
  void rotateLine() {
    velocity += acceleration;
    velocity *= direction;
    angle += velocity;          //our position now is our angle, so this is what we're changing
    acceleration = 0;
    velocity *= .98;
  }

//This function draws the lines 
  void drawLine(Rotator[] rotators) {
    //in order to get them to rotate around the center
    x = cos(angle)*radius + centerX;
    y = sin(angle)*radius + centerY;
    for (Rotator r : rotators) {
      if (index != r.index) {
        if (dist(x, y, r.x, r.y) < radius) {
          line(r.x, r.y, x, y);
        }
      }
    }
  }

//checks mouse position
  void checkMouse() {
    if (dist(mouseX, mouseY, x, y) < radius
      && mouseX != pmouseX
      && mouseY != pmouseY) {
      acceleration += .002;    //sets speed
    }
  }

//function that checks mouse position and makes it move at .1 speed
// and change color if mouse pressed
  void mousePressed() {
    if ((mousePressed == true) 
      && (dist(mouseX, mouseY, x, y) < radius/2
      && mouseX != pmouseX  && mouseY != pmouseY)) {
      acceleration += .1;
      stroke(random(255), random(255), random(255));
    }
  }
}
