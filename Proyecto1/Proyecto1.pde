import controlP5.*; //<>//
import java.util.Collections;

ControlP5 cp5;

String textValue = "";
int input;

Graph g;

float mx;
float my;

int lineStart;

void setup() {
  size(1400, 800);

  cp5 = new ControlP5(this);
  input = 0;
  g = new Graph();

  PVector posText = new PVector(913, 2);
  PVector sizeText = new PVector(239, 47);

  //addCoordenate(3, 1);
  cp5.addTextfield("alpha")
    .setPosition(posText.x, posText.y)
    .setSize((int)sizeText.x, (int)sizeText.y)
    .setFont(createFont("arial", 20))
    .setFocus(true)
    .setColor(color(#FCFEFF));
  cp5.get(Textfield.class, "alpha").hide();

  cp5.addTextfield("distance")
    .setPosition(posText.x, posText.y)
    .setSize((int)sizeText.x, (int)sizeText.y)
    .setFont(createFont("arial", 20))
    .setFocus(true)
    .setColor(color(#FCFEFF));
  cp5.get(Textfield.class, "distance").hide();

  textFont(createFont("arial", 15));

  Control();
  //g.demo();
  crearNodos();
  crearConexiones();
}
void crearNodos() {
  float[] coordenadasX = {255.0, 646.0, 959.0, 745.0, 246.0, 612.0, 1000.0};
  float[] coordenadasY = {258.0, 566.0, 334.0, 165.0, 550.0, 355.0, 600.0};

  for (int i = 0; i < coordenadasX.length; i++) {
    float x = coordenadasX[i];
    float y = coordenadasY[i];
    float alpha = random(0.1, 0.6);
    g.addNode(x, y, alpha);
  }
}

void draw() {
  background(#456975);

  repaintBoxControl(boxCoordenates);

  if (!isOff) {
    elapsedTime = millis() - startTime;
    timeExecution = String.format("%.2f", elapsedTime / 1000.0);
    timerLabel.setText("TIEMPO DE SIMULACIoN: " + timeExecution);
  }
  nVehicles = (int) nVehiclesSlider.getValue();

  g.display();
}

void crearConexiones() {
  //Conexión nodo 0
  g.addConexion(g.getNodePos(0), g.getNodePos(3), 3);
  g.addConexion(g.getNodePos(0), g.getNodePos(4), 4);
  g.addConexion(g.getNodePos(0), g.getNodePos(1), 3);

  // Conexión nodo 3
  g.addConexion(g.getNodePos(3), g.getNodePos(5), 1);
  g.addConexion(g.getNodePos(3), g.getNodePos(2), 2);

  // Conexión nodo 2
  g.addConexion(g.getNodePos(2), g.getNodePos(1), 8);
  g.addConexion(g.getNodePos(2), g.getNodePos(6), 8);

  // Conexión nodo 1
  g.addConexion(g.getNodePos(1), g.getNodePos(4), 8);
  g.addConexion(g.getNodePos(1), g.getNodePos(5), 2);
  g.addConexion(g.getNodePos(1), g.getNodePos(6), 2);
}

void mousePressed() {
  boolean inBox = mouseX > 30 && mouseX < width-20 && mouseY > 132 && mouseY < height-38 ;
  if (mouseButton == LEFT  && inBox) {
    if (input == 0) {
      mx = mouseX;
      my = mouseY;
      if (!g.isOnNode(mx, my)) {
        cp5.get(Textfield.class, "alpha").show();
        input = 1;
      }
    } else if (input == 2) {
      g.deselectNode(lineStart);
      input = 0;
    }
  } else if (mouseButton == RIGHT) {


    if (g.isOnNode(mx, my) && g.nodeCount() >= 2 && input !=3) {
      mx = mouseX;
      my = mouseY;
      if (input == 0) {
        input = 2;
        lineStart = g.closestNodeID(mx, my);
        g.selectNode(lineStart);
      } else if (input == 2) {
        if (g.closestNodeID(mx, my) != lineStart) {
          g.deselectNode(lineStart);
          cp5.get(Textfield.class, "distance").show();
          input = 3;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == ENTER ) {
    if (input == 1) {
      String message = cp5.get(Textfield.class, "alpha").getText();
      if (message.matches("[-+]?[0-9]*\\.?[0-9]+")) {
        float alph = float(message);

        cp5.get(Textfield.class, "alpha").clear();
        cp5.get(Textfield.class, "alpha").hide();
        g.addNode(mx, my, alph);
        input=0;
      }
    } else if (input == 3) {
      int d = int(cp5.get(Textfield.class, "distance").getText());
      cp5.get(Textfield.class, "distance").clear();
      cp5.get(Textfield.class, "distance").hide();
      PVector n1 = g.getNodePos(lineStart);
      int n2ID = g.closestNodeID(mx, my);
      PVector n2 = g.getNodePos(n2ID);
      g.addConexion(n1, n2, d);
      input=0;
    }
  } else if (key == 'b' || key == 'B') {
    int startNode = int(random(0, g.nodeCount() - 1));
    int endNode;

    do {
      endNode = int(random(0, g.nodeCount() - 1));
    } while (endNode == startNode);

    // Le pone color al borde de los nodos destino y salida, azul y blanco respectivamente
    for (int i = 0; i < g.nodes.size(); i++) {
      if (i==startNode) {
        g.nodes.get(startNode).s = 255;
      } else if (i==endNode) {
        g.nodes.get(endNode).s = color(0, 0, 255);
      } else {
        g.nodes.get(i).s = 0;
      }
    }
    dijkstra(startNode, endNode);
  }
}

void dijkstra(int startNode, int endNode) {
  int numNodes = g.nodes.size();
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
  println("Camino más corto desde el nodo " + startNode + " al nodo " + endNode + ":");
  for (int i = 0; i < shortestPath.size() - 1; i++) {
    int fromNode = shortestPath.get(i);
    int toNode = shortestPath.get(i + 1);
    println("Nodo " + fromNode + " a Nodo " + toNode);
  }

  println("Distancia total: " + distance[endNode]);
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
