public class Alien
{
  float x = 0;
  float y = 0;
  color myColor;
  Alien(float x, float y, color antColor)
  {
    this.x = x;
    this.y = y;
    myColor = antColor;
  }

  void walk()
  {
    x = x + random(-2,2);
    y = y + random(-2,2);
    
   if (dist(playerXCoordJoy, playerYCoordJoy, x, y) <  2 +20) {
      fill(255, 0,0);
      text("Attacked by an alien!", width/2, height/2);
      fill(255, 0, 0);
      gf.exitWormhole();
    }
    
    fill(myColor);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}
