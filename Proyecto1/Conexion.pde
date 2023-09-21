class Conexion {
  PVector start;
  PVector end;
  int distance;

  Conexion() {
  }

  Conexion(PVector n1, PVector n2, int n) {
    start = n1;
    end = n2;
    distance = n;
  }

  void update() {
  }
  
  int getDistance(){
    return distance;
  }

  void display() {
    // Borde de carretera
    strokeWeight(20);
    fill(0);
    stroke(0);
    line(start.x, start.y, end.x, end.y);

    // Carretera
    strokeWeight(14);
    stroke(#76757D);
    line(start.x, start.y, end.x, end.y);

    // Marcas viales divisorias
    boolean drawLine = true;
    float laneMarkings = 12;
    strokeWeight(2);
    stroke(#E6EAE7);

    for (float t = 0; t < dist(start.x, start.y, end.x, end.y); t += laneMarkings) {
      if (drawLine) {
        float x1 = lerp(start.x, end.x, t / dist(start.x, start.y, end.x, end.y));
        float y1 = lerp(start.y, end.y, t / dist(start.x, start.y, end.x, end.y));
        float x2 = lerp(start.x, end.x, (t + laneMarkings) / dist(start.x, start.y, end.x, end.y));
        float y2 = lerp(start.y, end.y, (t + laneMarkings) / dist(start.x, start.y, end.x, end.y));
        line(x1, y1, x2, y2);
      }
      drawLine = !drawLine;
    }

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
    float textWidthHalf = textWidth(textToDisplay) / 2;
    float textHeightHalf = textAscent() / 2;
    text(textToDisplay, 0 - textWidthHalf, 0 + textHeightHalf);

    popMatrix();
  }
}
