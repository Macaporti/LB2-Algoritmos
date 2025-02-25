int x = 0;
int y = 0;

float level;
float rad;
void setup() {
  size (800, 800);
  background (255) ;
  frameRate (5);
}
void draw() {

  level = random(0, 1);
  rad = (level * width / 3);

 float r = sin(TWO_PI)/25.0);
 float g = cos(TWO_PI)/25.0);
 float b = sin(TWO_PI)/25.0);
 
 for (int i = 0; i < 5; i++) {
   fill(100, 10);
   stroke(r, g, b);
   ellipse (x, y, rad, rad);
 }
 if (y < height) {
   x += 50;
   if (x > width) {
     x= 0;
     y += 50;
   }
 } else {
   noLoop();
 }
}
