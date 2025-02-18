int h;
int m;
int s;

String timeString;
float textSizeValue = 40; // Tamaño inicial del texto

void setup() {
  size(500, 500);
  textAlign(CENTER, CENTER);
}

void draw() {
  h = hour();
  m = minute();
  s = second();
  
  timeString = nf(h, 2) + ":" + nf(m, 2) + ":" + nf(s, 2);
  
  background(0);
  textSize(textSizeValue);
  fill(255);
  text(timeString, width / 2, height / 2);
}

void mousePressed() {
  textSizeValue += 2; // Aumenta el tamaño del texto en una unidad
}
