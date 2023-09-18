class Car {
  ArrayList<Integer> path;
  boolean onRoute = false;

  Car() {
    path = new ArrayList<Integer>();
  }

  void update() {
  }

  void display() {
    if (onRoute) {

      PVector startPos = g.nodes.get(path.get(0)).pos;
      PVector endPos = g.nodes.get(path.get(1)).pos;
      Conexion link = null; // Inicializa la variable link como null

      for (Conexion c : g.links) {
        PVector startNode = c.start;
        PVector endNode = c.end;

        // Comprueba si la conexión conecta n1 y n2
        if ((startNode.equals(startPos) && endNode.equals(endPos)) ||
          (startNode.equals(endPos) && endNode.equals(startPos))) {
          link = c;
          break;
        }
      }

      if (link != null) {
        // Calcula la dirección de la línea de conexión
        PVector direction = PVector.sub(link.end, link.start);
        direction.normalize();

        // Calcula el vector de dirección del carro
        PVector carDirection = PVector.sub(startPos, endPos);
        carDirection.normalize();

        // Calcula el ángulo entre los vectores de dirección en radianes
        float angle = PVector.angleBetween(direction, carDirection);


        PVector a = link.start.copy();
        PVector b = link.end.copy();
        PVector t = (b.sub(a).div(2).add(a));
        stroke(0);
        textAlign(LEFT, BOTTOM);

        pushMatrix();
        translate(t.x, t.y + 10);


        // Dibuja el cuadro
        PVector dir = PVector.sub(link.end, link.start); // Calcula el vector de dirección de la línea
        float angle2 = atan2(dir.y, dir.x); // Calcula el ángulo de rotación para que el rectángulo se alinee con la línea
        //rotate(angle);
        strokeWeight(3);
        rectMode(CENTER);
        fill(#7EAEA3);

        color c;
        if (angle < PI / 2) {
          c = color(0, 0, 255);
          fill(c);
          if ((angle2 >= -1.5 && angle2 <= 1.5) || angle2 >= 2.5 || angle2 <= - 2.5) {
            println("arriba");
            ellipse(0, -44, 24, 24);
          } else {
            println("izquierda");
            ellipse(-30, 0, 24, 24);
          }
        } else {
          c = color(0, 255, 0);
          fill(c);
          if ((angle2 >= -1.5 && angle2 <= 1.5) || angle2 >=   2.5 || angle2 <= - 2.5) {
            println("abajo");
            ellipse(0, 22, 24, 24);
          } else {
            ellipse(30, 0, 24, 24);
            println("derecha");
          }
        }

        println("angle2: " + angle2 + " | angle: " + angle + "  | angle < PI / 2: " + (angle < PI / 2));

        popMatrix();
      }
    } else {


      Node n1 = g.nodes.get(path.get(0));
      pushMatrix();

      translate(n1.pos.x, n1.pos.y);
      strokeWeight(2);
      rectMode(CENTER);
      fill(path.size() == 1 ? #9FC908 : #7D599B);
      ellipseMode(CENTER);
      ellipse(0, -26, 20, 20);
      popMatrix();
    }
  }

  PVector nextMove() {
    if (path.size() == 1) {
      return new PVector(path.get(0), -1);
    }
    int firstNode = path.get(0);
    path.remove(0);

    return new PVector(firstNode, path.get(0));
  }
}
