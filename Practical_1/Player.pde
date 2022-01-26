public class Player {
  float xPos = 40; // Fixed position on X
  float yPos = 0;
  color playerColor;
  
  int playerWidth = 60;
  int playerHeight = 60;
  
  Player(int y, color pColor) {
    yPos = y;
    playerColor = pColor; 
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    rect(xPos, yPos, playerWidth, playerHeight);
  }
  
  
  
}
