import processing.sound.*;

int black = 0;
int red = #FF0000;
PImage SANITIZER;
PFont bayan;
Person[] persons;

import processing.sound.*;
SoundFile winSong;
SoundFile loseSong; 

// Start of Person class:
class Person {
  float x, y, vx, vy;         // Declaring properties of x and y position and velocity on both axes 

  int personSize = 12;
  int white = 250; 
  int fillColor;
  int iter;
  double type;

  Person(float xPosition, float yPosition, float xVelocity, float yVelocity, double typeSick, int iterationNumber) {       // Constructor
    x = xPosition;
    y = yPosition;
    vx = xVelocity;
    vy = yVelocity;
    type = typeSick;  
    iter = iterationNumber;
    System.out.println(typeSick);
  }

  // This function draws the person ball
  void drawPerson() {
    if (type == 1) {
      fillColor = white;
    } else if (type == 2) {
      fillColor = red;
    } 
    fill(fillColor);
    noStroke();
    ellipse(x, y, personSize, personSize);
  }

  void updatePerson() {  // Update position with velocity
    x += vx;
    y += vy;

    // Check for collision on x axis
    if (x <= 0 || x >= width) {
      vx = -vx;
    }
    // Check for collision on y axis
    if (y <= 0 || y >= height) {
      vy = -vy;
    }
  }

  void checkCollision(Person[] persons) {
    for (Person r : persons) {
      if (r.iter != iter) {
        if (dist(x, y, r.x, r.y) < (personSize*2)
          && (r.type != type)) {
          type = 2;
          r.type = 2;
        }
      }
    }
    for (Person r : persons) {
      if (r.iter != iter) {
        if (dist(x, y, r.x, r.y) < (personSize)) {
          vx = -vx;
          vy = -vy;
        }
      }
    }
  }

  void checkMouse() {
    if (dist(mouseX, mouseY, x, y) < 20 && mouseX != pmouseX && mouseY != pmouseY) {
      type = 1;
    }
  }
}// End of Person class  

void setup() {
  size(800, 800);
  background(black);
  bayan = loadFont("AlBayan-Bold-48.vlw");
  
  
  
  winSong = new SoundFile(this, "hope.wav");
  loseSong = new SoundFile(this, "gameover.wav");

  // Create the objects and populate the array with them
  persons = new Person[20];
  for (int i=0; i < persons.length; i++) {      
    persons[i] = new Person(random(0, width), random(0, height), random(1, 3), random(1, 3), round(random(1, 2)), i);  //originally Math.floor(random(1,3)), i);
  }

  SANITIZER = loadImage("HandSanitizer.png");    //Calls image from sketchbook
} // End of setup

void draw() {
  background(black); 
  cursor(SANITIZER);
  // Iterate through every myPersonArray
  for (int i=0; i < persons.length; i++) {
    persons[i].drawPerson();
    persons[i].updatePerson();
    persons[i].checkCollision(persons);
    persons[i].checkMouse();
  }
  checkInfected(persons);
  checkCured(persons);
} // End of draw


void checkCured(Person[] persons) {
  for (Person r : persons) {
    if (r.type == 2) {
      return;
    }
  } 
  background(black);
  textAlign(CENTER);
  //winSong.play();
  textFont(bayan); 
  text("GAME OVER:", width/2, (height/2)-45);
  text("YOU DEFEATED COVID", width/2, height/2); 
  textFont(bayan, 16);
  text("Click to restart", width/2, (height/2) + 20);
  if (mousePressed) {
    setup();
  }
}

void checkInfected(Person[] persons) {
  for (Person r : persons) {
    if (r.type == 1) {
      return;
    }
  } 
  background(black);
  textAlign(CENTER);
  loseSong.play();
  textFont(bayan);
  text("GAME OVER:", width/2, (height/2)-45);
  text("COVID DEFEATED YOU", width/2, height/2); 
  textFont(bayan, 16);
  text("Click to restart", width/2, (height/2) + 25);
  if (mousePressed) {
    setup();
  }
}
