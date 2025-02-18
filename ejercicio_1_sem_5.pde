boolean isGray = false; // Variable para alternar color

void setup() {
  size(500, 500);
}

void draw() {
  background(0);

  if (isGray) {
    fill(150); // Color gris
  } else {
    fill(255); // Color blanco
  }

  rect(mouseX, mouseY, 50, 50);
}

void mousePressed() {
  isGray = !isGray; // Alternar entre gris y blanco
}
