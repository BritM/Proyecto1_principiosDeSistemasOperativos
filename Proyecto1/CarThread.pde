import java.util.concurrent.Semaphore;

class CarThread extends Thread{
  ArrayList<Conexion> paths;
  ArrayList<Node> stops;
  Car car;
  
  
  CarThread(ArrayList<Conexion> ppaths, ArrayList<Node> pstops, Car pcar){
    paths =ppaths;
    stops = pstops;
    car = pcar;
  }
  
  public void run(){
    for (int i = 0; i < paths.size(); i++){
      PVector currentPos = paths.get(i).start;
      PVector targetPos = paths.get(i).end;
      PVector dir = new PVector(targetPos.x - currentPos.x, targetPos.y - currentPos.y);
      
      while (dir.mag()>0.0){
        dir.normalize();
        dir.mult(min(1, dir.mag()));
        
        car.updatePos(currentPos.x += dir.x, currentPos.y += dir.y);
      }
      
      Node nextNode = stops.get(i+1);
      
      try {
            nextNode.sema.acquire();
        } catch(InterruptedException e) {
            System.out.println("not acquired");
        }
      
      
      car.updatePos(nextNode.pos.x, nextNode.pos.y);
      
      try {
            Thread.sleep(2000);
        } catch(InterruptedException e) {
            System.out.println("got interrupted!");
        }
        
     
      

      nextNode.sema.release();
 
    }
  
  }

}
