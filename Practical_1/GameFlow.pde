class GameFlow {

  void randomAttacks() {
    // Every 600 frames (10 seconds) generate an attack.
    if (frameCount % 600 == 0) {
      initAsteroids((int) random(3, min(passedSeconds/4, 25)));
    }

    if (frameCount % 800 == 0) {
      wormhole = new Wormhole(random(1280, 2000), random(0, 720), 20);
    }

    // Every 1800 frames (40 seconds) generate a power up.
    if (frameCount % 2400 == 0) {
      powerUp = new PowerUp((int) random(1, 4));
    }
  }

  void initAsteroids(int num) {
    asteroids = new ArrayList<>();

    for (int i = 0; i < num; i++) {
      asteroids.add(new Asteroid(random(1280, 2000), random(0, 720), random(15, 60)));
    }
  }

  void moveAsteroids() {
    for (Asteroid asteroid : asteroids) {
      if ((dist(playerXCoord, playerYCoord, asteroid.xPos, asteroid.yPos) <  (playerRadius/10) + asteroid.radius) && !invincible) {
        fill(255);
        text("My circles are touching!", width/2, height/2);
        fill(255, 0, 0);
        gameMode = 1;
      }
      // if the player is touching an asteroid, but he is invinvible, show him a message!
      else if ((dist(playerXCoord, playerYCoord, asteroid.xPos, asteroid.yPos) < (playerRadius/10) + asteroid.radius) && invincible) {
        fill(0, 240, 20);
        text("Invincibility saved you a life!", width/2, height/2);
      }

      if (asteroid.yPos > height) {
        asteroid.yPos = -10;
      }
      asteroid.move(random(1, 10));
      asteroid.display();
    }
  }

  void moveWormhole() {
    if (wormhole !=null) {
        wormhole.move(random(1, 10));
        wormhole.display();
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

  /**
   Handle the wormhole.
   **/
  void handleWormhole() {
    background(30, 30, 30);

    color ballColor = color(255, 204, 0);

    aliensWalk();
    
    powerUp.bounce();
    //extraScore.show();

    readData(); // read data from controller.

    fill(ballColor);
    noStroke();
    ellipse(playerXCoordJoy, playerYCoordJoy, 50, 50);
  }

  /**
   Make aliens walk through the screen.
   **/
  void aliensWalk() {
    // Make aliens walk through the screen.
    for (Alien alien : aliensArray) {
      newAliensArray.add(new Alien(alien.x+2, alien.y+2, c));
      alien.walk();
    }

    for (Alien alien : newAliensArray) {
      alien.walk();
    }
  }
}
