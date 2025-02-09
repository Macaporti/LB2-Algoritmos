// distancia entre cada celda 
int distancia = 80;

void setup() {
  // Tamaño del lienzo
  size(600, 500);
  
  // teselado otra manera
  drawTessellation();
}

//  estructura diferente
void drawTessellation() {
  // bucles for() recorrer  la pantalla en filas y columnas
  for (int i = 0; i < width; i += distancia) {
    for (int j = 0; j < height; j += distancia) {
      
      //  dibujar una nueva tesela en cada posición
      drawTile(i, j);
    }
  }
}

//  círculos y líneas cruzadas
void drawTile(int x, int y) {
  // Color de la tesela con variación para dar efecto visual
  fill(#94AFFF);
  stroke(#D40047);
  rect(x, y, distancia, distancia);
  
  // círculo centro 
  fill(#1500FF);
  ellipse(x + distancia / 2, y + distancia / 2, distancia / 2, distancia / 2);
  
  // líneas cruzadas
  stroke(255);
  strokeWeight(5);
  line(x, y, x + distancia, y + distancia);
  line(x + distancia, y, x, y + distancia);
  

}
