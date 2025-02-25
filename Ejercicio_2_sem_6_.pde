int x = 0;
int y = 50;

float rad;
float level; 

void setup() {
  size(800,800);
  background(255);
}

void draw(){
  //valor provisional
  level = random (0, 1);
  //tamano de los circulos 
  rad = (level * width/2);
  
  // actividad en clase; CAMBIAR EL CODIGO PARA USAR FOR LOOP 
  for(int x =0; x < width; x++) {}
  
  if(y < height) {
    fill(120, 20, 102, 50);
    //color aleatorio
    stroke(random(0, 100), random(100, 255), random(200, 255));
    
    ellipse(x, y, rad, rad);
    delay(100);
    //x = x + 50
    x += 50;
    
    if(x > width) {
      x = 0;
      y = y + 50;
    }
  }else{
    noLoop();
  }
}
