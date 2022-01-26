public class Player {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color playerColor;
  
  int playerWidth = 60;
  int playerHeight = 60;
  
  Player(float y, color pColor) {
    yPos = y;
    playerColor = pColor; 
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    ellipse(xPos, yPos, playerWidth, playerHeight);
  }
  
  
  
}
