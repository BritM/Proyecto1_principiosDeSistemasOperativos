int nVehicles = 20;
long startTime, elapsedTime;
String timeExecution = "0";
Slider nVehiclesSlider;
Button offButton, resetButton;
Textlabel timerLabel, averageSpeedLabel;
boolean isOff = false;
ArrayList<PVector> boxCoordenates = new ArrayList<PVector>();
color baseColor = color(#2590CC);

void Control() {
  // Sliders
  nVehiclesSlider = cp5.addSlider("Cantidad de Carros")
    .setPosition(10, 15)
    .setRange(2, 50)
    .setValue(nVehicles)
    .setSize(124, 20)
    .setFont(createFont("arial", 15))
    .setNumberOfTickMarks(19)
    .snapToTickMarks(true);
  addCoordenate(0, 0);

  // Labels
  timerLabel = makeLabel("timerLabel", "TIEMPO DE SIMULACIóN: " + timeExecution, 1, 0, 339, 21);
  averageSpeedLabel = makeLabel("averageSpeedLabel", "VELOCIDAD PROMEDIO: 0 km/s", 1, 1, 339, 69);

  // Botones
  offButton = cp5.addButton("offButtonClicked")
    .setPosition(1157, 3)
    .setSize(239, 45)
    .setLabel("Detener Simulacion")
    .setColorBackground(color(#791F39))
    .setColorForeground(color(#AD2E35))
    .setColorActive(color(#D95C45));

  resetButton = cp5.addButton("resetButtonClicked")
    .setPosition(1157, 51)
    .setSize(239, 45)
    .setLabel("Reiniciar Simulacion")
    .setColorBackground(color(#247451))
    .setColorForeground(color(#30AC58))
    .setColorActive(color(#5ADC70));
}

void repaintBoxControl(ArrayList<PVector> boxCoordenates) {
  // Recuadro del segmento de control
  rectMode(CORNER);
  stroke(0);
  fill(0);
  rect(0, 0, width, 24*4);

  // Bordes de botones
  rectMode(CORNER);
  stroke(204, 102, 0);
  noFill();
  rect(offButton.getPosition()[0], offButton.getPosition()[1], offButton.getWidth()-1, offButton.getHeight()-1);
  rect(resetButton.getPosition()[0], resetButton.getPosition()[1], resetButton.getWidth()-1, resetButton.getHeight()-1);

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
  isOff = true;
}


void resetButtonClicked() {
  // Agregar el reinicio de variables y nodos

  startTime = millis();
  isOff = false;
}
