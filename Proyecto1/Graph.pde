//import random; //<>// //<>//
import java.util.concurrent.Semaphore;
import java.util.Iterator;
class Graph {
  int IDCount;
  ArrayList<Node> nodes;
  ArrayList<Conexion> links;
  ArrayList<Car> cars;
  Semaphore ncarros;

  Graph() {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Conexion>();
    cars = new ArrayList<Car>();
    IDCount = 0;
    ncarros = new Semaphore(nVehicles);
  }

  void update() {
  }

  float getAverageSpeed() {
    if (cars.isEmpty()) {
      return 0;
    }
    float averageSpeed = 0;
    for (Car c : cars) {
      averageSpeed += c.speed;
    }
    return averageSpeed / cars.size();
  }

  void removeNode(Node nodeToRemove) {
    Iterator<Conexion> linkIterator = links.iterator();
    while (linkIterator.hasNext()) {
      Conexion link = linkIterator.next();
      if (link.start.equals(nodeToRemove.pos) || link.end.equals(nodeToRemove.pos)) {
        linkIterator.remove();
      }
    }

    nodes.remove(nodeToRemove);
  }

  void display() {
    
    
    for (Conexion c : links) {
      c.display();
    }
    for (int i = 0; i < nodes.size(); i++) {
      Node n = nodes.get(i);
      n.display(i);
    }


    for (int j = 0; j < cars.size(); j++) {
      if (cars.get(j).isDone()) {
        cars.remove(j);
      } else {
        cars.get(j).display();
      }
    }
  }

  void addNode(float x, float y, float alph) {
    Node a = new Node(x, y, alph);
    nodes.add(a);
  }

  void addConexion(PVector n1, PVector n2, int d) {
    for (Conexion existingConexion : links) {
      if ((existingConexion.start.equals(n1) && existingConexion.end.equals(n2)) ||
        (existingConexion.start.equals(n2) && existingConexion.end.equals(n1))) {
        existingConexion.distance = d;
        return;
      }
    }
    Conexion a = new Conexion(n1, n2, d);
    links.add(a);
  }


  void addCar(ArrayList<Conexion> paths, ArrayList<Node> stops) {
    PVector start = stops.get(0).pos.copy();

    Car f1 = new Car(start.x, start.y, IDCount);
    synchronized (cars) {
      cars.add(f1);
    }
    IDCount++;
    CarThread thread_f1 = new CarThread(paths, stops, f1);
    thread_f1.start();
  }


  boolean isOnNode(float x, float y) {
    boolean res = false;
    for (Node n : nodes) {
      if (dist(x, y, n.pos.x, n.pos.y) < 90
        ) {
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

  Conexion getConexionByNodes(PVector a, PVector b) {
    Conexion con = null;
    for (Conexion co : links) {
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

  ArrayList<Integer> dijkstra(int startNode, int endNode) {
    int numNodes = nodes.size();
    float[] distance = new float[numNodes];
    int[] previousNode = new int[numNodes];
    boolean[] visited = new boolean[numNodes];

    // Inicializa las distancias como infinito y marca todos los nodos como no visitados
    for (int i = 0; i < numNodes; i++) {
      distance[i] = Float.POSITIVE_INFINITY;
      previousNode[i] = -1;
      visited[i] = false;
    }

    distance[startNode] = 0;


    for (int i = 0; i < numNodes; i++) { // Encuentra el camino más corto
      int minDistanceNode = -1;
      for (int j = 0; j < numNodes; j++) { // Encuentra el nodo no visitado con la distancia mínima
        if (!visited[j] && (minDistanceNode == -1 || distance[j] < distance[minDistanceNode])) {
          minDistanceNode = j;
        }
      }

      visited[minDistanceNode] = true;

      // Actualiza las distancias de los nodos vecinos
      for (int j = 0; j < numNodes; j++) {
        if (!visited[j] && linksExist(minDistanceNode, j)) {
          float edgeDistance = getEdgeDistance(minDistanceNode, j);
          if (distance[minDistanceNode] + edgeDistance < distance[j]) {
            distance[j] = distance[minDistanceNode] + edgeDistance;
            previousNode[j] = minDistanceNode;
          }
        }
      }
    }

    // Reconstruye el camino mínimo desde el nodo de inicio al nodo final
    ArrayList<Integer> shortestPath = new ArrayList<Integer>();
    int currentNode = endNode;
    while (currentNode != -1) {
      shortestPath.add(currentNode);
      currentNode = previousNode[currentNode];
    }

    Collections.reverse(shortestPath);

    // Imprime las información
    //println("Camino más corto desde el nodo " + startNode + " al nodo " + endNode + ":");
    for (int i = 0; i < shortestPath.size() - 1; i++) {
      int fromNode = shortestPath.get(i);
      int toNode = shortestPath.get(i + 1);
      //println("Nodo " + fromNode + " a Nodo " + toNode);
    }

    //println("Distancia total: " + distance[endNode]);

    return shortestPath;
  }

  boolean linksExist(int node1, int node2) {
    for (Conexion c : g.links) {
      PVector start = c.start;
      PVector end = c.end;
      int node1ID = g.getNodeID(start);
      int node2ID = g.getNodeID(end);
      if ((node1ID == node1 && node2ID == node2) || (node1ID == node2 && node2ID == node1)) {
        return true;
      }
    }
    return false;
  }

  float getEdgeDistance(int node1, int node2) {
    for (Conexion c : g.links) {
      PVector start = c.start;
      PVector end = c.end;
      int node1ID = g.getNodeID(start);
      int node2ID = g.getNodeID(end);
      if ((node1ID == node1 && node2ID == node2) || (node1ID == node2 && node2ID == node1)) {
        return c.distance;
      }
    }
    return Float.POSITIVE_INFINITY;
  }

  void spawnCar(Node node) {

    ArrayList<Integer> possible_choices = new ArrayList<>();
    for (int i = 0; i < nodes.size(); i++) {
      if (! nodes.get(i).equals(node)) {
        possible_choices.add(i);
      }
    }

    Collections.shuffle(possible_choices);
    int indexn = possible_choices.get(0);
    Node target = nodes.get(indexn);

    int targetID = getNodeID(target.pos);
    int originID = getNodeID(node.pos);
    ArrayList<Integer> route = dijkstra(originID, targetID);

    ArrayList<Node> stops = new ArrayList();
    ArrayList<Conexion> paths = new ArrayList();

    for (int i : route) {
      stops.add(getNode(i));
    }
    //println(stops.size());
    for (int j = 1; j < stops.size(); j++) {
      paths.add(getConexionByNodes(stops.get(j-1).pos, stops.get(j).pos));
    }
    addCar(paths, stops);
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
