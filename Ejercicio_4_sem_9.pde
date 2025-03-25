void setup() {
  size(500, 500);
  background(0);
}

void draw() {
}

void keyPressed() {
  if (key == 'p') { 
    ellipse(50, 50, 50, 50);
  } else if (key == ' ') {
    rect(20, 20, 20, 20);
  } else if (keyCode == UP) {
    println("La tecla de la flecha ARRIBA se presionó");
  } else if (keyCode == DOWN) {
    println("La tecla de la flecha ABAJO se presionó"); 
  } else {
    println("Ninguna tecla válida se presionó");
  }
}
