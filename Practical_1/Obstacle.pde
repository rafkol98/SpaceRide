public class Obstacle {
  float xPos = 0; // Fixed position on X
  float yPos = 662;
  
  float w, w_triangle;
  float h;
  
  int obstacleType;

  Obstacle(float x, float wVal, float hVal) {
    xPos = x;
    w = wVal;
    w_triangle = wVal;
    h = hVal;
    obstacleType = (int) random(1,3);
  }
  
    public void move(float speed){
    xPos -= speed;
    w_triangle -= 0.7;
  }
  
  void display() {
    
    
    fill(180,141,146);
    stroke(10);
    
    //triangle(xPos, yPos, xPos, h, w, yPos);
    
    switch(obstacleType) {
        case 1:
          arc(xPos, yPos, w, h, PI, TWO_PI);
          break;
        case 2:
          triangle(xPos, yPos, xPos - 100, h, w_triangle, yPos); //TODO fix this
          break;
    }
  }
  
  
  
}
