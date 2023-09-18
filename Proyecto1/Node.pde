class Node {
  PVector pos;
  float alpha;
  boolean selected;
  color s;
  boolean isOccupied;


  Node(float x, float y, float alph) {
    pos = new PVector(x, y);
    alpha = alph;
    selected = false;
    s =0;
  }

  void update() {
  }

  void display(int index) {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(#59B32D);
    strokeWeight(3);
    stroke(s);
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);
    ellipse(0, 0, 70, 70);
    fill(0);
    text("Nodo " + index, 0, -10);
    text(nf(alpha, 0, 2), 0, 10);
    popMatrix();
  }

  void setLineColor(color c) {
    s =c;
  }
  
  synchronized void setOccupied(boolean status){
    isOccupied = status;
  }
  
  boolean isOccupied(){
    return isOccupied;
  }
}
