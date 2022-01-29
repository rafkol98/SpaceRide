public class Ufo
{
  float xCor = 0;
  float yCor = 0;
  
  Ufo(float x, float y)
  {
    xCor = x;
    yCor = y;

  }
  
  void move()
  {
    xCor = xCor + random(-40,30);
    yCor = yCor + random(-20,20);
  }
  
  void display() {
    fill(color(180, 180, 180));
    stroke(10);
    ellipse(xCor, yCor, 140, 60);
  }
  
}
