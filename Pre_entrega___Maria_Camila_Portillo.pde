// la historia de Valeria demuestra mi vida y mi sueño ideal, ahora bien para esta entrega se penso en hacer algo interactivo que fuera divertido para el usuario de realizar. 
// esta historia corta trata de inspirar y decirle a las personas como es que por mas de que tenga uno obstaculos siempre va a poder sobrepasarlos sin importar que tan 
// dificiles sean. Este codigo cuenta tambien con una cancion para que sea mas divertido el momento de ir leyendo el cuento. 
// Chatgpt fue de gran ayuda para comprender como hacer cajas de texto, igualmente ayudo a corregir errores en el código que eran esenciales corregir.

import ddf.minim.*; // Librería de audio

Minim minim;
AudioPlayer cancion;

// Imagenes de la historia
PImage[] escenas = new PImage[6];

// Textos que se muestran en cada fase 
String[] textos = {
  "Valeria llegó a la universidad con cuadernos nuevos y muchos sueños.",
  "Pero las tareas eran muchas. Y el tiempo… muy poco.",
  "Cada día pensaba en rendirse. No creería que lo lograría, ya que era muy desconfiada con ella misma.",
  "Un día, sus ideas empezaron a brillar.",
  "Las marcas la buscaban. Sus diseños ya viajaban solos.",
  "Valeria ya no cargaba peso. Solo ideas."
};

// Colores para el texto en cada fase
color[] coloresTexto = {
  color(255),            // blanco
  color(150, 200, 255),  // celeste
  color(255, 240, 150),  // amarillo claro
  color(255, 180, 180),  // salmón
  color(180, 140, 255),  // morado
  color(210, 180, 255)   // lila pastel
};

// Control de fase actual (-1 = portada, 0-5 = historia)
int fase = -1;
// para contar las veces que se presiona espacio en fase 0
int presiones = 0; 

// Booleans que bloquean el paso de fase hasta cumplir interacciones
boolean[] bloqueos = {true, true, true, true};

// Variables para el círculo enemigo (fase 4)
float xElipse, yElipse;
float velX = 3.2, velY = 2.5;
int elipseTam = 50;
int clicksEnemigo = 0;

// Setup inicial 
void setup() {
  //// tamaño 
  size(800, 800); 

  // Inicializar audio
  minim = new Minim(this);
  cancion = minim.loadFile("Coldplay - Up&Up (Official Video).mp3");
  cancion.loop();

  // Cargar imágenes de cada fase
  escenas[0] = loadImage("Principio_page-0001.jpg");
  escenas[1] = loadImage("conflicto_page-0001.jpg");
  escenas[2] = loadImage("Rising _page-0001.jpg");
  escenas[3] = loadImage("Climax_page-0001.jpg");
  escenas[4] = loadImage("Falling Action_page-0001.jpg");
  escenas[5] = loadImage("Resolution_page-0001.jpg");

  // Posición inicial del círculo enemigo
  xElipse = random(100, 700);
  yElipse = random(100, 700);
}

// Loop principal
void draw() {
  background(0);

  // PORTADA - fase= -1
  if (fase == -1) {
    //animación suave figuras para desplazamiento
    float offset = sin(frameCount * 0.05) * 100; 

    // Figuras geométricas animadas
    fill(255, 200, 100); triangle(150 + offset, 200, 130 + offset, 240, 170 + offset, 240);
    fill(150, 220, 255); rect(350 + offset, 200, 40, 40);
    fill(255, 160, 200); ellipse(550 + offset, 220, 50, 50);

    // Título
    fill(#FFE180); textAlign(CENTER, CENTER); textSize(60);
    text("Inspiración desgastante", width / 2, height / 2);

    // Instrucción para comenzar
    fill(255); textSize(16);
    text("Presiona la tecla A para comenzar", width / 2, height / 2 + 90);
    return;
  }

  // Mostrar imagen de la fase actual
  image(escenas[fase], 0, 0, width, height);

  // Dibujar caja de texto (más grande para fases 2, 4 y 5)
  int textBoxWidth = int(width * 0.9);
  int textBoxHeight = (fase == 2 || fase == 4 || fase == 5) ? 130 : 100;
  int textY = height - 80;

  stroke(255); strokeWeight(1.5); fill(0, 200);
  rectMode(CENTER);
  rect(width / 2, textY, textBoxWidth, textBoxHeight, 15);

  // Mostrar texto narrativo
  fill(coloresTexto[fase]);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(textos[fase], width / 2, textY, textBoxWidth - 40, textBoxHeight - 20);

  // Mostrar instrucciones según fase
  textAlign(CENTER, CENTER); textSize(16);

  if (fase == 0 && bloqueos[0]) {
    fill(255, 240); noStroke(); ellipse(width - 180, 60, 360, 70);
    fill(0);
    text("Presiona espacio 5 veces para pasar de página (" + presiones + "/5)", width - 180, 60);
  } else if (fase == 1 && bloqueos[1]) {
    instruccionRect("Presiona la letra 'p' para pasar de página");
  } else if (fase == 2 && bloqueos[2]) {
    instruccionRect("Presiona la tecla 8 para continuar");
  } else if (fase == 3 && bloqueos[3]) {
    instruccionRect("Haz clic derecho para continuar");
  }

  // Fase 4: círculo enemigo
  if (fase == 4 && !bloqueos[3]) {
    fill(#FFA94D);
    ellipse(xElipse, yElipse, elipseTam, elipseTam);
    xElipse += velX;
    yElipse += velY;
    if (xElipse < 0 || xElipse > width) velX *= -1;
    if (yElipse < 0 || yElipse > height) velY *= -1;

    fill(0);
    textAlign(CENTER, TOP);
    text("Haz clic sobre el círculo para continuar (" + clicksEnemigo + "/6)", width / 2, 20);
  }

  // Instrucción para retroceder con @
  if (fase >= 1) {
    fill(fase >= 3 ? 0 : #FFA94D);
    textAlign(LEFT, TOP); textSize(20);
    text("Presiona @ para devolverte", 20, 20);
  }
}

// Función de instrucciones en recuadro ====
void instruccionRect(String mensaje) {
  fill(255, 230); stroke(0);
  rect(width - 190, 60, 270, 40, 10);
  fill(0);
  text(mensaje, width - 190, 60);
}

// Interacciones con teclado principio oprimir= a
void keyPressed() {
  if (fase == -1 && (key == 'a' || key == 'A')) {
    fase = 0;
    return;
  }

  if (fase == 0 && bloqueos[0] && key == ' ') {
    presiones++;
    if (presiones >= 5) {
      bloqueos[0] = false;
      fase = 1;
    }
  } else if (fase == 1 && bloqueos[1] && key == 'p') {
    bloqueos[1] = false;
    fase = 2;
  } else if (fase == 2 && bloqueos[2] && key == '8') {
    bloqueos[2] = false;
    fase = 3;
  }
}

// Clics del mouse 
void mousePressed() {
  if (fase == 3 && bloqueos[3] && mouseButton == RIGHT) {
    bloqueos[3] = false;
    fase = 4;
    return;
  }

  if (fase == 4 && !bloqueos[3] && mouseButton == LEFT) {
    float d = dist(mouseX, mouseY, xElipse, yElipse);
    if (d < elipseTam / 2) {
      clicksEnemigo++;
      if (clicksEnemigo >= 6) {
        fase = 5;
      }
    }
  }
}

// Retroceder fase 
void keyReleased() {
  if (keyCode == LEFT || key == '@') {
    fase--;
    if (fase < 0) fase = 0;

    if (fase == 0) {
      presiones = 0;
      bloqueos[0] = true;
    } else if (fase == 1) bloqueos[1] = true;
    else if (fase == 2) bloqueos[2] = true;
    else if (fase == 3) {
      bloqueos[3] = true;
      clicksEnemigo = 0;
    }
  }
}
