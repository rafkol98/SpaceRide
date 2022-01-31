public class Ufo
{
  float xPos = 0;
  float yPos = 0;
  float w;
  float h;
  
  
  
  Ufo(float x, float y)
  {
    xPos = x;
    yPos = y;
    w = 140;
    h = 60;

  }
  
  boolean move()
  {
    xPos = xPos + random(-40,30);
    yPos = yPos + random(-20,20);
    
    boolean collision = (xPos >= (playerXCoord - w/2) && xPos <= (playerXCoord + w/2)) || (yPos >= playerYCoord && yPos <= playerYCoord + h);
 
    if(collision){
      return true;
     }
     return false;
  }
  
  void display() {
    fill(color(180, 180, 180));
    stroke(10);
    ellipse(xPos, yPos, w, h);
  }
  
}
