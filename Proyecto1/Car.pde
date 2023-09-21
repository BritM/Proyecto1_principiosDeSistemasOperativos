class Car {
  int ID;
  PVector pos;
  boolean done;

  Car() {
  };

  Car(float x, float y, int pID) {
    pos = new PVector(x, y);
    ID = pID;
    done = false;
  }

  void updatePos(float px, float py) {
    pos.x = px;
    pos.y = py;
  }

  void display() {
    fill(#F8FF4B);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 40, 40);
  }

  void finish() {
    done = true;
  }

  boolean isDone() {
    return done;
  }
}
