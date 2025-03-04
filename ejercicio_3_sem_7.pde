int x = 0;
int y = 50;
float rad;
float level;

import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
FFT fft;

void setup() {
  size (800, 800);
  background (0);
  frameRate(60);
  
  minim = new Minim(this);
  player = minim.loadFile("time.mp3", 1024);
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
}

void draw() {
  fft.forward(player.mix);
  level = fft.getBand(10);
  
  // Definir tamaño del cuadrado basado en el nivel del sonido
  rad = (level * width / 5);
  
  float r = random(100, 100);
  float g = random(150, 180);
  float b = random(255, 100);
  stroke(r, g, b);
  fill(255, 10);
  
 
  square(x, y, rad);
  
  println(width);
  x++;

  // Controla lo que pasa cuando se llega al borde derecho
  if (x > width) {
    x = 0;
    y += 80;
  }

  // Controla lo que pasa cuando se llega al borde inferior
  if (y > height) {
    y = 0;
    background(0);
  }
}
