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
    .setNumberOfTickMarks(19)
    .snapToTickMarks(true);
  addCoordenate(0, 0);

  // Labels
  timerLabel = makeLabel("timerLabel", "TIEMPO DE SIMULACIóN: " + timeExecution, 1, 0, 291, 21);
  averageSpeedLabel = makeLabel("averageSpeedLabel", "VELOCIDAD PROMEDIO: 0 km/s", 1, 1, 291, 69);
  
  // Botones
  offButton = cp5.addButton("offButtonClicked")
    .setPosition(1155, 3)
    .setSize(239, 45)
    .setLabel("Detener Simulacion")
    .setColorBackground(color(#791F39))
    .setColorForeground(color(#AD2E35))
    .setColorActive(color(#D95C45));
  addCoordenate(4, 0);

  resetButton = cp5.addButton("resetButtonClicked")
    .setPosition(1155, 51)
    .setSize(239, 45)
    .setLabel("Reiniciar Simulacion")
    .setColorBackground(color(#247451))
    .setColorForeground(color(#30AC58))
    .setColorActive(color(#5ADC70));
  addCoordenate(4, 1);
}

void repaintBoxControl(ArrayList<PVector> boxCoordenates) {
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
    .setColorValue(#ffffff);
}

void makeBoxControl(int x, int y, color c) {
  rectMode(CORNER);
  strokeWeight(1);
  stroke(204, 102, 0);
  fill(c);
  rect(x*12*24 +2, y * 48 +2, 24*10, 46);
}

void offButtonClicked() {
  isOff = true;
}


void resetButtonClicked() {
  // Agregar el reinicio de variables y nodos

  startTime = millis();
  isOff = false;
}
