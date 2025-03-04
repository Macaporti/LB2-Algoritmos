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
  background (0) ;
  frameRate(800);
  
  minim= new Minim(this);
  player= minim.loadFile("time.mp3", 1024);
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
}

void draw() {
  fft.forward(player.mix);
  level = fft.getBand(10);
  //variable provisional
  rad=(level* width/10);
  
  float r = random(0, 100);
  float g = random (100, 255);
  float b = random (200, 255);
  
  stroke(r, g, b);
  fill(255, 10);
  ellipse(x, y, rad, rad);
  println(width);
  x++;

  //Controla lo que pasa cuando se llega al borde derecho
  if (x > width) {
    x = 0;
    y += 80;
  }

  //Controla lo que pasa cuando se llega l borde inferior
  if (y > height) {
    y = 0;
    background (0) ;
  }
}
