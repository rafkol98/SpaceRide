public class PowerUp {
  float xPos;
  float yPos;
  float radius = 50;
  color powerUpColor;
  float xSpeed;
  float ySpeed;
  int powerType;
  int distSensitivity = 20;

  // Set new xPos and yPos out of the screen.
  void setPosition() {
    this.xPos = 15000;
    this.yPos = 15000;
  }

  PowerUp(int type) {
    // if its an extrascore - wormhole, then place xPos in the middle.
    if (type == 4) {
      xPos = 100;
    } else {
      xPos = 1580;
    }

    yPos = height / 2;
    xSpeed = random(-6, -1);
    ySpeed = random(-8, 8);
    powerType = type;
  }

  void bounce() {
    // get player's x and y location. This is used to get the joystick's x and y if the user is in the wormhole.
    float plX = (powerType == 4) ? playerXCoordJoy : playerXCoord;
    float plY = (powerType == 4) ? playerYCoordJoy : playerYCoord;
   
    if (dist(plX, plY, xPos, yPos) <  distSensitivity + radius) {
      fill(100, 255, 100);
      if (powerType != 4) {
        text("Got power up!", width/2, height/2);
        holdingPowerUp = true;
        holdingPowerType = powerType;
        lightUpAppropriateLed();
      } else {
         text("+5 !", width/2, height/2);
         score += 5;
         gf.exitWormhole();
      }
      
    }

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
    ellipse(xPos, yPos, radius, radius);
    xPos += xSpeed;
    yPos += ySpeed;

    int bottomBorder = 80;

    if (powerType == 4) {
      bottomBorder = 0;
      if (xPos < 0 || xPos > width) {
        xSpeed *= -1;
      }
    }

    // Make power up bounce on top and bottom borders.
    if (yPos < 0 || yPos >= height - bottomBorder) {
      ySpeed = -ySpeed;
    }
  }
  
  void lightUpAppropriateLed() {
    switch(powerType) {
      // ExtraLife  power up GREEN led.
    case 1:
       myPort.write("G");
       break;
       // Shrink power up RED led.
    case 2:
      myPort.write("R");
      break;
      // Invincible power up BLUE led.
    case 3:
       myPort.write("B");
      break;
    }
   
  }
}
