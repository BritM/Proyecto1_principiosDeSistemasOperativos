class Car {
  int ID;
  PVector pos;
  
  Car(){};

  Car(float x, float y, int pID) {
    pos = new PVector(x, y);
    ID = pID;
  }
  
  void updatePos(float px, float py){
    pos.x = px;
    pos.y = py;
  }
  
  void display(){
    fill(#F8FF4B);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 40, 40);
  }
}
