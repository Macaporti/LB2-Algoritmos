//Este código se realizó de acuerdo a unos datos proporcionados en la página dada 
//en clase. Igualmente, se desarrolló el código teniendo en cuenta lo aprendido 
//en clase. Es interesante observar cómo se pueden ver los datos de manera diferente,
//dependiendo de cómo se deseen organizar. Asimismo, como se acordó con el profesor, 
//se tomó la decisión de abordar los datos de diferentes formas para que el resultado 
//fuera distinto, ya que la actividad se logró terminar al final de la clase. Se intentó
//abarcar otras formas, pero al ser los datos tan precisos, fue difícil tener en cuenta 
//las otras páginas sugeridas. Sin embargo, quedé satisfecho con el resultado y con lo 
//aprendido en esta clase; siento que fue diferente a cualquier otra clase de diseño.

// Variable table para almacenar los datos cargados desde el archivo emails.csv
Table table;
// Cantidad de filas (correos) en la tabla, número de datos que se van a graficar.
int nSamples;
// Variables del archivo seleccionadas
float[] wordTo;
float[] wordEnron;

void setup() {
  // Tamaño de la ventana
  size(800, 800);

  // Cargar el archivo que debe estar descargado en el computador
  table = loadTable("emails.csv", "header");

  // Calcular las filas que deben haber (emails) en la tabla y asignarlas a nSamples
  nSamples = table.getRowCount();

  // Inicializar los arreglos para almacenar los datos de cada fila
  wordTo = new float[nSamples];
  wordEnron = new float[nSamples];

  // Recorrer todas las filas del archivo CSV y extraer los valores para wordTo y wordEnron
  for (int i = 0; i < nSamples; i++) {
    TableRow row = table.getRow(i);
    // Extraer el valor numérico de la palabra "to"
    wordTo[i] = row.getFloat("to");
    // Extraer el valor numérico de "enron"
    wordEnron[i] = row.getFloat("enron");
  }
}

void draw() {
  // Color de fondo lila
  background(#AE9BC2);

  // Bucle para recorrer todos los correos (todos los puntos que se van a graficar)
  for (int i = 0; i < nSamples; i++) {
    // Ubicación de los datos
    float x = map(wordTo[i], 0, max(wordTo), 0, width);
    float y = map(wordEnron[i], 0, max(wordEnron), height, 0); // Mantener los valores en la parte inferior

    // No delinear las figuras
    noStroke();

    // Si ambos valores son mayores a 5: se dibuja un cuadrado azul.
    if (wordTo[i] > 5 && wordEnron[i] > 5) {
      // Color azul aleatorio con transparencia (180 de 255).
      fill(random(0, 100), random(100, 200), random(200, 255), 180);
      rect(x, y, 10, 10); // Dibujar un cuadrado en la posición.

    // Si solo wordTo es alto: se dibuja un círculo morado.
    } else if (wordTo[i] > 5 && wordEnron[i] <= 5) {
      // Color morado aleatorio.
      fill(random(100, 200), random(0, 50), random(150, 255), 180);
      ellipse(x, y, 10, 10); // Dibujar el círculo.

    // Si solo wordEnron es alto: se dibuja un triángulo rosado.
    } else if (wordTo[i] <= 5 && wordEnron[i] > 5) {
      // Color rosado aleatorio.
      fill(random(200, 255), random(100, 150), random(150, 200), 180);
      triangle(x, y - 5, x - 5, y + 5, x + 5, y + 5); // Dibujar el triángulo.
    }
  }
}
