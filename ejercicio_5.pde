float [] xPositions;
float [] yPositions;

void setup() {
  size(800, 800);
  background(0);
  noStroke();

  xPositions = new float[10];
  yPositions = new float[10];

  for (int i = 0; i < xPositions.length; i++) {
    xPositions[i] = random(0, width);
  } 

  for (int i = 0; i < yPositions.length; i++) {
    yPositions[i] = random(0, height);
  } 
} 

void draw() {
  for (int i = 0; i < xPositions.length; i++) {
    ellipse(xPositions[i], yPositions[i], 50, 50);
  }
}
