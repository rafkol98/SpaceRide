class Asteroid { 
  public int xCor;
  public int yCor;
  public int w;
  public int h;

  Asteroid(int xVal, int yVal, int wVal, int hVal){
    xCor = xVal;
    yCor = yVal;
    w = wVal;
    h = hVal;
    
  } 
  
  public void drop(float speed){
    xCor -= speed;
  }
  
  public void display(){
    fill(150, 102, 20);
    rect(xCor, yCor,w,h,5);
  }
}
