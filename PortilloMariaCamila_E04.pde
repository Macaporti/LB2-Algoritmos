//RELACION CON LECTURA
// el reloj de arena esta relacionado con la lectura de Judy Waycman, debido a que 
// en esta se hace una explicación a la transformación que ha tenido el tiempo 
// conforme a la tecnología. A diferencia de los otros relojes de arena, este representa
// -los segundos cayendo en linea recta representan la precision digital del tiempo. 
// -los minutos de forma circular demuestran una estructura continua y organizada. 
// -las horas en la parte inferior demuestran la forma rigida de ciertas demostraciones 
// de la hora como lo son los calendarios. 

//Este reloj resalta la fluidez natural del tiempo, una vision hecha por algoritmos 
// demostrando como la digitalizacion ha cambiado las percepciones con el tiempo. 

// chatgpt ayudo a colocar las esferas de los minutos y su posicionamiento
//y a ubicar el reloj de arena. 
int posX = 350;
int posY = 150;
int size = 100;

void setup() {
  size(800, 800);  // Tablero grande para mayor visibilidad
}

void draw() {
  background(150, 150, 200);
  
  int h = hour();
  int m = minute();
  int s = second();

  // rectángulos (soporte del reloj de arena)
  fill(#A5DAEF);
  rect(270, 190, 160, 10); // Rectángulo superior
  rect(270, 600, 160, 10); // Rectángulo inferior
  
  // reloj de arena
  fill(#F6BDD6);
  triangle(250, 200, 450, 200, 350, 400); // Parte superior
  triangle(250, 600, 450, 600, 350, 400); // Parte inferior
  
  // Dibujar la arena cayendo en línea recta (segundos)
  drawFallingSand(s);

  // Dibujar horas y minutos
  drawHours(h);
  drawMinutes(m);
}

// Dibujar la arena cayendo en línea recta (segundos)
void drawFallingSand(int s) {
  fill(#B8DCC6);
  for (int i = 0; i < s; i++) {
    //circulos segundos
    ellipse(350, 210 + i * 6, 10, 10); 
  }
}

// Dibujar las horas en una línea horizontal
void drawHours(int h) {
  fill(#AB6DAB);  
  int twelveHourFormat;
  
  // Convertir 24h a 12h manualmente
  if (h == 0) {          
    twelveHourFormat = 12;
  } else if (h > 12) {    
    twelveHourFormat = h - 12;
  } else {                
    twelveHourFormat = h;
  }

  // Dibujar círculos de las horas en la parte inferior
  for (int i = 0; i < twelveHourFormat; i++) {
    ellipse(200 + i * 45, 700, 30, 30);  
  }
}

// Dibujar los minutos agregando una bola por cada minuto transcurrido
void drawMinutes(int m) {
  fill(100, 200, 255);  

  // Posiciones para los 60 minutos en un círculo
  int[][] posiciones = {
    {350, 180}, {380, 190}, {410, 210}, {430, 230}, {450, 260}, {470, 290}, 
    {480, 320}, {490, 350}, {480, 380}, {470, 410}, {450, 440}, {430, 470}, 
    {410, 490}, {380, 510}, {350, 520}, {320, 510}, {290, 490}, {270, 470}, 
    {250, 440}, {230, 410}, {220, 380}, {210, 350}, {220, 320}, {230, 290}, 
    {250, 260}, {270, 230}, {290, 210}, {320, 190}, {350, 180}, {380, 190}, 
    {410, 210}, {430, 230}, {450, 260}, {470, 290}, {480, 320}, {490, 350}, 
    {480, 380}, {470, 410}, {450, 440}, {430, 470}, {410, 490}, {380, 510}, 
    {350, 520}, {320, 510}, {290, 490}, {270, 470}, {250, 440}, {230, 410}, 
    {220, 380}, {210, 350}, {220, 320}, {230, 290}, {250, 260}, {270, 230}, 
    {290, 210}, {320, 190}, {350, 180}, {380, 190}, {410, 210}, {430, 230}
  };

  // Dibujar una bola por cada minuto transcurrido en la hora
  for (int i = 0; i < m; i++) {  
    int x = posiciones[i][0];
    int y = posiciones[i][1];
    ellipse(x, y, 8, 8); // Tamaño reducido para que encajen mejor
  }
}
