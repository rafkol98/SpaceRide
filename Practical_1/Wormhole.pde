class Wormhole {
  float xPos;
  float yPos;
  
  float radius;

  Wormhole(float xVal, float yVal, float rVal) {
    xPos = xVal;
    yPos = yVal;
    radius= rVal;
  } 
  
  void move(float speed){
     if (dist(playerXCoord, playerYCoord, xPos, yPos) <  20 + radius) {
      fill(100, 255, 100);
      text("WORMHOLE!", width/4, height/4);
      gameMode = 2;
      inWormholeSeconds = passedSeconds;
      
    }
    
    xPos -= speed;
  }
  
  void display(){
    fill(80, 80, 80);
    stroke(10);
    circle(xPos, yPos, radius+40);
    
    fill(60, 60, 60);
    stroke(10);
    circle(xPos, yPos, radius+20);
    
    fill(20, 20, 20);
    stroke(10);
    circle(xPos, yPos, radius);
  }
}
