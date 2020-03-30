//setting variables
int size = 500;    //sets the size of sheet variable for later use
float x = 0;       //sets the x position of the square
float y = 0;       //sets the y positions of the square
float a = size/5;  //sets the width of the square to 1/5 the window size
float b = size/5;  //sets the height of the square to 1/5 the window size
float iterations = random(10)+2;   //randomly sets the number of square iterations that will appear between 2-11
float offset = ((size/10) / iterations) - 0.5;   //sets the offset between nested squares 
float newPositionX = random(5)-2;    //randomly sets how far the nested square starting position X will move
float newPositionY = random(5)-2;    //randomly sets how far the nested square starting position Y will move
float colorR = random(256);          //sets the R color value; RGB values go from 0 to 255
float colorG = random(256);          //sets the G color value
float colorB = random(256);          //sets the B color value



void setup() {
  size(500, 500);  //sets the size of the window
  //draws the nested squares once in set-up
  for (int z = 0; z < 5; z++) {     //repeats rows 
    for (int n = 0; n < 5; n++) {   //repeats square across row
      for (int i = 0; i < iterations; i++) {  //creates individual nested squares
        stroke(colorR, colorG, colorB);       //color of the lines
        rect(x, y, a, b, 5);                  //draws the square, the 5 is to have rounded corners
        x += offset;                          //moves starting x position in order to nest
        x += newPositionX;                    //adds to nested x position position in order to off-center the nesting
        y += offset;                          //moves starting y position in order to nest
        y += newPositionY;                    //adds to nested y position position in order to off-center the nesting
        a -= (offset*2);                      //shortens the width line of square by 2x the offset so the line does not reach the previous square
        b -= (offset*2);                     //shortens the height line of square by 2x the offset so the line does not reach the previous square
        //if desired, to create gradient within the nested squares:
        colorR -= (offset*4);                  
        colorG -= (offset*4);
        colorB -= (offset*4);
      }

      //resets all variables in order to translate
      x = 0;
      y = 0;
      a = (size/5);
      b = (size/5);
      iterations = random(10)+2; 
      offset = ((size/10) / iterations) - 1;
      newPositionX = random(5)-2;
      newPositionY = random(5)-2;
      colorR = random(256);         
      colorG = random(256);
      colorB = random(256);

      translate((size/5), 0);        //translates or repeats the nested squares across the row
    } 
    translate((-1*size), (size/5));  //translates or repeats the nested square rows down to the end of the window
  }
}

//redraw the whole image when mouse is clicked
void mouseClicked() {
  for (int z = 0; z < 5; z++) {     //repeats rows 
    for (int n = 0; n < 5; n++) {   //repeats square across row
      for (int i = 0; i < iterations; i++) {  //creates individual nested squares
        stroke(colorR, colorG, colorB);       //color of the lines
        rect(x, y, a, b, 5);                  //draws the square, the 5 is to have rounded corners
        x += offset;                          //moves starting x position in order to nest
        x += newPositionX;                    //adds to nested x position position in order to off-center the nesting
        y += offset;                          //moves starting y position in order to nest
        y += newPositionY;                    //adds to nested y position position in order to off-center the nesting
        a -= (offset*2);                      //shortens the width line of square by 2x the offset so the line does not reach the previous square
        b -= (offset*2);                     //shortens the height line of square by 2x the offset so the line does not reach the previous square
        //if desired, to create gradient within the nested squares:
        colorR -= (offset*4);                  
        colorG -= (offset*4);
        colorB -= (offset*4);
      }

      //resets all variables in order to translate
      x = 0;
      y = 0;
      a = (size/5);
      b = (size/5);
      iterations = random(10)+2; 
      offset = ((size/10) / iterations) - 1;
      newPositionX = random(5)-2;
      newPositionY = random(5)-2;
      colorR = random(256);         
      colorG = random(256);
      colorB = random(256);

      translate((size/5), 0);        //translates or repeats the nested squares across the row
    } 
    translate((-1*size), (size/5));  //translates or repeats the nested square rows down to the end of the window
  }
}
void draw() {
}
