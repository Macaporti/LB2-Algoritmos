void setup() {
  size(800, 800); 
  background(0);
  noStroke();
  fill(255);
  
} 
  // inicialización; condición; incremento

void draw() {
  int x = 50;
  int y = 50;
  while (x < width) {
    y = 50;
    //println(x);
    while (y < height) {
      ellipse(x, y, 20, 20);
    y = y + 50; 
    }
    x = x + 50;
  }
}

  
  
