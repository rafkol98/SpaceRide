public class Player {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color playerColor;
  
  int playerWidth = 50;
  int playerHeight = 50;
  
  Player(float y) {
    yPos = y;
    playerColor = color(255, 204, 0); 
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    stroke(10);
    ellipse(xPos, yPos, playerWidth, playerHeight);
  }
  
  
  
}
