public class Player {
  float xPos = 80; // Fixed position on X
  float yPos = 0;
  color playerColor = color(255, 204, 0); 
  
  int radius;
  
  Player(float y, int r) {
    yPos = y;
    radius = r;
    drawPlayer();
  }
  
  void drawPlayer() {
    fill(playerColor);
    stroke(10);
    circle(xPos, yPos, radius);
  }
  
  void playerSpeed() {
    
    // If player tries to go out of bounds throw them back in.
    if (playerYCoord < 20) {
      PVector negJump = new PVector(0, -0.8);
      velocity.sub(negJump);
    }
    
    if (aPressed) {
      if (playerYCoord > 100) {
        velocity.add(jump);
      }
    }
      aPressed = false;
  }
  
  
  
}
