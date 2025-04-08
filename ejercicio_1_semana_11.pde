//variables booleanas que dicen si A o B están "encendidos" o no
boolean a = false;
boolean b = false;

void setup() {
  size(300, 200);
  background(255);
}

void draw() {
  background(255);

  // Círculo A
  /// Si A está encendido (true), el color será verde
  if (a) {
    fill(0, 255, 0); // verde
  // Si A está apagado (false), el color será gris
  } else {
    fill(200); // gris
  //posición 
  }
  ellipse(75, 60, 50, 50);

  //Si B está encendido (true), el color será verde
  // Círculo B
  if (b) {
    fill(0, 255, 0);
  //Si B está apagado (false), el color será gris
  } else {
    fill(200);// gris
  //posicion
  }
  ellipse(225, 60, 50, 50);

  // Resultado de A && B
  // Si A y B están encendidos (true && true), color amarillo
  if (a && b) {
    fill(255, 255, 0); // amarillo
  //// Si uno o ambos están apagados, el color es gris oscuro (luz apagada)
  } else {
    fill(100); // gris oscuro
  //Círculo resultado abajo
  }
  ellipse(150, 140, 60, 60);
}

// Clic en los círculos para cambiar su estado
// clic círculo A
void mousePressed() {
  if (dist(mouseX, mouseY, 75, 60) < 25) {
    a = !a; // Cambia A al valor contrario (si era true pasa a false, y viceversa)
  }
  // clic círculo B 
  if (dist(mouseX, mouseY, 225, 60) < 25) {
    b = !b; // cambiar B al valor contrario (si era true pasa a false, y viceversa)
  }
}
