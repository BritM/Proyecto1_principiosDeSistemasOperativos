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
    strokeWeight(15);
    fill(#404040);
    line(start.x, start.y, end.x, end.y);
    fill(0);
    PVector a = start.copy();
    PVector b = end.copy();
    PVector t = (b.sub(a).div( 2 ).add(a));
    stroke(0);
    textAlign(LEFT, BOTTOM);
    text(distance, t.x+10, t.y-10);
  }

}
