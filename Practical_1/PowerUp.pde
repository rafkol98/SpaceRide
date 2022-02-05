public class PowerUp { 
  float xPos;
  float yPos;
  float radius = 50;
  color powerUpColor;
  float xSpeed;
  float ySpeed;
  int powerType;

  PowerUp(int type) {
    xPos = 1580;
    yPos = height / 2;
    xSpeed = random(-6, -1);
    println(xSpeed);
    ySpeed = random(-8, 8);
    powerType = type;
  }

  void bounce() {
    if (dist(playerXCoord, playerYCoord, xPos, yPos) <  20 + radius) {
      fill(100, 255, 100);
      text("Got power up!", width/2, height/2);
      holdingPowerUp = true;
      holdingPowerType = powerType;
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
     }
    
    fill(powerUpColor);
    ellipse(xPos, yPos, radius, radius);
    xPos += xSpeed;
    yPos += ySpeed;

    // Make power up bounce on top and bottom borders.
    if (yPos < 0 || yPos >= height - 80) {
      ySpeed = -ySpeed;
    }
    
  }
  
}
