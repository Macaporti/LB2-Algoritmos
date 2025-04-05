//Este código muestra una historia visual con tres imágenes (Beginning, Middle y End), tambien se utilizan dos personajes animados (Perro y Gato) que se activan al hacer clic con el mouse.

// Variables para las imágenes (B=beginning, M=middle, E=end)
PImage b, m, e;
// Control de imágenes
int fase = 0; 

// (Perro y Gato)
Perro miPerro = null;
Gato miGato = null;

// Variable para alternar mostrar y ocultar perro y gato
boolean mostrarPerroGato = false;

void setup() {
  size(600, 600);

  // Cargar imágenes
  b = loadImage("b.jpg");  
  m = loadImage("m.jpg");  
  e = loadImage("e.jpg");  
}

void draw() {
  background(0);

  // Mostrar imagen según la fase (fase 0=Beginning, fase 1=Middle, fase 2=End)
  if (fase == 0) {
    image(b, 0, 0, width, height);
  } else if (fase == 1) {
    image(m, 0, 0, width, height);
  } else if (fase == 2) {
    image(e, 0, 0, width, height);
  }

  // Mostrar y mover Perro y Gato si el clic del mouse está activo
  if (mostrarPerroGato && miPerro != null && miGato != null) {
    miPerro.display();
    miPerro.move();
    miGato.display();
    miGato.move();
  }
}

void keyPressed() {
  // Cambiar imágenes con la tecla 'p' (pasan las imágenes en orden beginning, middle, end)
  if (key == 'p') {
    fase++;
    if (fase > 2) {
      fase = 0;
    }
  }

  // Volver con flecha izquierda (se devuelve a la foto anterior de la historia)
  if (keyCode == LEFT) {
    fase--;
    if (fase < 0) {
      fase = 2;
    }
  }
}

void mousePressed() {
  // Cambiar el estado: si está activado se apaga, si está apagado se activa
  // (mouse se presiona, aparece Perro y Gato; si no está presionado, desaparecen)
  mostrarPerroGato = !mostrarPerroGato;

  // Si se activan por primera vez, crear los objetos
  if (mostrarPerroGato && miPerro == null && miGato == null) {
    miPerro = new Perro(color(#E49CC4), width / 2, 50, 3);
    miGato = new Gato(color(#9DD8F7), width / 3, 50, 2);
  }

  // Si ya existen, emiten sonido cada vez que se activan
  if (mostrarPerroGato && miPerro != null && miGato != null) {
    miPerro.ladrar();
    miGato.maullar();
  }
}

// CLASES

class Mamifero {
  color c;
  float posx;
  float posY;
  float speed;

  // color, posición (x, y) y velocidad
  Mamifero(color tempC, float tempPosX, float tempPosY, float tempSpeed) {
    c = tempC;
    posx = tempPosX;
    posY = tempPosY;
    speed = tempSpeed;
  }

  // Perro y Gato: círculos en la pantalla, con posición y color
  void display() {
    stroke(0);
    fill(c);
    ellipse(posx, posY, 50, 50);
  }

  // Movimiento del Gato y Perro según velocidad
  void move() {
    posY += speed;
    if (posY > height || posY < 0) {
      speed *= -1;
    }
  }
}

// La clase Perro hereda de Mamifero
class Perro extends Mamifero {
  Perro(color tempC, float tempPosX, float tempPosY, float tempSpeed) {
    super(tempC, tempPosX, tempPosY, tempSpeed);
  }

  // consola impresión
  void ladrar() {
    println("Guau");
  }
}

// La clase Gato también hereda de Mamifero
class Gato extends Mamifero {
  Gato(color tempC, float tempPosX, float tempPosY, float tempSpeed) {
    super(tempC, tempPosX, tempPosY, tempSpeed);
  }

  // consola impresión
  void maullar() {
    println("Miau");
  }
}
