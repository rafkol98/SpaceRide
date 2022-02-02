public class Player {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color playerColor;
  
  int radius = 50;
  
  Player(float y) {
    yPos = y;
    playerColor = color(255, 204, 0); 
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    stroke(10);
    circle(xPos, yPos, radius);
  }
  
  
  
}
