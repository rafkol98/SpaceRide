public class Ant
{
  float x = 0;
  float y = 0;
  color myColor;
  Ant(float x, float y, color antColor)
  {
    this.x = x;
    this.y = y;
    myColor = antColor;
  }

  void walk()
  {
    x = x + random(-2,2);
    y = y + random(-2,2);
    
   if (dist(posX, posY, x, y) <  2 +20) {
      fill(255, 0,0);
      text("My circles are touching!", width/2, height/2);
      fill(255, 0, 0);
    }
    
    fill(myColor);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}
