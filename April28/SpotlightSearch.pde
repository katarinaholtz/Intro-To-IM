/* 
 
 Find Them! A spotlight search game
 by Katarina Holtzapple
 Intro to IM, Spring 2020
 
 Inspired by: https://www.youtube.com/watch?v=j-ZLDEnhT3Q
 Photo citations can be found at: https://github.com/katarinaholtz/Intro-To-IM/April28/README.md
 
 */

//Sets universal variables
PImage theatre;              //Sets imagee
//int theatreWidth = 600;    //Could be used for drawing rectangle, also useful as reference
//int theatreHeight = 400;
int white = (255);           //Text color
int violet = (#57068c);      //Rect color
int textX = 620;             //Sets a baseline for text alignment
int textY = 100;

//Sets position for Mariet Westermann
int marietX = 0;          //Left-most point
int marietY = 340;        //Top-most point
int marietWidth = 52;     //Approx. width
int marietHeight = 60;    //Approx. height

//Sets position for John Sexton
int johnX = 130;          //Left-most point
int johnY = 100;          //Top-most point
int johnWidth = 20;       //Approx. width
int johnHeight = 30;      //Approx. height

//Sets position for Michael Shiloh
int michaelX = 390;       //Left-most point
int michaelY = 325;       //Top-most point
int michaelWidth = 40;    //Approx. width
int michaelHeight = 65;   //Approx. height

//Sets position for Dan Shiffman
int danX = 315;          //Left-most point
int danY = 240;          //Top-most point
int danWidth = 30;       //Approx. width
int danHeight = 40;      //Approx. height


void setup() {
  size(800, 400);                        //Sets canvas to same dimension as image
  theatre = loadImage("Theatre.png");    //Calls image from sketchbook

  //Creates rectangle on the left quarter of image withinstructions
  fill(violet);
  rect(width-(width/4), 0, width/4, height);
  fill(white);
  text("Find the following people:", textX, textY);    //Each line is 20px further down
  text("Michael Shiloh", textX + 20, textY + 20);      //Names are textX+20 to indent
  text("John Sexton", textX + 20, textY + 40);
  text("Mariet Westermann", textX + 20, textY + 60);
  text("Dan Shiffman", textX + 20, textY + 80);
}

//Draws pixels with spotlight
void draw() {
  loadPixels();
  theatre.loadPixels();      //Calls pixels from image to draw image
  //For loop for thee spotlight feature
  for (int x = 0; x < (width-(width/4)); x++) {    //Runs through image, not the rectangle
    for (int y = 0; y < height; y++) {
      int loc = x+y*width;
      float r = red(theatre.pixels[loc]);
      float g = green(theatre.pixels[loc]);
      float b = blue(theatre.pixels[loc]);
      float d = dist(mouseX, mouseY, x, y);        //Finds distance from cursor to mousespotlig
      float factor = map(d, 0, 100, 1.5, 0);       //Sets the radius
      pixels[loc] = color(r*factor, g*factor, b*factor);
    }
  }
  updatePixels();
}

void mousePressed() {
  //If mouse pressed over Mariet Westermann location
  if (mouseX > marietX && mouseX < (marietX + marietWidth)         //Width of Mariet
    && mouseY > marietY  && mouseY  < (marietY + marietHeight)) {  //Height of Mariet
    //Draws a white line through the name
    stroke(white);
    line(638, 155, 755, 155);
  }
  //If mouse pressed over John Sexton location
  if (mouseX > johnX && mouseX < (johnX + johnWidth)           //Width of John
    && mouseY > johnY  && mouseY  < (johnY + johnHeight)) {    //Height of John 
    //Draws a white line through the name
    stroke(white);
    line(638, 135, 710, 135);
  }
  //If mouse pressed over Michael Shiloh location
  if (mouseX > michaelX && mouseX < (michaelX + michaelWidth)         //Width of Michael
    && mouseY > michaelY  && mouseY  < (michaelY + michaelHeight)) {  //Height of Michael
    //Draws a white line through the name
    stroke(white);
    line(638, 115, 725, 115);
  }

  //If mouse pressed over Dan Shiffman location
  if (mouseX > danX && mouseX < (danX + danWidth)        //Width of Dan
    && mouseY > danY  && mouseY  < (danY + danHeight)) { //Height of Dan
    //Draws a white line through the name
    stroke(white);                                       
    line(638, 175, 720, 175);
  }
}
