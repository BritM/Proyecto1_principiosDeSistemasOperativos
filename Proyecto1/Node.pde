import java.util.Timer;
import java.util.TimerTask;
class Node {
  PVector pos;
  float alpha;
  boolean selected;
  color s;
  Semaphore sema;
  Timer timer;


  Node(float x, float y, float alph) {
    pos = new PVector(x, y);
    alpha = alph;
    selected = false;
    s =0;
    sema = new Semaphore(1);
  }
  
  void startTimer(){
    print("Before timer start");
    timer = new Timer();
    NodeThread task = new NodeThread(this);
    timer.schedule(task, 0,  (long) (alpha*1000));
    print("After Timer start");
  }
  
  void stopTimer(){
    timer.cancel();
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
    ellipse(0, 0, 80, 80);
    fill(0);
    text("Nodo " + index, 0, -8);
    text(nf(alpha, 0, 2), 0, 12);
    popMatrix();
  }

  void setLineColor(color c) {
    s =c;
  }
}
