public class Ufo
{
  float xCor = 0;
  float yCor = 0;
  
  Ufo(float x, float y)
  {
    xCor = x;
    yCor = y;
  }
  
   public void move(float speed){
    xCor -= speed;
  }

  void walk()
  {
    println("Called");
    xCor = xCor + random(-40,30);
    yCor = yCor + random(-20,20);
    print(xCor, yCor);
    fill(color(180, 180, 180));
    noStroke();
    ellipse(xCor, yCor, 140, 60);
  }
}
