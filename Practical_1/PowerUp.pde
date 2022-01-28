public class PowerUp {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color powerUpColor;
  
  int playerWidth = 40;
  int playerHeight = 40;
  
  PowerUp(float y, String type) {
    yPos = y;
    determineColour(type);
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(powerUpColor);
    ellipse(xPos, yPos, playerWidth, playerHeight);
  }
  
  void determineColour(String type) {
    switch(type) {
      case "ExtraLife":
        powerUpColor = color(64, 255, 40);   
        break;
      case "Shrink":
        powerUpColor = color(255, 110, 207); 
        break;
      case "Invincible":
        powerUpColor = color(51, 252, 255);
        break; 
    }
  }
}
