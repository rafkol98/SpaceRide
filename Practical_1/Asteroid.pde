class Asteroid {
  
  // Initialise Asteroid variables.
  float x;
  float y;
  float radius;

  /**
   Create a new asteroid. Passing in the x, y coordinates and the radius.
   **/
  Asteroid(float x, float y, float r) {
    this.x = x;
    this.y = y;
    radius= r;
  }

  /**
   Move asteroid to the left. Do collision check.
   **/
  void move(float speed) {
    // if the player collides with an asteroid and they are not invincible, then make the gameMode equal to 1 (which pauses game and deduces a life).
      if ((dist(playerXCoord, playerYCoord, x, y) <  (playerRadius/10) + radius) && !invincible) {
        fill(255);
        text("Collided!", width/2, height/2);
        fill(255, 0, 0);
        gameMode = 1;
      }
      // if the player is touching an asteroid, but he is invinvible, show him a message!
      else if ((dist(playerXCoord, playerYCoord, x, y) < (playerRadius/10) + radius) && invincible) {
        fill(0, 240, 20);
        text("Invincibility saved you a life!", width/2, height/2);
      }

      // if asteroid's y position is bigger than screen's height move them down.
      if (y > height) {
        y = -10;
      }
      
    x -= speed; // move asteroid to the left.
  }

  /**
   Display asteroid.
   **/
  void display() {
    fill(150, 102, 20);
    stroke(10);
    circle(x, y, radius);
  }
}
