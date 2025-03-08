//Este código en se genera una interaccion entre diferentes figuras y codigos aprendidos en clase. Sin embargo, yo decidi usar un modo psicodelico 
//para esta intervencion fue esencial comprender y tener la ayuda de chat got ya que asi pude utilizar comandos como map, sin, cos, shapeType, y la activacion del modo psicodelico.
//A lo largo de la canción "Travis Scott - MY EYES", tome la desicion que las figuras cambiaarn de color y tamano para que fuera mas entretenido y demostrara lo aprendido hasta el momento en clase.
//Finalmente, los colores de manera aleatoria para generar un efecto visual caótico y dinámico. Fue un ejercicio interesante y retador, un poco abrumante cuando no lograba lo que esperaba, 
//pero al final me gusto el resultado y lo que aprendi. 

  import ddf.minim.*;
  import ddf.minim.analysis.*;
  
  Minim minim;
  AudioPlayer player;
  FFT fft;
  
// Variables para controlar la animación y las figuras
    int x = 0;
    int y = 50;
    float rad;
    float level;
    
//se anade la variable psicodelica pero solo en la parte final de la cancion
    boolean psicodelico = false; 
//numero de figuras 
    int numFiguras = 50; 
//posición, velocidad y tamaño de las figuras:
    float[] xPos, yPos, xSpeed, ySpeed, sizeFactor; 
//tipo de figura
    int[] shapeType;
//colores, R,G,B
    float[] colorR, colorG, colorB;
//conttrol de color en las figuras si aumenta o disminuye
    boolean[] increasingColor;
    
  void setup() {
    size(800, 800);
    background(0);
    frameRate(60);

//CANCION SELECCIONADA
    minim = new Minim(this);
    player = minim.loadFile("Travis Scott - MY EYES (Official Audio).mp3", 1024);
    fft = new FFT(player.bufferSize(), player.sampleRate());
    player.play();
  
// Inicializar de los arrays para que hayan figuras en movimiento
  //posiciones de figuras
    xPos = new float[numFiguras];
    yPos = new float[numFiguras];
  //velocidad x, y
    xSpeed = new float[numFiguras];
    ySpeed = new float[numFiguras];
  //tamano de cada figura
    sizeFactor = new float[numFiguras];
  //tipo de figura entre las tres que se escogieron (circulo, triangulo, cuadrado)
    shapeType = new int[numFiguras];
  //colores aleatorios 
    colorR = new float[numFiguras];
    colorG = new float[numFiguras];
    colorB = new float[numFiguras];
    increasingColor = new boolean[numFiguras];

//numero de figuras que se van a generar
    for (int i = 0; i < numFiguras; i++) {
//posicionamiento aleatorio de figuras
      xPos[i] = random(width);
      yPos[i] = random(height);
//velocidad de figuras
      xSpeed[i] = random(1, 2);
      ySpeed[i] = random(2, 5);
//tamano aleatorio de las figuras
      sizeFactor[i] = random(20, 60);
//se decide que figura puede ser entre circulo, triangulo y cuadrado 
      shapeType[i] = int(random(3)); 
//seleccion de colores aleatoriamente
      colorR[i] = random(150, 255);
      colorG[i] = random(0, 255);
      colorB[i] = random(100, 255);  
//Si true, el color va aumentando en el brillo
      increasingColor[i] = true;
    }
  }
  
  void draw() {
    fft.forward(player.mix);
    level = fft.getBand(10);
  
    // Activar modo psicodélico si el tiempo supera 2:27// este tiempo se escogio poprque cambia la cancion 
    if (player.position() > 147000) { // 2 minutos 27 segundos en milisegundos - 147000 representacion en milisegundos para saber en que momento es cuando debe haber un cambio 
    // se activa el modo psicodelico 
      psicodelico = true;
    }
  
  // cambio de fondo cuando se activa el modo psicodelico 
    if (!psicodelico) {
      background(0, 20);
  // se mantiene el fondo negro con la opacidad de 20
    } else {
  //Se anade un cambio aleatorio en el fondo y una opacidad de 50     
      background(random(255), random(255), random(255), 50);
    }
  
  //se le pregunto a chat para que ayudara a saber como poner una intensidad a partir de cierto nivel de frecuencia en el audio que aumentara una intensidad en las figuras
    if (level > 0.5) {
  //depende del nivel de sonido y se anade un factor de escala, ya que no se desa que la figura sea demasiado grande 
      rad = (level * width / 8);
      
//valores de colores dinamicos, se investigo un poco mas para comprender como funciona el comando map y como este va ligado de coseno y seno, en este caso seno y coseno hacen que 
// se oscile entre -1 y 1, para que hayan cambios suaves en el tiempo. 
//framecoaunt numero de fotogramas
      float r = map(sin(frameCount * 0.05), -1, 1, 150, 255);
      float g = map(cos(frameCount * 0.03), -1, 1, 0, 255);
      float b = map(sin(frameCount * 0.07), -1, 1, 100, 255);
  //se anade un contorno en las figuras para que sea mas llamativo y psicodelico visualmente 
      stroke(r, g, b, 100);
  //relleno de figura con una opacidad de 80  
      fill(r, g, b, 80);
  
      // ayuda de chat ya que se queria lograr el alternado de figuras geometricas, y asi usar framecount para que hubiera un cambio ciclico 
      //Dibujo de cuadrado cuando frameCount es múltiplo de 3 = 0 
      if (frameCount % 3 == 0) {
  //dibujo de cuadrado con framecount 
        square(x, y, rad);
      } else if (frameCount % 3 == 1) {
  //// Dibujo de circulos cuando el residuo es 1   
        ellipse(x + rad / 2, y + rad / 2, rad, rad);
      } else {
    //// Dibujo de triángulo cuando el residuo es 2
        triangle(x, y - rad / 2, x - rad / 2, y + rad / 2, x + rad / 2, y + rad / 2);
      }
  
  //posicionamiento de figuras 
      x += 80;
      if (x > width) {
//x mayor a width se reinicia 
        x = 0;
// Se aumenta y en 80, moviendo la siguiente figura hacia abajo a una nueva fila.
        y += 80;
      }
  // cuando y es mayor que height se vuelve a empezar desde 0 
      if (y > height) {
        y = 0;
        background(0);
      }
    }
  
    // Dibujar figuras en movimiento con cambio de color dinámico
    for (int i = 0; i < numFiguras; i++) {
  //Cada figura se (xSpeed[i] y ySpeed[i]) su posición (xPos[i] y yPos[i]).
      xPos[i] += xSpeed[i];
      yPos[i] += ySpeed[i];
      if (xPos[i] > width || xPos[i] < 0) xSpeed[i] *= -1;
      if (yPos[i] > height || yPos[i] < 0) ySpeed[i] *= -1;

//ayuda de chat - cada figura cambia de color gracias a sin() y cos(). Se usa map() para convertir los valores de sin() en colores dentro del rango 0-255.
//(R, G, B) cambian a ritmos diferentes,
//colores psicodélico 
      colorR[i] = map(sin(frameCount * 0.02 + i), -1, 1, 150, 255);
      colorG[i] = map(cos(frameCount * 0.03 + i), -1, 1, 0, 255);
      colorB[i] = map(sin(frameCount * 0.04 + i), -1, 1, 100, 255);

//Si psicodelico == true → Se generan colores aleatorios en cada frame para cada figura, asi pues se pone una opacidad de 200 y un contorno con opacidad de 255
      if (psicodelico) {
        fill(random(255), random(255), random(255), 200);
        stroke(random(255), random(255), random(255), 255);
      } else {
// si psicodelico es false → Se generan colores calmados y mas armoniosos que no sean psicodelicos
        fill(colorR[i], colorG[i], colorB[i], 150);
        stroke(colorR[i], colorG[i], colorB[i], 200);
      }
//shape type (0,1,2) el programa lo redondea a tres son solo tres figuras, circulo, triangulo y cuadrado. Este comando indica que figura se utiliza= Si shapeType[i] == 0, se dibuja un círculo 
//(ellipse), Si shapeType[i] == 1, se dibuja un cuadrado (rect), Si shapeType[i] == 2, se dibuja un triángulo (triangle). Para comprender y utilizar este comando chat ayudo para que se lograra lo que 
// se esperaba en esta ejecucion de programa.

      if (shapeType[i] == 0) {
        ellipse(xPos[i], yPos[i], sizeFactor[i], sizeFactor[i]);
      } else if (shapeType[i] == 1) {
        rect(xPos[i] - sizeFactor[i] / 2, yPos[i] - sizeFactor[i] / 2, sizeFactor[i], sizeFactor[i]);
      } else {
        triangle(xPos[i] - sizeFactor[i] / 2, yPos[i] + sizeFactor[i] / 2,
          xPos[i] + sizeFactor[i] / 2, yPos[i] + sizeFactor[i] / 2,
          xPos[i], yPos[i] - sizeFactor[i] / 2);
      }
    }
  }
