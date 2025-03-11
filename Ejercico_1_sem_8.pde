float w = 100;
float posY = 0; 

void setup() {
  size(400, 400);
}

void draw() {
  background(255);
//actividad en clase 
  // Dibujar la elipse
  //imputs
  // x, y, w, h
  drawEllipse(200, posY, w, 50); 
  posY ++;

  // Hacer que la elipse regrese cuando llegue al borde derecho
  if (posY > width) {
    posY = 0;
  }
  posY++;
  w =random(width);
}

void drawEllipse(float x, float y, float w, float h) {
  println(w);
  ellipse(x, y, w, h);
}
