class GameFlow {
  
  void randomAttacks() {
    // Every 600 frames (10 seconds) generate an attack.
    if (frameCount % 600 == 0) {
        initAsteroids((int) random(3, min(passedSeconds/7, 40)));
    } 
    // Every 1800 frames (40 seconds) generate a power up.
     if (frameCount % 2400 == 0) {
        powerUp = new PowerUp((int) random(1,4));
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
      case 1:
        lives = lives +1;
        break;
      case 2:
        playerRadius = 25; // shrink player.
        break;
      case 3:
        invincible = true;
        //powerUpColor = color(51, 252, 255);
        break;  
     }
     powerUpActivatedSeconds = passedSeconds;
     holdingPowerUp = false;
  }

}
