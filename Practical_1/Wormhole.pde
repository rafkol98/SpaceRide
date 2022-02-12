class Wormhole {
  
  // Initialise Wormhole variables.
  float x;
  float y;
  float radius;

  /**
  Create a new wormhole portal / ball.
  Passing in its x, y coordinates and radius.
  **/
  Wormhole(float x, float y, float r) {
    this.x = x;
    this.y = y;
    radius= r;
  }

  /**
  Make the wormhole portal/ball to move left.
  **/
  void move(float speed) {
    // if the player and the wormhole collided, set the game mode to 2, which will transfer the player
    // to the new smaller game.
    if (dist(playerXCoord, playerYCoord, x, y) <  20 + radius) {
      powerUp = new PowerUp(4); //create a new extra score power up.
      gameMode = 2;
    }

    x -= speed; // move to the left.
  }

  /**
  Display the wormhole portal / ball.
  **/
  void display() {
    fill(80, 80, 80);
    stroke(10);
    circle(x, y, radius+40);

    fill(60, 60, 60);
    stroke(10);
    circle(x, y, radius+20);

    fill(20, 20, 20);
    stroke(10);
    circle(x, y, radius);
  }
}
