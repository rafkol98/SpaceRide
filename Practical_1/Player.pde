public class Player {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color playerColor;
  
  int radius;
  
  Player(float y, color pColor, int r) {
    yPos = y;
    playerColor = pColor;
    radius = r;
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    stroke(10);
    circle(xPos, yPos, radius);
  }
  
  
  
}
