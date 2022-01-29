public class PowerUp { 
  float xPos;
  float yPos;
  float diameter = 50;
  float xSpeed;
  float ySpeed;

  PowerUp() {
    xPos = width / 2;
    yPos = height / 2;
    xSpeed = random(-8, 8);
    ySpeed = random(-8, 8);
  }

  void bounce() {
    ellipse(xPos, yPos, diameter, diameter);
    xPos += xSpeed;
    yPos += ySpeed;

    if (xPos >= width) {
      xSpeed = -xSpeed;
    }

    if (yPos < 0 || yPos >= height) {
      ySpeed = -ySpeed;
    }
  }
  
  
  
  
 // float xPos; // Fixed position on X
 // float yPos;
 // color powerUpColor;
 // float xSpeed;
 // float ySpeed;
 // String powerType;
  
 // PowerUp(float x, float y, String type) {
 //   xPos = x;
 //   yPos = y;
 //   powerType = type;
 // }
  
 //void bounce() {
     
 //   switch(powerType) {
 //     case "ExtraLife":
 //       powerUpColor = color(64, 255, 40);   
 //       break;
 //     case "Shrink":
 //       powerUpColor = color(255, 110, 207); 
 //       break;
 //     case "Invincible":
 //       powerUpColor = color(51, 252, 255);
 //       break; 
 //   }
    
 //   println(powerType);
 //   fill(powerUpColor);
 //   ellipse(xPos, yPos, 50, 50);
 //   xPos += xSpeed;
 //   yPos += ySpeed;

 //   if (xPos < 0 || xPos >= width) {
 //     xSpeed = -xSpeed;
 //   }

 //   if (yPos < 0 || yPos >= height) {
 //     ySpeed = -ySpeed;
 //   }
 // }
}
