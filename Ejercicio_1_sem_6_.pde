int x = 0;
int y = 20;

void setup() {
  size(800,800);
  background(255);
  noStroke();
  
}

void draw(){
  if(y < height) {
    fill(0);
    ellipse(x, y, 40, 40);
    delay(100);
    //x = x + 50
    x += 50;
    
    if(x > width) {
      x = 0;
      y = y + 50;
    }
  }
}
