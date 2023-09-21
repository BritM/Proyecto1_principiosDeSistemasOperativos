import java.util.Arrays;

int nVehicles = 20;
long startTime, elapsedTime;
String timeExecution = "0";
Slider nVehiclesSlider;
Button offButton, resetButton, cleanGraph, generateRandmonButton;
Textlabel timerLabel, averageSpeedLabel;
ArrayList<PVector> boxCoordenates = new ArrayList<PVector>();
color baseColor = color(#2590CC);
boolean isOff = false;

void Control() {
  // Sliders
  nVehiclesSlider = cp5.addSlider("Cantidad de Carros")
    .setPosition(10, 15)
    .setRange(2, 50)
    .setValue(nVehicles)
    .setSize(124, 20)
    .setFont(createFont("arial", 15))
    .setNumberOfTickMarks(49)
    .snapToTickMarks(true);
  addCoordenate(0, 0);

  // Labels
  timerLabel = makeLabel("timerLabel", "TIEMPO DE SIMULACIóN: " + timeExecution, 1, 0, 339, 21);
  averageSpeedLabel = makeLabel("averageSpeedLabel", "VELOCIDAD PROMEDIO: 0 km/s", 1, 1, 339, 69);

  // Botones
  offButton = cp5.addButton("offButtonClicked")
    .setPosition(width - 123, 3)
    .setSize(120, 45);

  resetButton = cp5.addButton("resetButtonClicked")
    .setPosition(width - 123, 51)
    .setSize(120, 45)
    .setLabel("Reiniciar Simulacion");
  offButtonClicked();

  cleanGraph = cp5.addButton("cleanGraphClicked")
    .setPosition(width - 246, 3)
    .setSize(120, 45)
    .setLabel("Limpiar Mapa")
    .setColorBackground(color(#247451))
    .setColorForeground(color(#30AC58))
    .setColorActive(color(#5ADC70));

  generateRandmonButton = cp5.addButton("generateRandmonButtonClicked")
    .setPosition(width - 246, 51)
    .setSize(120, 45)
    .setLabel("Nodos Predifinidos")
    .setColorBackground(color(#247451))
    .setColorForeground(color(#30AC58))
    .setColorActive(color(#5ADC70));
}

void cleanGraphClicked() {
  g = new Graph();
}

void dPrintConnections() {
  for (Conexion c : g.links) {
    int node1ID = g.getNodeID(c.start);
    int node2ID = g.getNodeID(c.end);
    println(String.format("g.addConexion(g.getNodePos(%d), g.getNodePos(%d), (int) random(10, 200));", node1ID, node2ID));
  }
}

void dPrintNodes() {
  StringBuilder coordenadasX = new StringBuilder("{");
  StringBuilder coordenadasY = new StringBuilder("{");

  for (Node n : g.nodes) {
    coordenadasX.append(n.pos.x).append(", ");
    coordenadasY.append(n.pos.y).append(", ");
  }

  // Eliminar la coma y el espacio al final de las cadenas
  coordenadasX.delete(coordenadasX.length() - 2, coordenadasX.length());
  coordenadasY.delete(coordenadasY.length() - 2, coordenadasY.length());

  // Agregar el cierre de los arreglos
  coordenadasX.append("};");
  coordenadasY.append("};");

  // Imprimir las cadenas resultantes
  println(coordenadasX.toString());
  println(coordenadasY.toString());
  //println("AUXgenerateRandmonButtonClicked(coordenadasX, coordenadasY);");
}

void AUXgenerateRandmonButtonClicked(ArrayList<Float> coordenadasX, ArrayList<Float> coordenadasY) {
  for (int i = 0; i < coordenadasX.size(); i++) {
    float x = coordenadasX.get(i);
    float y = coordenadasY.get(i);
    float alpha = random(0.1, 0.6);
    g.addNode(x, y, alpha);
  }
}

void generateRandmonButtonClicked() {
  //dPrintNodes();
  //println();
  //dPrintConnections();

  g = new Graph();
  ArrayList<Float> coordenadasX;
  ArrayList<Float> coordenadasY;
  switch(int(random(4))) {
  case 0:
    coordenadasX = new ArrayList<Float>(Arrays.asList(255.0, 646.0, 959.0, 745.0, 246.0, 612.0, 1000.0));
    coordenadasY = new ArrayList<Float>(Arrays.asList(258.0, 566.0, 334.0, 165.0, 550.0, 355.0, 600.0));
    AUXgenerateRandmonButtonClicked(coordenadasX, coordenadasY);

    g.addConexion(g.getNodePos(0), g.getNodePos(3), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(1), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(2), g.getNodePos(1), (int) random(10, 200));
    g.addConexion(g.getNodePos(2), g.getNodePos(6), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(6), (int) random(10, 200));
    break;
  case 1:
    coordenadasX = new ArrayList<Float>(Arrays.asList(109.0, 144.0, 446.0, 839.0, 578.0, 937.0, 1079.0, 837.0, 687.0));
    coordenadasY = new ArrayList<Float>(Arrays.asList(178.0, 451.0, 250.0, 417.0, 575.0, 180.0, 609.0, 678.0, 271.0));
    AUXgenerateRandmonButtonClicked(coordenadasX, coordenadasY);

    g.addConexion(g.getNodePos(1), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(1), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(4), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(8), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(4), g.getNodePos(3), (int) random(10, 200));
    g.addConexion(g.getNodePos(6), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(7), (int) random(10, 200));
    g.addConexion(g.getNodePos(7), g.getNodePos(6), (int) random(10, 200));
    g.addConexion(g.getNodePos(8), g.getNodePos(3), (int) random(10, 200));
    break;
  case 2:
    coordenadasX = new ArrayList<Float>(Arrays.asList(153.0, 757.0, 201.0, 513.0, 820.0, 532.0, 1095.0, 467.0));
    coordenadasY = new ArrayList<Float>(Arrays.asList(202.0, 198.0, 563.0, 300.0, 472.0, 613.0, 276.0, 450.0));
    AUXgenerateRandmonButtonClicked(coordenadasX, coordenadasY);

    g.addConexion(g.getNodePos(1), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(6), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(5), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(4), g.getNodePos(6), (int) random(10, 200));
    g.addConexion(g.getNodePos(5), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(0), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(1), (int) random(10, 200));
    g.addConexion(g.getNodePos(7), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(7), g.getNodePos(4), (int) random(10, 200));
    break;
  case 3:
    coordenadasX = new ArrayList<Float>(Arrays.asList(290.0, 280.0, 859.0, 709.0, 653.0, 517.0, 914.0, 137.0, 484.0, 1089.0, 1077.0));
    coordenadasY = new ArrayList<Float>(Arrays.asList(255.0, 619.0, 413.0, 222.0, 613.0, 408.0, 231.0, 426.0, 155.0, 450.0, 646.0));
    AUXgenerateRandmonButtonClicked(coordenadasX, coordenadasY);

    g.addConexion(g.getNodePos(0), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(4), g.getNodePos(2), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(7), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(7), g.getNodePos(1), (int) random(10, 200));
    g.addConexion(g.getNodePos(0), g.getNodePos(8), (int) random(10, 200));
    g.addConexion(g.getNodePos(8), g.getNodePos(5), (int) random(10, 200));
    g.addConexion(g.getNodePos(8), g.getNodePos(3), (int) random(10, 200));
    g.addConexion(g.getNodePos(3), g.getNodePos(6), (int) random(10, 200));
    g.addConexion(g.getNodePos(1), g.getNodePos(4), (int) random(10, 200));
    g.addConexion(g.getNodePos(6), g.getNodePos(9), (int) random(10, 200));
    g.addConexion(g.getNodePos(2), g.getNodePos(3), (int) random(10, 200));
    g.addConexion(g.getNodePos(9), g.getNodePos(10), (int) random(10, 200));
    g.addConexion(g.getNodePos(4), g.getNodePos(9), (int) random(10, 200));
    g.addConexion(g.getNodePos(10), g.getNodePos(4), (int) random(10, 200));
    break;
  }
}

void repaintBoxControl() {
  // Recuadro del segmento de control
  rectMode(CORNER);
  stroke(0);
  fill(0);
  rect(0, 0, width, 98);

  // Bordes de botones
  rectMode(CORNER);
  stroke(204, 102, 0);
  noFill();
  rect(offButton.getPosition()[0], offButton.getPosition()[1], offButton.getWidth()-1, offButton.getHeight()-1);
  rect(resetButton.getPosition()[0], resetButton.getPosition()[1], resetButton.getWidth()-1, resetButton.getHeight()-1);
  rect(cleanGraph.getPosition()[0], cleanGraph.getPosition()[1], cleanGraph.getWidth()-1, cleanGraph.getHeight()-1);
  rect(generateRandmonButton.getPosition()[0], generateRandmonButton.getPosition()[1], generateRandmonButton.getWidth()-1, generateRandmonButton.getHeight()-1);

  for (PVector pv : boxCoordenates) {
    makeBoxControl((int) pv.x, (int) pv.y, color(#2590CC));
  }
}

void addCoordenate(int x, int y) {
  PVector pv = new PVector(x, y);
  boxCoordenates.add(pv);
}

Textlabel makeLabel(String tagLabel, String text, int x, int y, int posX, int posY) {
  addCoordenate(x, y);
  return  cp5.addTextlabel(tagLabel)
    .setPosition(posX, posY)
    .setText(text)
    .setFont(createFont("arial", 14))
    .setColorValue(#ffffff);
}

void makeBoxControl(int x, int y, color c) {
  rectMode(CORNER);
  strokeWeight(1);
  stroke(204, 102, 0);
  fill(c);
  rect(x*336 +2, y * 48 +2, 312, 46);
}

void offButtonClicked() {
  isOff = !isOff;
  setColorOffButton();
  if (!isOff) {
    for (Node n : g.nodes) {
      n.startTimer();
    }
  } else {
    for (Node n : g.nodes) {
      n.stopTimer();
    }

    for (Car c : g.cars) {
      c.finish();
    }

    g.cars = new ArrayList<Car>();
  }
}

void setColorOffButton() {
  if (isOff) {
    offButton.setColorBackground(color(#002D5A));
    offButton.setColorForeground(color(#34608F));
    offButton.setColorActive(color(#4B8ACF));
    offButton.setLabel("Iniciar Simulacion");
    
    resetButton.setColorBackground(color(#5C5C5C));
    resetButton.setColorForeground(color(#5C5C5C));
    resetButton.setColorActive(color(#5C5C5C));
  } else {
    offButton.setColorBackground(color(#791F39));
    offButton.setColorForeground(color(#AD2E35));
    offButton.setColorActive(color(#4B8ACF));
    offButton.setLabel("Detener Simulacion");
    
    resetButton.setColorBackground(color(#002D5A));
    resetButton.setColorForeground(color(#34608F));
    resetButton.setColorActive(color(#4B8ACF));
  }
}
void resetButtonClicked() {
  if (!isOff) {
    startTime = millis();
    for (Node n : g.nodes) {
      n.stopTimer();
    }

    for (Car c : g.cars) {
      c.finish();
    }

    g.cars = new ArrayList<Car>();
    for (Node n : g.nodes) {
      n.startTimer();
    }
  }
}
