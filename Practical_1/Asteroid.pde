class Asteroid { 
  public float xCor;
  public float yCor;
  public float w;
  public float h;

  Asteroid(float xVal, float yVal, float wVal, float hVal){
    xCor = xVal;
    yCor = yVal;
    w = wVal;
    h = hVal;
    
  } 
  
  public void move(float speed){
    xCor -= speed;
  }
  
  public void display(){
    fill(150, 102, 20);
    ellipse(xCor, yCor,w,h);
  }
}
