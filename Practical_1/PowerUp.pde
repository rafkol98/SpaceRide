public class PowerUp { 
  float xPos;
  float yPos;
  float radius = 50;
  color powerUpColor;
  float xSpeed;
  float ySpeed;
  String powerType;

  PowerUp(String type) {
    xPos = width / 2;
    yPos = height / 2;
    xSpeed = random(-8, 8);
    ySpeed = random(-8, 8);
    powerType = type;
  }

  void bounce() {
    if (dist(playerXCoord, playerYCoord, xPos, yPos) <  50 + radius) {
      fill(100, 255, 100);
      text("Got power up!", width/2, height/2);
      holdingPowerUp = true;
      holdingPowerType = powerType;
    }
    
    
    switch(powerType) {
      case "ExtraLife":
        powerUpColor = color(64, 255, 40);   
        break;
      case "Shrink":
        powerUpColor = color(255, 110, 207); 
        break;
      case "Invincible":
        powerUpColor = color(51, 252, 255);
        break; 
      default:
        powerUpColor = color(51, 252, 255);
        break; 
     }
    
    fill(powerUpColor);
    ellipse(xPos, yPos, radius, radius);
    xPos += xSpeed;
    yPos += ySpeed;

    if (xPos >= width) {
      xSpeed = -xSpeed;
    }

    if (yPos < 0 || yPos >= height) {
      ySpeed = -ySpeed;
    }
    
     
  }
  
}
