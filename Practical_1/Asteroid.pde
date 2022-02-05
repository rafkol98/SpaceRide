class Asteroid { 
  float xPos;
  float yPos;
  
  float radius;

  Asteroid(float xVal, float yVal, float rVal){
    xPos = xVal;
    yPos = yVal;
    radius= rVal;
  } 
  
  void move(float speed){
    xPos -= speed;
  }
  
  void display(){
    fill(150, 102, 20);
    stroke(10);
    circle(xPos, yPos, radius);
  }
}
