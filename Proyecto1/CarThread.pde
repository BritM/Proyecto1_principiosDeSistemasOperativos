import java.util.concurrent.Semaphore;
import java.math.BigDecimal;
import java.math.RoundingMode;

class CarThread extends Thread {
  ArrayList<Conexion> paths;
  ArrayList<Node> stops;
  Car car;


  CarThread(ArrayList<Conexion> ppaths, ArrayList<Node> pstops, Car pcar) {
    paths =ppaths;
    stops = pstops;
    car = pcar;
  }

  public void run() {
    for (int i = 0; i < paths.size(); i++) {
      long startTime = System.currentTimeMillis();
      BigDecimal distanceD = new BigDecimal( paths.get(i).getDistance() );
      PVector currentPos = stops.get(i).pos.copy();
      PVector targetPos = stops.get(i+1).pos.copy();
      BigDecimal distanceR = new BigDecimal( currentPos.dist(targetPos) );
      BigDecimal op1 = distanceR.multiply(  BigDecimal.valueOf  (0.017)  );
      BigDecimal op15 = BigDecimal.valueOf( 10 ).divide(distanceD, 4, BigDecimal.ROUND_HALF_UP);
      BigDecimal op2 = op1.multiply( op15);

      BigDecimal op3 = op2.divide(BigDecimal.valueOf(10), 4, BigDecimal.ROUND_HALF_UP);

      BigDecimal speedD = op3;
      float rounded = speedD.setScale(4, RoundingMode.DOWN).floatValue();

      println(rounded);
      PVector dir = new PVector(targetPos.x - currentPos.x, targetPos.y - currentPos.y);
      boolean mag = false;
      while (mag == false) {

        dir = new PVector(targetPos.x - currentPos.x, targetPos.y - currentPos.y);

        if (dir.mag() > 40.0) {
          dir.normalize();
          dir.mult(rounded);

          currentPos.x += dir.x;
          currentPos.y += dir.y;
          synchronized (car) {
            car.updatePos(currentPos.x, currentPos.y);
          }
        } else {
          mag = true;
        }
        delay(1);
      }
      long estimatedTime = System.currentTimeMillis() - startTime;
      Node nextNode = stops.get(i+1);

      try {
        nextNode.sema.acquire();
      }
      catch(InterruptedException e) {
        System.out.println("not acquired");
      }



      car.updatePos(nextNode.pos.x, nextNode.pos.y);

      try {
        Thread.sleep(2000);
      }
      catch(InterruptedException e) {
        System.out.println("got interrupted!");
      }




      nextNode.sema.release();

      println("estimated");
      println(estimatedTime);
      println(distanceR);
      println(speedD);
    }

    car.finish();
    g.ncarros.release();
  }
}
