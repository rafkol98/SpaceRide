class Asteroid { 
  float xPos;
  float yPos;
  float w;
  float h;

  Asteroid(float xVal, float yVal, float wVal, float hVal){
    xPos = xVal;
    yPos = yVal;
    w = wVal;
    h = hVal;
    
  } 
  
  boolean move(float speed){
    xPos -= speed;
    
     boolean collision = (xPos >= (playerXCoord - w/2) && xPos <= (playerXCoord + w/2)) || (yPos >= playerYCoord && yPos <= playerYCoord + h);
 
    if(collision){
      return true;
     }
     return false;
  }
  
  void display(){
    fill(150, 102, 20);
    stroke(10);
    ellipse(xPos, yPos,w,h);
  }
}
