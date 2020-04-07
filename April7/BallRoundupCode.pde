/*
 Ball Roundup by Katarina Holtzapple
 based off of https://github.com/michaelshiloh/simpleProcessingClassExample
 */

// Set variables:
int ballSize = 15;         // Ball size
int mouseRadius = 15;      // The distance from the cursor that moves balls
int mousePush = 3;         // How far a ball will move if within mouseRadius
final int ballNumber = 20; // Number of balls
int purple = #9370DB;      // Box color
int white = 250;           // Ball color
int black = 0;             // Background color
int yellow = #FFFACD;      // Text color



// Start of Ball class
class Ball {
  float x, y;                       // Declare properties of objects of this type

  Ball(float xpos, float ypos) {    // Constructor
    x = xpos;
    y = ypos;
  }

  // The checkMouse() function causes the balls to respond to the mouse
  void checkMouse() {                                  
    if ((x < (mouseX+mouseRadius)) && (x > (mouseX-mouseRadius))
      && (y < (mouseY+mouseRadius)) && (y > (mouseY-mouseRadius) ) ) {    // Checks if ball is within radius
      if ((x < mouseX+mouseRadius) && (x > mouseX)) {      //Ball to the right of the cursor
        x += mousePush;                                        //Ball will move to the right
      } 
      if ((x > mouseX-mouseRadius) && (x < mouseX)) {      //Ball to the left of the cursor
        x -= mousePush;                                        //Ball will move to the left
      } 
      if ((y < mouseX+mouseRadius) && (y > mouseY)) {     //Ball is on top of the cursor
        y += mousePush;                                        //Ball will move up
      } 
      if ((y > mouseY-mouseRadius) && (y < mouseY)) {     //Ball is underneath the cursor
        y -= mousePush;                                        //Ball will move down
      }
    }
  }

  // This function draws the ball
  void drawBall() {
    fill(white);
    noStroke();
    ellipse(x, y, ballSize, ballSize);
    checkBall();
  }

  // This function checks if ball is in box and turns it purple
  void checkBall() {
    if ( (x > ((width/2) - ((width/4)/2))) && (x < ((width/2) + ((width/4)/2))) && (y > ((height/2) - ((width/4)/2))) && (y < ((height/2) + ((width/4)/2))) ) {
      fill(purple);
      noStroke();
      ellipse(x, y, ballSize, ballSize);
      fill(yellow);
      text("yay", x, y);
    }
  }
}// End of the Ball class


// Creates an empty array for a bunch of objects of type Ball:
Ball[] myCircleArray = new Ball[ballNumber];


void setup() {
  size(500, 500);
  background(black);
  for (int i=0; i < myCircleArray.length; i++) {        // Create the objects and populate the array with them
    myCircleArray[i] = new Ball( random(ballSize, width-ballSize), 
      random((height/15)+ballSize, height-ballSize));   // So ball won't appear at edges or over text
  }
}

void draw() {
  background(black);
  // Write instructions at top of screen
  String s = "Try to push all the balls into the box";
  fill(white);
  textAlign(CENTER);
  textSize(height/30);
  text(s, (width/2), (height/15));  

  // Creates box for balls
  fill(purple);
  rectMode(CENTER);
  rect((width/2), (height/2), width/4, height/4);


  // Iterate through every moving circle
  for (int i=0; i < myCircleArray.length; i++) {
    myCircleArray[i].checkMouse();
    myCircleArray[i].drawBall();
    myCircleArray[i].checkBall();
  }
}
