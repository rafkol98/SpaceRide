// Author: 210017984
public class Player {
  
  // Initialise Player variables.
  float x = 80; // Fixed position on X (except within the wormhole).
  float y = 0;
  color playerColor =  color(255, 10, 71);
  int radius;

  /**
   Create a new player. Passing in the y coordinate and the player's radius.
   **/
  Player(float y, int r) {
    this.y = y;
    radius = r;
    display();
  }

  /**
   Create a new player. Passing in the x and y coordinates of the Joystick and the player's radius.
   **/
  Player(float x, float y, int r) {
    this.x = x;
    this.y = y;
    radius = r;
    display();
  }

  /**
   Draw player in the screen.
   **/
  void display() {
    fill(playerColor);
    stroke(10);
    circle(x, y, radius);
  }

  /**
   Adjust player's speed.
   **/
  void playerSpeed() {
    // If player tries to go out of bounds throw them back in.
    if (playerYCoord < 5) {
      PVector negJump = new PVector(0, -0.8);
      velocity.sub(negJump);
    }

    // If user pressed A then make the player jump.
    if (aPressed) {
      if (playerYCoord > 100) {
        velocity.add(jump);
      }
    }
    aPressed = false; // Reset the aPressed flag.
  }
}
