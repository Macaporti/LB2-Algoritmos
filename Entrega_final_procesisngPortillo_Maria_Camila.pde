// Este proyecto explora una narrativa interactiva que se desarrolla a través de imágenes, texto, sonido e interacción.
// El usuario navega por distintas fases y al final puede votar su experiencia emocional.

// Librería de audio
import ddf.minim.*;

// Declaración de variables para el audio
Minim minim;
AudioPlayer cancion;

// Imágenes para la portada, el final y las escenas de la historia
PImage portada;
PImage fin;
PImage[] escenas = new PImage[6]; // 6 escenas principales

// Textos narrativos que acompañan cada fase visual
String[] textos = {
  "Valeria empezó clases sin estar muy segura… todavía no sabía si esto era realmente lo suyo.",
  "Los trabajos se acumulaban, y aunque lo intentaba, el día nunca alcanzaba.",
  "A veces quería dejarlo todo. Dudaba de sí misma más de lo que admitía.",
  "Poco a poco, empezó a confiar en lo que hacía. Y en quién era cuando lo hacía.",
  "Poco a poco empezó a valorarse más, y con cada proyecto se hacía visible también a sí misma.",
  "Ella diseña para ella misma, porque ama lo que hace y es una diseñadora muy feliz y exitosa hoy en día."
};

// Colores del texto para cada fase
color[] coloresTexto = {
  color(255), color(150, 200, 255), color(255, 240, 150),
  color(255, 180, 180), color(180, 140, 255), color(210, 180, 255)
};

// Control de fases: -1 portada, 0–5 historia, 6 final con votación
int fase = -1;
int presiones = 0;
boolean[] bloqueos = {true, true, true, true}; // Control de avance

// Clase que representa una elipse que rebota y detecta clics
class ElipseInteractiva {
  float x, y, velX, velY;
  int tam, clics;

  ElipseInteractiva(float x, float y, float velX, float velY, int tam) {
    this.x = x;
    this.y = y;
    this.velX = velX;
    this.velY = velY;
    this.tam = tam;
    this.clics = 0;
  }

  // Movimiento de la elipse con rebote en los bordes
  void mover() {
    x += velX;
    y += velY;
    if (x < 0 || x > width) velX *= -1;
    if (y < 0 || y > height) velY *= -1;
  }

  // Dibujo de la elipse
  void mostrar() {
    fill(#FFA94D);
    ellipse(x, y, tam, tam);
  }

  // Verifica si se hizo clic sobre la elipse
  boolean fueClickeada(float mx, float my) {
    return dist(mx, my, x, y) < tam / 2;
  }

  // Reinicia la posición y el contador de clics
  void reiniciar() {
    clics = 0;
    x = random(100, 700);
    y = random(100, 700);
  }
}

// Clase que representa una carita emocional para votar
class Carita {
  float x, y, tam = 80;
  color c;
  String tipo;
  boolean seleccionada;

  Carita(float x, float y, color c, String tipo) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.tipo = tipo;
    this.seleccionada = false;
  }

  // Dibuja la carita con ojos y expresión (feliz, seria o triste)
  void mostrar() {
    fill(c);
    stroke(0);
    ellipse(x, y, tam, tam);
    fill(0);
    if (tipo.equals("feliz")) {
      arc(x, y + tam * 0.125, tam * 0.5, tam * 0.25, 0, PI);
    } else if (tipo.equals("seria")) {
      line(x - tam * 0.25, y + tam * 0.125, x + tam * 0.25, y + tam * 0.125);
    } else if (tipo.equals("triste")) {
      arc(x, y + tam * 0.25, tam * 0.5, tam * 0.25, PI, TWO_PI);
    }
    ellipse(x - tam * 0.1875, y - tam * 0.125, tam * 0.1, tam * 0.1);
    ellipse(x + tam * 0.1875, y - tam * 0.125, tam * 0.1, tam * 0.1);
  }

  // Verifica si se hizo clic sobre esta carita
  boolean fueClickeada(int mx, int my) {
    return dist(mx, my, x, y) < tam / 2;
  }
}

// Instanciación de clases
Carita[] caritas = new Carita[3];
Carita seleccionada = null;
ElipseInteractiva elipse;

// Función inicial de configuración (setup)
void setup() {
  size(800, 800);

  // Carga del audio y reproducción en loop
  minim = new Minim(this);
  cancion = minim.loadFile("Coldplay - Up&Up (Official Video).mp3");
  cancion.loop();

  // Carga de imágenes para cada fase
  portada = loadImage("Portada .jpg");
  fin = loadImage("FIN.jpg");
  escenas[0] = loadImage("Principio_page-0001.jpg");
  escenas[1] = loadImage("conflicto_page-0001.jpg");
  escenas[2] = loadImage("Rising _page-0001.jpg");
  escenas[3] = loadImage("Climax_page-0001.jpg");
  escenas[4] = loadImage("Falling Action_page-0001.jpg");
  escenas[5] = loadImage("Resolution_page-0001.jpg");

  // Inicialización de elipse y caritas
  elipse = new ElipseInteractiva(random(100, 700), random(100, 700), 3.2, 2.5, 50);
  caritas[0] = new Carita(width / 2 - 150, height - 100, color(#FFC978), "feliz");
  caritas[1] = new Carita(width / 2, height - 100, color(#D76517), "seria");
  caritas[2] = new Carita(width / 2 + 150, height - 100, color(#6A8FFF), "triste");
}

void draw() {
  background(0); // Fondo negro para resaltar todos los elementos

  // Fase -1: portada inicial del proyecto
  if (fase == -1) {
    image(portada, 0, 0, width, height); // Dibuja la portada
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Presiona la tecla A para comenzar", width / 2, height - 60); // Instrucción inicial
    return;
  }

  // Fase 6: pantalla final con votación emocional
  if (fase == 6) {
    image(fin, 0, 0, width, height); // Imagen de fondo final

    // Si no se ha seleccionado ninguna carita, se muestran las opciones para votar
    if (seleccionada == null) {
      fill(255);
      textAlign(CENTER);
      textSize(18);
      text("Por favor, oprime la carita que represente cuánto te gustó esta historia.", width / 2, height - 160);
      
      // Dibuja las tres caritas en pantalla
      for (Carita c : caritas) {
        c.mostrar();
      }

      // Muestra instrucción para devolverse con @
      textAlign(LEFT);
      textSize(16);
      fill(0);
      text("Presiona @ para devolverte", 20, 30);

    } else {
      // Si ya se seleccionó una carita, se amplía y se muestra un mensaje personalizado
      Carita c = seleccionada;
      c.x = width / 2;
      c.y = height / 2 + 30;
      c.tam = 140;
      c.mostrar();

      // Mensaje correspondiente a la carita seleccionada
      String mensaje = "";
      if (c.tipo.equals("feliz")) {
        mensaje = "¡Me alegra muchísimo que hayas disfrutado esta historia!";
      } else if (c.tipo.equals("seria")) {
        mensaje = "Gracias por tu sinceridad, es muy valiosa para mí en futuros proyectos.";
      } else if (c.tipo.equals("triste")) {
        mensaje = "Lamento que no te haya gustado tanto... pero valoro mucho que me hayas acompañado hasta el final.";
      }

      // Dibuja primero un borde blanco alrededor del texto
      textAlign(CENTER);
      textSize(26);
      fill(255);
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx != 0 || dy != 0) {
            text(mensaje, width / 2 + dx, height - 140 + dy, width * 0.85, 200);
          }
        }
      }

      // Dibuja el mensaje principal en el color de la carita seleccionada
      fill(c.c);
      text(mensaje, width / 2, height - 140, width * 0.85, 200);

      // Caja semitransparente con instrucciones adicionales
      rectMode(CENTER);
      stroke(255);
      strokeWeight(1.5);
      fill(0, 200);
      rect(width / 2, height - 50, 620, 80, 15);

      // Instrucciones para cambiar voto o terminar
      fill(255);
      textSize(18);
      text("Presiona L si deseas cambiar tu respuesta", width / 2, height - 62);
      text("Presiona '.' para volver al principio o ',' para cerrar esta ventana.", width / 2, height - 38);
    }
    return; // Fin de la fase final
  }

  // Dibuja la imagen correspondiente a la fase actual de la historia
  image(escenas[fase], 0, 0, width, height);

  // Define el tamaño del cuadro de texto según la fase
  int textBoxWidth = int(width * 0.9);
  int textBoxHeight = (fase == 2 || fase == 4 || fase == 5) ? 130 : 100;
  int textY = height - 80;

  // Dibuja un recuadro semitransparente para mostrar el texto
  stroke(255);
  strokeWeight(1.5);
  fill(0, 200);
  rectMode(CENTER);
  rect(width / 2, textY, textBoxWidth, textBoxHeight, 15);

  // Muestra el texto narrativo correspondiente a la fase
  fill(coloresTexto[fase]);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(textos[fase], width / 2, textY, textBoxWidth - 40, textBoxHeight - 20);

  // Muestra instrucciones específicas según la fase activa y su estado de bloqueo
  textAlign(CENTER, CENTER);
  textSize(16);

  if (fase == 0 && bloqueos[0]) {
    fill(255, 240);
    noStroke();
    ellipse(width - 180, 60, 360, 70); // Fondo ovalado para el mensaje
    fill(0);
    text("Presiona espacio 5 veces para pasar de página (" + presiones + "/5)", width - 180, 60);
  
  } else if (fase == 1 && bloqueos[1]) {
    instruccionRect("Presiona la letra 'p' para pasar de página");

  } else if (fase == 2 && bloqueos[2]) {
    instruccionRect("Presiona la tecla 8 para continuar");

  } else if (fase == 3 && bloqueos[3]) {
    instruccionRect("Haz clic derecho para continuar");

  } else if (fase == 5) {
    fill(0);
    text("Presiona ↑ para ver el final", width / 2, 25);
  }

  // Fase 4: interacción con la elipse flotante (solo si ya está desbloqueada)
  if (fase == 4 && !bloqueos[3]) {
    elipse.mostrar();
    elipse.mover();
    fill(0);
    textAlign(CENTER, TOP);
    text("Haz clic sobre el círculo para continuar (" + elipse.clics + "/6)", width / 2, 50);
  }

  // En fases 1 a 5, permite al usuario devolverse usando la tecla '@' o flecha izquierda
  if (fase >= 1 && fase <= 5) {
    fill(fase >= 3 ? 0 : #FFA94D); // Color de texto distinto según la fase
    textAlign(LEFT, TOP);
    textSize(20);
    text("Presiona @ para devolverte", 20, 20);
  }
}

// Dibuja una caja rectangular con un mensaje centrado
void instruccionRect(String mensaje) {
  fill(255, 230);
  stroke(0);
  rect(width - 190, 60, 270, 40, 10);
  fill(0);
  text(mensaje, width - 190, 60);
}

// Detecta las teclas presionadas por el usuario
void keyPressed() {
  // En la fase de portada, si se presiona la tecla 'A' o 'a', se inicia la historia
  if (fase == -1 && (key == 'a' || key == 'A')) {
    fase = 0;
    return;
  }

  // En la fase 0, se debe presionar la barra espaciadora 5 veces para avanzar
  if (fase == 0 && bloqueos[0] && key == ' ') {
    presiones++;
    if (presiones >= 5) {
      bloqueos[0] = false;
      fase = 1;
    }

  // En la fase 1, se avanza presionando la tecla 'p'
  } else if (fase == 1 && bloqueos[1] && key == 'p') {
    bloqueos[1] = false;
    fase = 2;

  // En la fase 2, se avanza presionando la tecla '8'
  } else if (fase == 2 && bloqueos[2] && key == '8') {
    bloqueos[2] = false;
    fase = 3;

  // En la fase 5, si se presiona la flecha ↑ se pasa al final (fase 6)
  } else if (fase == 5 && keyCode == UP) {
    fase = 6;
  }

  // En la fase final (6), si se presiona 'l' se reinicia la votación
  if (fase == 6 && key == 'l') {
    seleccionada = null;
    caritas[0] = new Carita(width / 2 - 150, height - 100, color(#FFC978), "feliz");
    caritas[1] = new Carita(width / 2, height - 100, color(#D76517), "seria");
    caritas[2] = new Carita(width / 2 + 150, height - 100, color(#6A8FFF), "triste");
  }

  // En la fase 6, si ya se votó:
  // '.' reinicia todo y vuelve a la portada
  // ',' cierra la aplicación
  if (fase == 6 && seleccionada != null) {
    if (key == '.') {
      fase = -1;
      presiones = 0;
      bloqueos[0] = bloqueos[1] = bloqueos[2] = bloqueos[3] = true;
      seleccionada = null;
      elipse.reiniciar();
    } else if (key == ',') {
      exit();
    }
  }
}

// Detecta clics del mouse
void mousePressed() {
  // En la fase 3, si se hace clic derecho se avanza a la fase 4
  if (fase == 3 && bloqueos[3] && mouseButton == RIGHT) {
    bloqueos[3] = false;
    fase = 4;
    return;
  }

  // En la fase 4, si se hace clic izquierdo sobre la elipse, se cuentan los clics
  // Cuando llega a 6, se pasa a la fase 5
  if (fase == 4 && !bloqueos[3] && mouseButton == LEFT) {
    if (elipse.fueClickeada(mouseX, mouseY)) {
      elipse.clics++;
      if (elipse.clics >= 6) {
        fase = 5;
      }
    }
  }

  // En la fase final (6), si no se ha seleccionado una carita y se hace clic sobre alguna, se selecciona
  if (fase == 6 && seleccionada == null) {
    for (Carita c : caritas) {
      if (c.fueClickeada(mouseX, mouseY)) {
        seleccionada = c;
      }
    }
  }
}

// Permite devolverse entre fases usando flecha izquierda o la tecla '@'
void keyReleased() {
  if (keyCode == LEFT || key == '@') {
    fase--;
    if (fase < 0) fase = 0;

    // Restablece los bloqueos y valores según la fase a la que se regresa
    if (fase == 0) presiones = 0;
    if (fase == 1) bloqueos[1] = true;
    if (fase == 2) bloqueos[2] = true;

    // Si se vuelve a la fase 3, se reinicia la elipse
    if (fase == 3) {
      bloqueos[3] = true;
      elipse.reiniciar();
    }

    // Si se regresa desde la fase final, se vuelve a la fase 5 y se borra la selección
    if (fase == 6) {
      fase = 5;
      seleccionada = null;
    }
  }
}
