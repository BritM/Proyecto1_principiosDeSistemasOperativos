class Conexion {
  PVector start;
  PVector end;
  int distance;


  Conexion(PVector n1, PVector n2, int n) {
    start = n1;
    end = n2;
    distance = n;
  }

  void update() {
  }

void display() {
  strokeWeight(14);
  stroke(0); // Color de línea
  line(start.x, start.y, end.x, end.y);
  fill(0);
  PVector a = start.copy();
  PVector b = end.copy();
  PVector t = (b.sub(a).div(2).add(a));
  stroke(0);
  textAlign(LEFT, BOTTOM);

  pushMatrix();
  translate(t.x, t.y);

  
  // Dibuja el cuadro
  PVector dir = PVector.sub(end, start); // Calcula el vector de dirección de la línea
  float angle = atan2(dir.y, dir.x); // Calcula el ángulo de rotación para que el rectángulo se alinee con la línea
  rotate(angle);
  strokeWeight(3);
  rectMode(CENTER);
  fill(#7EAEA3);
  rect(0, 0, 36, 36, 14);

  // Dibuja el texto en el centro del cuadro
  rotate(-angle); // Ajusta la rotación para que el texto siempre esté en un angulo correcto
  fill(0);
  String textToDisplay = "" + distance;
  //textSize(16);
  float textWidthHalf = textWidth(textToDisplay) / 2;
  float textHeightHalf = textAscent() / 2;
  text(textToDisplay, 0 - textWidthHalf, 0 + textHeightHalf);

  popMatrix();
}



}
