// variables para imagenes 
 PImage b, m, e;
//Variable'fase' para controlar que iamegenes se ven mostrando 
int fase = 0; 

//tamano imagenes 
void setup() {
  size(600, 600);
  
// imagenes subidas b-beginning, m-middle, e-end
  b = loadImage("b.jpg");
  m = loadImage("m.jpg");
  e = loadImage("e.jpg");
}


void draw() {
  background(0);

// imagen de inicio 0
  if (fase == 0) {
    image(b, 0, 0, width, height);
  } else if (fase == 1) {
//imagen medio
    image(m, 0, 0, width, height);
  } else if (fase == 2) {
//imagen final 
    image(e, 0, 0, width, height);
  }
}

//tecla 'p', se mueve a la siuiente imagen 
void keyPressed() {
  if (key == 'p') {
    fase++;
//Si se va a la ultima imagen se vuelve a la primera
    if (fase > 2) {
      fase = 0;
    }
  }

//con la flecha izquierda se devuelve a la imagen anterior 
  if (keyCode == LEFT) {
    fase--;
    if (fase < 0) {
      fase = 2;
    }
  }
}
