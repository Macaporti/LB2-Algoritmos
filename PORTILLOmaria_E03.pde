//En este código se utilizan diferentes códigos como float, int, boolean, void draw, void setup, para crear un conjunto de figuras (círculos, triángulos y cuadrados),
//para que se desplacen teniendo cambio de color. Igualmente con cierta velocidad y rebote en la pantalla para que pueda perdurar infinitamente el código. 

// Número de figuras en movimiento
int numFiguras = 10;

// Cada figura
float[] xPos, yPos, xSpeed, ySpeed, sizeFactor;
int[] shapeType;
float[] colorGray;
boolean[] increasingColor;

void setup() {
  size(800, 800);
  noStroke();
  
  // Inicialización 
  xPos = new float[numFiguras];
  yPos = new float[numFiguras];
  xSpeed = new float[numFiguras];
  ySpeed = new float[numFiguras];
  sizeFactor = new float[numFiguras];
  shapeType = new int[numFiguras];
  colorGray = new float[numFiguras];
  increasingColor = new boolean[numFiguras];

  for (int i = 0; i < numFiguras; i++) {
    xPos[i] = random(width);
    yPos[i] = random(height);
    //velocidad de las figuras eje y x
    xSpeed[i] = random(5, 8);
    ySpeed[i] = random(4, 3);
    //tamaños figuras - forma aleatorio 
    sizeFactor[i] = random(20, 60);
    //Tipo de figura 
    shapeType[i] = int(random(3)); 
    //Color inicial 
    colorGray[i] = random(90, 200);
    // aumento y disminución del color en las figuras 
    increasingColor[i] = true; 
  }
}

void draw() {
  //fondo
  background(#ECD5C8); 

  for (int i = 0; i < numFiguras; i++) {
    // Movimiento
    xPos[i] += xSpeed[i];
    yPos[i] += ySpeed[i];

    // Rebote en los bordes
    if (xPos[i] > width || xPos[i] < 0) xSpeed[i] *= -1;
    if (yPos[i] > height || yPos[i] < 0) ySpeed[i] *= -1;
    
    // Cambio progresivo de color en escala de grises
    if (increasingColor[i]) {
      colorGray[i] += 2;
      if (colorGray[i] >= 255) increasingColor[i] = false;
    } else {
      colorGray[i] -= 2;
      if (colorGray[i] <= 0) increasingColor[i] = true;
    }
    
    // Dibujar figuras con el color variable
    fill(colorGray[i]);

    if (shapeType[i] == 0) {
      //círculo
      ellipse(xPos[i], yPos[i], sizeFactor[i], sizeFactor[i]); 
    } else if (shapeType[i] == 1) {
      //cuadrado
      rect(xPos[i] - sizeFactor[i] / 2, yPos[i] - sizeFactor[i] / 2, sizeFactor[i], sizeFactor[i]); 
    } else {
      //triángulo
      triangle(xPos[i] - sizeFactor[i] / 2, yPos[i] + sizeFactor[i] / 2,
               xPos[i] + sizeFactor[i] / 2, yPos[i] + sizeFactor[i] / 2,
               xPos[i], yPos[i] - sizeFactor[i] / 2); 
    }
  }
}
