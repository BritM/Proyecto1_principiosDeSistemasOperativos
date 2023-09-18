class Graph {
  int IDCount;
  ArrayList<Node> nodes;
  ArrayList<Conexion> links;
  ArrayList<Car> cars;

  Graph() {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Conexion>();
    cars = new ArrayList<Car>();
    IDCount = 0;
  }

  void update() {
  }

  void display() {
    for (Conexion c : links) {
      c.display();
    }
    for (int i = 0; i < nodes.size(); i++) {
      Node n = nodes.get(i);
      n.display(i);
    }
    
    for (Car ca : cars){
      ca.display();
    }
  }

  void addNode(float x, float y, float alph) {
    Node a = new Node(x, y, alph);
    nodes.add(a);
  }

  void addConexion(PVector n1, PVector n2, int d) {
    Conexion a = new Conexion(n1, n2, d);
    links.add(a);
  }
  
  void addCar(ArrayList<Conexion> paths, ArrayList<Node> stops){
    PVector start = stops.get(0).pos.copy();
    println(start);
    Car f1 = new Car(start.x,start.y,IDCount);
    cars.add(f1);
    IDCount++;
    CarThread thread_f1 = new CarThread(paths, stops, f1);
    thread_f1.start();
    
  }

  boolean isOnNode(float x, float y) {
    boolean res = false;
    for (Node n : nodes) {
      if (dist(x, y, n.pos.x, n.pos.y) < 22) {
        res = true;
      }
    }
    return res;
  }

  int closestNodeID(float x, float y) {
    int index =0;
    PVector closest = nodes.get(0).pos.copy();
    for (int i =0; i < nodes.size(); i++) {
      if (dist(x, y, nodes.get(i).pos.x, nodes.get(i).pos.y) < dist(x, y, closest.x, closest.y)) {
        closest = nodes.get(i).pos.copy();
        index = i;
      }
    }
    return index;
  }

  PVector getNodePos(int id) {
    return nodes.get(id).pos;
  }
  
  Node getNode(int id) {
    return nodes.get(id);
  }

  int getNodeID(PVector ppos) {
    int res = -1;
    for (int i =0; i < nodes.size(); i++) {
      if (nodes.get(i).pos == ppos) {
        res = i;
      }
    }
    return res;
  }
  
   Conexion getConexionByNodes(PVector a, PVector b){
     int index = 0;
     boolean found = false;
     Conexion con = null;
     for (Conexion co : links){
       PVector startNode = co.start;
       PVector endNode = co.end;
       
       if ((startNode.equals(a) && endNode.equals(b)) ||
          (startNode.equals(b) && endNode.equals(a))) {
          con = co;
          break;
        }
     }
     return con;
   }

  int nodeCount() {
    return nodes.size();
  }

  void selectNode(int id) {
    nodes.get(id).setLineColor(#FF352E);
  }

  void deselectNode(int id) {
    nodes.get(id).setLineColor(0);
  }
}
