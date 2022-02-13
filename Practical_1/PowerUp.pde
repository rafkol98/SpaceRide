// Author: 210017984
public class PowerUp {
  
  // Initialise PowerUp variables.
  float x;
  float y;
  float radius = 50;
  color powerUpColor;
  float xSpeed;
  float ySpeed;
  int powerType;
  int distSensitivity = 20;

  /**
   Create a new power up instance passing in its type.
   It can have four different types.
   1 - Extra life.
   2 - Shrink player's size.
   3 - Invincibility.
   4 - Extra score, this appears only if the player is in the wormhole.
   **/
  PowerUp(int type) {
    // if its an extrascore - wormhole, then place xPos in the middle.
    if (type == 4) {
      x = 100;
    } else {
      x = 1580;
    }

    y = height / 2;
    xSpeed = random(-6, -2);
    ySpeed = random(-8, 8);
    powerType = type;
  }

  /**
   Bounce power up in the screen's borders.
   **/
  void move() {
    // get player's x and y location. This is used to get the joystick's x and y if the user is in the wormhole.
    float plX = (powerType == 4) ? playerXCoordJoy : playerXCoord;
    float plY = (powerType == 4) ? playerYCoordJoy : playerYCoord;

    // if the player collides with the power up, then set appropriate flags and light up leds.
    if (dist(plX, plY, x, y) <  distSensitivity + radius) {
      fill(255);
      if (powerType != 4) {
        text("Got power up!", width/2, height/2);
        holdingPowerUp = true;
        holdingPowerType = powerType;
        lightUpAppropriateLed();
      }
      // if the user is in the wormhole, then when they get the power they get 5 points
      // and then exit the wormhole.
      else {
        text("+5 !", width/2, height/2);
        score += 5;
        gf.exitWormhole();
      }
    }

    displayPowerUp(); // display power up.

    int bottomBorder = 80;

    // If the user is in the wormhole and chasing after the extra credits ball,
    // then make the ball bounce on the left and right borders as well.
    if (powerType == 4) {
      bottomBorder = 0;
      if (x < 0 || x > width) {
        xSpeed *= -1;
      }
    }

    // Make power up bounce on top and bottom borders.
    if (y < 0 || y >= height - bottomBorder) {
      ySpeed = -ySpeed;
    }
  }

  /**
   Display the power up, colouring it according to the power up type.
   **/
  void displayPowerUp() {
    switch(powerType) {
      // ExtraLife  = case 1.
    case 1:
      powerUpColor = color(64, 255, 40);
      break;
      // Shrink  = case 2.
    case 2:
      powerUpColor = color(255, 110, 207);
      break;
      // Invincible  = case 3.
    case 3:
      powerUpColor = color(51, 252, 255);
      break;
    case 4:
      // Extrascore - wormhole.
      powerUpColor = color(127, 0, 255);
      break;
    }

    fill(powerUpColor);
    circle(x, y, radius);
    x += xSpeed;
    y += ySpeed;
  }

  /**
   Light up appropriate LEDs, depending on which power they got.
   **/
  void lightUpAppropriateLed() {
    switch(powerType) {
      // ExtraLife  power up GREEN led. 
    case 1:
      myPort.write("G"); // Write to the port G.
      break;
      // Shrink power up RED led.
    case 2:
      myPort.write("R"); // Write to the port R.
      break;
      // Invincible power up BLUE led.
    case 3:
      myPort.write("B"); // Write to the port B.
      break;
    }
  }

  /**
   Set new x and y positions out of the screen. Used when exiting the wormhole.
   **/
  void setPositionOutOfScreen() {
    this.x = 15000;
    this.y = 15000;
  }
}
