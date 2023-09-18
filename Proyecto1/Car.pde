class Car {
  int ID;
  PVector pos;

  Car(float x, float y, int pID) {
    pos = new PVector(x, y);
    ID = pID;
  }
  
  void updatePos(float px, float py){
    x = px;
    y = py;
  }
  
  void display(){
    fill(#F8FF4B);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 40, 40);
  }
