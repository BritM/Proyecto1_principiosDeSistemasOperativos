import controlP5.*; //<>//
import java.util.Collections;

ControlP5 cp5;

String textValue = "";
int input;

Graph g;

float mx;
float my;
boolean awaitingInput = false;
int lineStart;

ArrayList<Car> cars = new ArrayList<Car>();

void setup() {
  size(1200, 720);

  cp5 = new ControlP5(this);
  input = 0;
  g = new Graph();

  PVector posText = new PVector(width-487, 2);
  PVector sizeText = new PVector(239, 47);

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

  cp5.addTextlabel("waitInput")
    .setText("Esperando input...")
    .setPosition(width - 900, height/2 - 10)  // Ajusta la posición al centro
    .setFont(createFont("Arial", 40))
    .setColorValue(color(0));
  cp5.get(Textlabel.class, "waitInput").hide();

  textFont(createFont("arial", 15));

  Control();
  //g.demo();
  generateRandmonButtonClicked();
}

void draw() {
  background(#456975);

  repaintBoxControl();

  if (!isOff) {
    elapsedTime = millis() - startTime;
    timeExecution = String.format("%.2f", elapsedTime / 1000.0);
    timerLabel.setText("TIEMPO DE SIMULACIoN: " + timeExecution);
  }
  nVehicles = (int) nVehiclesSlider.getValue();
  g.display();
  if (awaitingInput) {
    fill(#453979, 200);
    stroke(0);
    strokeWeight(0);
    rectMode(CORNER);
    rect(0, 98, width, height);
    cp5.get(Textlabel.class, "waitInput").show();
  } else {
    cp5.get(Textlabel.class, "waitInput").hide();
  }
  if (!cars.isEmpty()) {
    for (Car c : cars) {
      c.display();
    }
  }
}


void mousePressed() {
  if (!isOff) {
    return;
  }
  boolean inBox = mouseX > 30 && mouseX < width-20 && mouseY > 132 && mouseY < height-38 ;
  if (mouseButton == LEFT  && inBox) {
    if (input == 0) {
      mx = mouseX;
      my = mouseY;
      if (!g.isOnNode(mx, my)) {
        awaitingInput = true;
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
        awaitingInput = true;
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
  if (keyCode == DELETE && input == 2) {
    input = 0;
    lineStart = g.closestNodeID(mx, my);
    g.deselectNode(lineStart);
    g.removeNode(g.nodes.get(lineStart));
  } else if (key == ENTER ) {
    if (input == 1) {
      String message = cp5.get(Textfield.class, "alpha").getText();
      if (message.matches("[-+]?[0-9]*\\.?[0-9]+")) {
        float alph = float(message);

        cp5.get(Textfield.class, "alpha").clear();
        cp5.get(Textfield.class, "alpha").hide();
        g.addNode(mx, my, alph);
        input=0;
        awaitingInput = false;
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
      awaitingInput = false;
    }
  }
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
