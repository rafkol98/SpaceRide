// Author: 210017984
public class Alien {
  
  // Initialise Alien variables.
  float x = 0;
  float y = 0;

  /**
   Create a new alien. Passing in the x and y coordinates.
   **/
  Alien(float x, float y)
  {
    this.x = x;
    this.y = y;
  }

  /**
   Make the alien's colony multiply.
   **/
  void multiply()
  {
    x = x + random(-2, 2);
    y = y + random(-2, 2);

    // If the player collides with the aliens, then exit wormhole.
    if (dist(playerXCoordJoy, playerYCoordJoy, x, y) <  2 +20) {
      fill(255, 0, 0);
      text("Attacked by an alien!", width/2, height/2);
      fill(255, 0, 0);
      gf.exitWormhole();
    }

    fill(255);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}
