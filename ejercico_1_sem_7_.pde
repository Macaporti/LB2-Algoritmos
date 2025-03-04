int x = 0;
int y = 50;
float rad;
float level;
void setup() {
  size (800, 800);
  background (0) ;
  frameRate(800);
}
void draw() {
  //variable provisional
  level=random (0, 1);
  rad=(level*width/2);
  float r = random(0, 100);
  float g = random (100, 255);
  float b = random (200, 255);
  stroke(r, g, b);
  fill(255, 10);
  ellipse(x, y, rad, rad);
  println(width);
  x++;

  //Controla lo que pasa cuando se llega al borde derecho
  if (x > width) {
    x = 0;
    y += 80;
  }

  //Controla lo que pasa cuando se llega l borde inferior
  if (y > height) {
    y = 0;
    background (0) ;
  }
}
