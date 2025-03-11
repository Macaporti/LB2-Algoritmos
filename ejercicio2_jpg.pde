PImage b, m, e;
int fase = 0;

void setup() {
  size(600, 600);
  
  b = loadImage("b.jpg");
  m = loadImage("m.jpg");
  e = loadImage("e.jpg");
}

void draw() {
  background(0);
  
  if (fase == 0) {
    image(b, 0, 0);
  } else if (fase == 1) {
    image(m, 0, 0);
  } else if (fase == 2) {
    image(e, 0, 0);
  }
}

void mousePressed() {
  fase++;
  println(fase);
  
  // Si la fase es mayor a 2, reinicia a 0
  if (fase > 2) { 
    fase = 0;
  }
}
