class Car {
  int ID;
  PVector pos;
  boolean done;
  float speed;
  
  Car() {
  };

  Car(float x, float y, int pID) {
    pos = new PVector(x, y);
    ID = pID;
    done = false;
    speed = 0.0;
  }

  void updatePos(float px, float py) {
    pos.x = px;
    pos.y = py;
  }

  void display() {
    fill(#821414);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 26, 26);
  }

  void finish() {
    done = true;
  }

  boolean isDone() {
    return done;
  }
}
