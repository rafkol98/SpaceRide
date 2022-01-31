public class Obstacle {
  float xPos = 0; // Fixed position on X
  float yPos = 662;
  
  float w;
  float h;
  
  int obstacleType;

  Obstacle(float x, float wVal, float hVal) {
    xPos = x;
    w = wVal;
    h = hVal;
  }
  
    public boolean move(float speed) {
    xPos -= speed;
    //TODO: debug this!
    boolean collision = (xPos >= (playerXCoord - w/2) && xPos <= (playerXCoord + w/2)) || (yPos >= playerYCoord && yPos <= playerYCoord + h);
 
    if(collision){
      return true;
     }
     
     return false;
  }
  
  void display() {
    fill(20,10,10);
    stroke(212, 0, 41);
    arc(xPos, yPos, w, h, PI, TWO_PI);
  }
  
  
  
}
