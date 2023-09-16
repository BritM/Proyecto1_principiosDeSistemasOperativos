import controlP5.*;

ControlP5 cp5;

String textValue = "";
int input;

Graph g;

float mx;
float my;

int lineStart;

void setup() {
  size(1400,800);
  
  cp5 = new ControlP5(this);
  input = 0;
  g = new Graph();
  
  cp5.addTextfield("alpha")
     .setPosition(700,400)
     .setSize(50,20)
     .setFont(createFont("arial",20))
     .setFocus(true)
     .setColor(color(#FCFEFF))
     ;
  cp5.get(Textfield.class,"alpha").hide();
  
  cp5.addTextfield("distance")
     .setPosition(700,400)
     .setSize(50,20)
     .setFont(createFont("arial",20))
     .setFocus(true)
     .setColor(color(#FCFEFF))
     ;
  cp5.get(Textfield.class,"distance").hide();
  
  textFont(createFont("arial",15));
     
  g.demo();
}

void draw() {
  background(#88E8AA);
  g.display();
  
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (input == 0){
      mx = mouseX;
      my = mouseY;
      
      if (!g.isOnNode(mx,my)){
        cp5.get(Textfield.class,"alpha").show();
        input = 1;
      }
      
    }else if (input == 2){
      g.deselectNode(lineStart);
      input = 0;
    }
    
     
  }else if (mouseButton == RIGHT) {
    
    
    if (g.isOnNode(mx,my) && g.nodeCount() >= 2 && input !=3){
      mx = mouseX;
      my = mouseY;
      if(input == 0){
        input = 2;
        lineStart = g.closestNodeID(mx,my);
        g.selectNode(lineStart);
        
      }else if(input == 2){
        if (g.closestNodeID(mx,my) != lineStart){
          g.deselectNode(lineStart);
          cp5.get(Textfield.class,"distance").show();
          input = 3;
          
        }
      }
    }
  }
}

void keyPressed(){
  if (key == ENTER ){
    if (input == 1){
      String message = cp5.get(Textfield.class,"alpha").getText();
      
      if (message.matches("[-+]?[0-9]*\\.?[0-9]+")){
        float alph = float(message);
      
        cp5.get(Textfield.class,"alpha").clear();
        cp5.get(Textfield.class,"alpha").hide();
        g.addNode(mx, my, alph);
        input=0;
      }
      
      
    }else if(input == 3){
      int d = int(cp5.get(Textfield.class,"distance").getText());
      cp5.get(Textfield.class,"distance").clear();
      cp5.get(Textfield.class,"distance").hide();
      PVector n1 = g.getNodePos(lineStart);
      int n2ID = g.closestNodeID(mx,my);
      PVector n2 = g.getNodePos(n2ID);
      g.addConexion(n1, n2, d);
      input=0;
    }
  }
}
