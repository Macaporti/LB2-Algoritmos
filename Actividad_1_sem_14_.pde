Table table;
int nSamples;
float[] appUsageTime;
float[] screenOnTime;

void setup() {
  size(1000, 1000);
  background(0);
  
  // Cargar los datos
  table = loadTable("user_behavior_dataset.csv", "header");

  // Guardar el número de filas en la tabla
  nSamples = table.getRowCount();

  // Inicializamos los arrays
  appUsageTime = new float[nSamples];
  screenOnTime = new float[nSamples];

  // Asignamos los datos
  for (int i = 0; i < nSamples; i++) {
    TableRow row = table.getRow(i);
    appUsageTime[i] = row.getFloat("App Usage Time (min/day)");
    screenOnTime[i] = row.getFloat("Screen On Time (hours/day)");
  }
}


void draw(){
  background(0);
  
  for(int i = 0; i < nSamples; i++) {
    //value            start 1    stop1           start2    stop2 
   float x = map(appUsageTime [i], 0,      max(appUsageTime), 0,  width);
   float y = map(screenOnTime[i], 0,       max(screenOnTime), 0, height);
    
    float rectWidth = 10; 
    float rectHeight = 10;
    
    fill(random(100, 255), random(0, 100), random(50, 80));
    noStroke();
    ellipse(x, y, rectWidth, rectHeight);
  }
}
