class GameFlow {
  
  void randomAttacks() {
  // Every 600 frames generate an attack.
    if (frameCount % 600 == 0) {
        initAsteroids((int) random(3, min(passedSeconds/7, 40)));
    } 
  }
  
  void initAsteroids(int num){
    asteroids = new ArrayList<>();
   
    for(int i = 0; i < num; i++) {
       asteroids.add(new Asteroid(random(1280, 2000), random(0, 720), random(5,60)));
    }
  }

  void moveAsteroids(){
        for(Asteroid asteroid : asteroids) {
           if (dist(playerXCoord, playerYCoord, asteroid.xPos, asteroid.yPos) <  8 + asteroid.radius) {
            fill(255);
            text("My circles are touching!", width/2, height/2);
            fill(255, 0, 0);
            collided = true;
          }
          
          if(asteroid.yPos > height) {
             asteroid.yPos = -10;
          }
          asteroid.move(random(1, 10));
          asteroid.display();
        }
        
  }
  
  void handlePowerUp() {
   switch(holdingPowerType) {
      case "ExtraLife":
        //powerUpColor = color(64, 255, 40);   
        break;
      case "Shrink":
        playerRadius = 25; // shrink player.
        powerUpActivatedSeconds = passedSeconds;
        break;
      case "Invincible":
        //powerUpColor = color(51, 252, 255);
        break; 
      default:
        break; 
     }
     holdingPowerUp = false;
  }

}
