import java.util.Timer;
import java.util.TimerTask;

class NodeThread extends TimerTask{
  Node node;
  
  
  NodeThread(Node pNode){
    node = pNode;
  }
  
  public void run(){
    println("spawning car");
    if (g.ncarros.tryAcquire()){
      g.spawnCar(node);
    }
  }

}
