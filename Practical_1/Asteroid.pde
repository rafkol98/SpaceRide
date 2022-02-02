class Asteroid { 
  float xPos;
  float yPos;
  
  float radius;

  Asteroid(float xVal, float yVal, float rVal){
    xPos = xVal;
    yPos = yVal;
    radius= rVal;
  } 
  
  boolean move(float speed){
    xPos -= speed;

    boolean collision = dist(xPos, yPos, playerXCoord, playerYCoord) < radius + playerRadius;
 
    if(collision){
      return true;
     }
     return false;
  }
  
  void display(){
    fill(150, 102, 20);
    stroke(10);
    circle(xPos, yPos, radius);
  }
}
