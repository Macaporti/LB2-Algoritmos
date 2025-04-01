// Creamos el contenedor
Perro miPerro;
Gato miGato;

void setup() {
  size(800, 800);
  miPerro = new Perro(color(255), width / 2, 50, 5, 10);
  miGato = new Gato(color(100), width / 3, 50, 5, 10);
}

void draw() {
  background(0);
  miPerro.display();
  miPerro.move();
  miPerro.ladrar();
  miGato.display();
  miGato.move();
}

class Mamifero {
  // Propiedades
  color c;
  float posx;
  float posY;
  float speed;
  
  // Constructor
  Mamifero(color tempC, float tempPosX, float tempPosY, float tempSpeed) {
    c = tempC;
    posx = tempPosX;
    posY = tempPosY;
    speed = tempSpeed;
  }
  
  // Métodos
  void display() {
    stroke(0);
    fill(c);
    ellipse(posx, posY, 50, 50);
  }
  
  void move() {
    posY += speed;
    if (posY > height || posY < 0) {
      speed *= -1;
    }
  }
}

class Perro extends Mamifero {
  float lengthTail;
  
  Perro(color tempC, float tempPosX, float tempPosY, float tempSpeed, float tempLengthTail) {
    super(tempC, tempPosX, tempPosY, tempSpeed);
    lengthTail = tempLengthTail;
  }
  
  void ladrar() {
    println("Guau");
  }
}

class Gato extends Mamifero {
  float lengthNails;
  
  Gato(color tempC, float tempPosX, float tempPosY, float tempSpeed, float tempLengthNails) {
    super(tempC, tempPosX, tempPosY, tempSpeed);
    lengthNails = tempLengthNails;
  }
  
  void maullar() {
    println("Miau");
  }
}
