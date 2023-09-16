class Node {
  PVector pos;
  float alpha;
  boolean selected;
  color s;


  Node(float x, float y, float alph) {
    pos = new PVector(x, y);
    alpha = alph;
    selected = false;
    s =0;
    
  }
  
  void update() {
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(#00F4FF);
    strokeWeight(1);
    stroke(s);
    ellipseMode(CENTER);
    textAlign(CENTER,CENTER);
    ellipse(0, 0, 40, 40);
    fill(0);
    text(nf(alpha, 0, 2), 0,0);
    popMatrix();
  }
  
  void setLineColor(color c){
    s =c;
  }

}
