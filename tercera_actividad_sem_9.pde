int a;
int remanente; 
boolean esPar;

void setup(){
  a = 8;
  remanente = a % 2;
}

void draw() {
  if(remanente == 0){
  print("El numero es par");
  rect (10, 10, 10, 10); 
  }else if (remanente !=0){
    print("el remanente es Impar");
ellipse(10, 10, 10, 10);
  }
}
