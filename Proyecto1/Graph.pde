class Graph {
  ArrayList<Node> nodes;
  ArrayList<Conexion> links;

  Graph() {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Conexion>();
  }
  
  void update() {
  }

  void display() {
    
    
    for (Conexion c: links){
      c.display();
    }
    
    for (Node n: nodes){
      n.display();
    }
    
  }
  
  void addNode(float x, float y, float alph){
    Node a = new Node(x,y,alph);
    nodes.add(a);
  }
  
  void addConexion(PVector n1, PVector n2,int d){
    Conexion a = new Conexion(n1,n2,d);
    links.add(a);
  }
  
  boolean isOnNode(float x, float y){
    boolean res = false;
    for(Node n: nodes){
      if (dist(x,y,n.pos.x,n.pos.y) < 22){
        res = true;
      }
    }
    return res;
  }
  
  int closestNodeID(float x, float y){
    int index =0;
    PVector closest = nodes.get(0).pos.copy();
    for(int i =0; i < nodes.size(); i++){
      if (dist(x,y, nodes.get(i).pos.x, nodes.get(i).pos.y) < dist(x,y,closest.x,closest.y)){
        closest = nodes.get(i).pos.copy();
        index = i;
      }
    }
    return index;
  }
  
  PVector getNodePos(int id){
    return nodes.get(id).pos;
  }
  
  int getNodeID(PVector ppos){
    int res = -1;
    for(int i =0; i < nodes.size(); i++){
      if (nodes.get(i).pos == ppos){
        res = i;
      }
    }
    return res;
  }
  
  int nodeCount(){
    return nodes.size();
  }
  
  void selectNode(int id){
    nodes.get(id).setLineColor(#FF352E);
  }
  
  void deselectNode(int id){
    nodes.get(id).setLineColor(0);
  }

}
