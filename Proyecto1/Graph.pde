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

  void demo(){
    Node a = new Node(300, 300 ,0.1);
    nodes.add(a);
    
    Node b = new Node(600, 300 ,0.2);
    nodes.add(b);
    
    Node c = new Node(210, 500 ,0.3);
    nodes.add(c);
    
    Node d = new Node(360, 710 ,0.4);
    nodes.add(d);
    
    Node e = new Node(400, 500 ,0.5);
    nodes.add(e);
    
    Node f = new Node(700, 600 ,0.6);
    nodes.add(f);
    
    PVector pa = new PVector(300,300);
    PVector pb = new PVector(600, 300);
    PVector pc = new PVector(210, 500);
    PVector pd = new PVector(360, 710);
    PVector pe = new PVector(400, 500);
    PVector pf = new PVector(700, 600);
    
    Conexion ca = new Conexion(pa,pb,2);
    links.add(ca);
    
    Conexion cb = new Conexion(pa,pc,3);
    links.add(cb);
    
    Conexion cc = new Conexion(pb,pf,3);
    links.add(cc);

    Conexion cd = new Conexion(pc,pd,1);
    links.add(cd);
    
    Conexion ce = new Conexion(pd,pf,4);
    links.add(ce);
    
    Conexion cf = new Conexion(pa,pe,2);
    links.add(cf);
    
    Conexion cg = new Conexion(pe,pf,2);
    links.add(cg);

  }

}
