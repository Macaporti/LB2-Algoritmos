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
  frameRate(800);
  
  minim = new Minim(this);
  player = minim.loadFile("time.mp3", 1024);
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
}

void draw() {
  fft.forward(player.mix);
  level = fft.getBand(10);
  rad = (level * width / 10);
  
  float r = random(100, 200); // Tonos de morado
  float g = random(0, 100);
  float b = random(150, 255);
  
  stroke(r, g, b);
  fill(r, g, b, 150);
  
  float x1 = x;
  float y1 = y;
  float x2 = x + rad / 2;
  float y2 = y - rad;
  float x3 = x - rad / 2;
  float y3 = y - rad;
  
  triangle(x1, y1, x2, y2, x3, y3);
  
  x += rad / 2;

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
