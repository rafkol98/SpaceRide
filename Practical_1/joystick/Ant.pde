public class Ant
{
  float xPos = 0;
  float yPos = 0;
  color myColor;
  Ant(float x, float y, color antColor)
  {
    xPos = x;
    yPos = y;
    myColor = antColor;
  }

  void walk()
  {
    xPos = xPos + random(-2,2);
    yPos = yPos + random(-2,2);
    fill(myColor);
    noStroke();
    ellipse(xPos, yPos, 20, 20);
  }
}
