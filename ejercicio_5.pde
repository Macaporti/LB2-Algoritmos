int h; 
int m; 
int s; 

String timeString; 

void setup(){
  size(500, 500);
  textAlign(CENTER, CENTER);
  textSize(40);
}
void draw(){
  h = hour();
  m = minute();
  s = second();
  
  timeString = nf(h, 2) + ":" + nf(m, 2) + ":" + nf(s, 2);
  
  background(0);
  text(timeString, width/2, height/2);
}
