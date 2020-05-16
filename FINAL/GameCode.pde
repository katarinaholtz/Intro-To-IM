/* 
 COVID DISINFECTION GAME
 by Katarina Holtzapple
 Intro to IM Final
 
 List of references can be found at: github.com/katarinaholtz/Intro-To-IM/master/FINAL
 
 INSTRUCTIONS
 Move your mouse (Purell) over the infected red balls to heal them all.
 
 CODE ORDER:
 1) Universal variables, imports
 2) Setup function
 3) Draw function
 4) Class Ball
 5) playGame function setup
 */

//Universal variables 
int black = 0;              //Background color
int white = 250;            //Ball and text color
int red = #FF0000;          //Ball and text color
PImage SANITIZER;           //Cursor image
boolean titleScreen = true; //To use in instructions screen
PFont bayan;                //Game font

//Import sound library and songs for end screens
import processing.sound.*;
SoundFile winSong;
SoundFile loseSong;

//Creates an empty ball array:
Ball[] balls;

//Start of setup:
void setup() {
  size(800, 800);
  background(black);
  bayan = loadFont("AlBayan-Bold-48.vlw");

  //Load music from data folder in sketchbook
  winSong = new SoundFile(this, "hope.wav");
  loseSong = new SoundFile(this, "gameover.wav");

  // Create the objects and populate the array with them
  balls = new Ball[20];
  for (int i=0; i < balls.length; i++) {      
    balls[i] = new Ball(random(0, width), random(0, height), random(1, 3), random(1, 3), round(random(1, 2)), i);  //originally Math.floor(random(1,3)), i);
  }

  SANITIZER = loadImage("HandSanitizer.png");    //Calls image from sketchbook
} //End of setup

//Start of draw
void draw() {
  cursor(SANITIZER);          //Makes the Purell image the cursor
  if (titleScreen) {          //Calls instructions screen
    background(0);
    textAlign(CENTER);
    textFont(bayan); 
    text("COVID DISINFECTION GAME", width/2, (height/2)-100);
    textFont(bayan, 20);
    text("Heal the infected red balls by" + "\n" + "passing the Purell over them.", width/2, (height/2) - 45); 
    textFont(bayan, 16);
    text("Click to begin game", width/2, (height/2) + 25);
    if (mousePressed) {       //If mouse is pressed, the variable returns false, and moves on to play the game
      titleScreen = false;
    } 
    return;
  }
  playGame();
} //End of draw

// Start of Ball class:
class Ball {
  float x, y, vx, vy;         //Declaring properties of x and y position and velocity on both axes 

  int ballSize = 12;          //Ball width and height
  int fillColor;              //Used for filling balls
  int iter;                   //Used to iterate through the array
  double type;                //Used to set ball to either infected or healthy

  //Constructor
  Ball(float xPosition, float yPosition, float xVelocity, float yVelocity, double typeSick, int iterationNumber) {       // Constructor
    x = xPosition;
    y = yPosition;
    vx = xVelocity;
    vy = yVelocity;
    type = typeSick;  
    iter = iterationNumber;
  }

  //This function draws the ball
  void drawBall() {
    if (type == 1) {          //Randomly assigned between 1 and 2
      fillColor = white;      //Healthy
    } else if (type == 2) {
      fillColor = red;       //Infected
    } 
    fill(fillColor);         //Based on type and color assigned to the type
    noStroke();
    ellipse(x, y, ballSize, ballSize);
  }

  //This function updates the position (movement) and checks for wall collisions
  void updateBall() {  // Update position with velocity
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

  //This function checks for balls colliding with other balls
  void checkCollision(Ball[] balls) {              //Iterate through the array
    for (Ball r : balls) {                         //and compare r.ball to all other balls.
      if (r.iter != iter) {                        //If balls are different balls.
        if (dist(x, y, r.x, r.y) < (ballSize*2)    //If balls are within 2 times the ball size 
          && (r.type != type)) {                   //and the types are different.
          type = 2;                                //Then set the type of both to 2 (red).
          r.type = 2;
        }
      }
    }
    for (Ball r : balls) {                         //Compare r.ball to all other balls.
      if (r.iter != iter) {                        //If balls are different balls
        if (dist(x, y, r.x, r.y) < (ballSize*2)) { //If balls are within 2 times the ball size 
          vx = -vx;                                //Change velocity/movement to opposite
          vy = -vy;
        }
      }
    }
  }

  //This function checks if the cursor is within a certain distance of ball
  void checkMouse() {
    if (dist(mouseX, mouseY, x, y) < (ballSize*2) && mouseX != pmouseX && mouseY != pmouseY) {
      type = 1;          //If within 2 times the ball size, change ball to type 1 (white)
    }
  }
}// End of Ball class  

//This function plays the game and calls all relevant functions:
void playGame() {
  background(0); 
  
  // Iterate through every myBallArray
  for (int i=0; i < balls.length; i++) {
    balls[i].drawBall();
    balls[i].updateBall();
    balls[i].checkCollision(balls);
    balls[i].checkMouse();
  }
  checkInfected(balls);
  checkCured(balls);
} 

//This function calls the YOU WON screen
void checkCured(Ball[] balls) {    
  for (Ball r : balls) {          //Iterate through array
    if (r.type == 2) {            //If there is a type 2 (infected, red) ball,
      return;                     //continue playing.
    }
  } 
  background(black);              //ELSE: Pull up "You Defeated COVID" screen
  if (!winSong.isPlaying()) {     //Plays winning jingle if song not playing yet
    winSong.play();
  }
  textAlign(CENTER);
  textFont(bayan); 
  text("GAME OVER:", width/2, (height/2)-45);
  text("YOU DEFEATED COVID", width/2, height/2); 
  textFont(bayan, 16);
  text("Click to restart", width/2, (height/2) + 25);
  if (mousePressed) {             //If player presses mouse, song stops and game restartss
    winSong.stop();
    setup();
  }
}

//This function calls the YOU LOST screen
void checkInfected(Ball[] balls) {
  for (Ball r : balls) {          //Iterate through array
    if (r.type == 1) {            //If there is a type 1 (healthy, white) ball,
      return;                     //continue playing.
    }
  } 
  background(black);              //ELSE: Pull up "COVID Defeated You" screen
  if (!loseSong.isPlaying()) {    //Plays losing jingle if song not playing yet
    loseSong.play();
  }
  textAlign(CENTER);
  textFont(bayan);
  text("GAME OVER:", width/2, (height/2)-45);
  text("COVID DEFEATED YOU", width/2, height/2); 
  textFont(bayan, 16);
  text("Click to restart", width/2, (height/2) + 25);
  if (mousePressed) {             //If player presses mouse, song stops and game restarts
    loseSong.stop();
    setup();
  }
} //End of playGame function
