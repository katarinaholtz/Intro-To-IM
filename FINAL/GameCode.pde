/*
 COVID-19 Disinfection by Katarina Holtzapple
 based off of https://github.com/michaelshiloh/simpleProcessingClassExamplef
 */

// Set variables:
int CovidSize = 15;         // Covid size
int mouseRadius = 15;      // The distance from the cursor that moves Covids
int mousePush = 3;         // How far a Covid will move if within mouseRadius
final int CovidNumber = 20; // Number of Covids
int purple = #9370DB;      // Box color
int white = 250;           // Covid color
int black = 0;             // Background color
int yellow = #FFFACD;      // Text color

PImage sanitizer;           //Sets image
import processing.sound.*;
SoundFile dingdong;



// Start of Covid class
class Covid {
  float x, y;                       // Declare properties of objects of this type

  Covid(float xpos, float ypos) {    // Constructor
    x = xpos;
    y = ypos;
  }

  // The checkMouse() function causes the Covids to respond to the mouse
  void checkMouse() {                                  
    if ((x < (mouseX+mouseRadius)) && (x > (mouseX-mouseRadius))
      && (y < (mouseY+mouseRadius)) && (y > (mouseY-mouseRadius) ) ) {    // Checks if Covid is within radius
      if ((x < mouseX+mouseRadius) && (x > mouseX)) {      //Covid to the right of the cursor
        x += mousePush;                                        //Covid will move to the right
      } 
      if ((x > mouseX-mouseRadius) && (x < mouseX)) {      //Covid to the left of the cursor
        x -= mousePush;                                        //Covid will move to the left
      } 
      if ((y < mouseX+mouseRadius) && (y > mouseY)) {     //Covid is on top of the cursor
        y += mousePush;                                        //Covid will move up
      } 
      if ((y > mouseY-mouseRadius) && (y < mouseY)) {     //Covid is underneath the cursor
        y -= mousePush;                                        //Covid will move down
      }
    }
  }

  // This function draws the Covid
  void drawCovid() {
    fill(white);
    noStroke();
    ellipse(x, y, CovidSize, CovidSize);
    checkCovid();
  }

  // This function checks if Covid is in box and turns it purple
  void checkCovid() {
    if ( (x > ((width/2) - ((width/4)/2))) && (x < ((width/2) + ((width/4)/2))) && (y > ((height/2) - ((width/4)/2))) && (y < ((height/2) + ((width/4)/2))) ) {
      fill(purple);
      noStroke();
      ellipse(x, y, CovidSize, CovidSize);
      fill(yellow);
      text("yay", x, y);
      
      dingdong.play();
    }
  }
}// End of the Covid class


// Creates an empty array for a bunch of objects of type Covid:
Covid[] myCircleArray = new Covid[CovidNumber];


void setup() {
  fill(purple);
  rect(0, 0, width/5, height);
  size(800, 600);
  background(black);
  dingdong = new SoundFile(this, "doorbell.mp3");
  for (int i=0; i < myCircleArray.length; i++) {        // Create the objects and populate the array with them
    myCircleArray[i] = new Covid(random(CovidSize+(width/5), width-CovidSize), 
      random((height/15)+CovidSize, height-CovidSize));   // So Covid won't appear at edges or over text
  }


  sanitizer = loadImage("HandSanitizer.png");    //Calls image from sketchbook
}

void draw() {
  background(black);
  // Write instructions at top of screen
  String s = "Try to push all the Covids into the box";
  fill(white);
  textAlign(CENTER);
  textSize(height/30);
  text(s, (width/2), (height/15));  

  // Creates hand sanitizer for Covids
  imageMode(CENTER); 
  image(sanitizer, width/2, height/2, 168, 174);

  fill(purple);
  rect(0, 0, width/5, height);

  // Iterate through every moving circle
  for (int i=0; i < myCircleArray.length; i++) {
    myCircleArray[i].checkMouse();
    myCircleArray[i].drawCovid();
    myCircleArray[i].checkCovid();
  }
}
