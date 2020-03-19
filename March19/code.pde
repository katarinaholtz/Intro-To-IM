void setup() {
  size(600, 600);
  background(#B298D1);
}

void draw() {
  //arms
  fill(255, 225, 190);
  rect(180, 330, 100, 30);

  fill(255, 225, 190);
  rect(320, 330, 100, 30);

  //body
  fill(#DC6767);
  triangle(200, 500, 300, 200, 400, 500);

  //hairbun
  fill(#641919);
  noStroke();
  ellipse(300, 100, 60, 60);

  //hairhead
  fill(#641919);
  ellipse(300, 190, 130, 150);

  //ears
  fill(255, 225, 190);
  ellipse(230, 200, 20, 30);

  fill(255, 225, 190);
  ellipse(370, 200, 20, 30);

  //earrings
  fill(#000000);
  ellipse(230, 210, 10, 10);

  fill(#000000);
  ellipse(370, 210, 10, 10);

  //face
  fill(255, 225, 190);
  ellipse(300, 200, 130, 150);

  //eyes
  fill(#FFFFFF);
  ellipse(320, 180, 30, 20);
  fill(#7B200C);
  ellipse(320, 180, 20, 20);

  fill(#FFFFFF);
  ellipse(280, 180, 30, 20);
  fill(#7B200C);
  ellipse(280, 180, 20, 20);

  //facemask
  fill(#C4F4FE);
  rect(275, 220, 51, 38);

  //facemask lines
  fill(#000000);
  rect(237, 225, 40, 1);

  fill(#000000);
  rect(245, 250, 30, 1);

  fill(#000000);
  rect(326, 225, 40, 1);

  fill(#000000);
  rect(326, 250, 30, 1);

  //text
  String s = "Wash your hands";
  fill(30);
  text(s, mouseX, mouseY, 70, 80);
}

void mousePressed() {
  background(#B298D1);
}
