Rotator [] rotators;

void setup() {
  size(640, 360);
  stroke(random(250), random(250), random(250));
  rotators = new Rotator[200];
  for (int i=0; i< rotators.length; i++) {
    float x = random(width);
    float y = random(height);
    float lineDistance = random(20, 100);
    rotators[i] = new Rotator(x, y, i, lineDistance);
  }
}

void draw() {
  background(0, 30, 50);
  for (Rotator r : rotators) {
    r.rotateLine();
    r.checkMouse();
    r.drawLine(rotators);
    r.mousePressed();
  }
}

class Rotator {
  float x, y, centerX, centerY, angle, acceleration, velocity, radius, direction, lineDistance;
  int index;

  Rotator(float _x, float _y, int i, float lineLength) {
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

  void rotateLine() {
    velocity += acceleration;
    velocity *= direction;
    angle += velocity;          //our position now is our angle, so this is what we're changing
    acceleration = 0;
    velocity *= .98;
  }

  void drawLine(Rotator[] rotators) {
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


  void checkMouse() {
    if (dist(mouseX, mouseY, x, y) < radius
      && mouseX != pmouseX
      && mouseY != pmouseY) {
      acceleration += .002;
    }
  }

  void mousePressed() {
    if ((mousePressed == true) 
      && (dist(mouseX, mouseY, x, y) < radius/2
      && mouseX != pmouseX  && mouseY != pmouseY)) {
      acceleration += .1;
      stroke(random(255), random(255), random(255));
    }
  }
}
