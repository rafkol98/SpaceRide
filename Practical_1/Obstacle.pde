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
  }
  
    public void move(float speed){
    xPos -= speed;
    w_triangle -= 0.7;
  }
  
  void display() {
    fill(0,0,0);
    stroke(10);
    arc(xPos, yPos, w, h, PI, TWO_PI);
  }
  
  
  
}
