class GameFlow {

  /**
   Generate random attacks, every few frames.
   **/
  void randomAttacks() {
    // Every 600 frames (10 seconds) generate an asteroid attack.
    if (frameCount % 600 == 0) {
      score++; // the score increases every 600 frames.
      initAsteroids((int) random(3, min(passedSeconds/4, 25)));
      addBottomAsteroids((int) random(1,5));
    }

    // Every 1800 frames (30 seconds) generate a wormhole.
    if (frameCount % 1400 == 0) {
      wormhole = new Wormhole(random(1280, 2000), random(0, 800), 20);
    }

    // Every 1200 frames (20 seconds) generate a power up.
    if (frameCount % 1000 == 0) {
      powerUp = new PowerUp((int) random(1, 4));
    }
  }

  /**
   Initialise given number of asteroids, adding them to the ateroids ArrayList.
   **/
  void initAsteroids(int num) {
    asteroids = new ArrayList<>();

    for (int i = 0; i < num; i++) {
      asteroids.add(new Asteroid(random(width+200, width*2), random(0, 900), random(15, 60)));
    }
  }
  
  void addBottomAsteroids(int num) {
    for (int i = 0; i < num; i++) {
      asteroids.add(new Asteroid(random(width+200, width*2), random(700, 900), random(15, 60)));
    }
  }

  /**
   Make all the asteroids to move to the left (attack the player).
   **/
  void moveAsteroids() {
    for (Asteroid asteroid : asteroids) {
      // Move asteroid and display.
      asteroid.move(random(1, 10));
      asteroid.display();
    }
  }

  /**
  Move the wormhole portal / ball.
  **/
  void moveWormhole() {
    if (wormhole !=null) {
      wormhole.move(random(1, 10));
      wormhole.display();
    }
  }
  
  /**
  Handle the power up doing its appropriate behaviour. 
  Called when the user whistles and holds B at the same time.
  **/
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
      break;
    }
    powerUpActivatedSeconds = passedSeconds;
    showPowerUpIcon = true;
    activePowerUpIcon();
    
    holdingPowerUp = false;
    myPort.write("N"); // turn off leds.
  }

  /**
   Handle the wormhole.
   **/
  void handleWormhole() {
    background(30, 30, 30);
    aliensWalk();

    powerUp.bounce();

    player = new Player(playerXCoordJoy, playerYCoordJoy, 50); // create a player using the x and y coordinates from the joystick.
  }

  /**
   Make aliens walk through the screen.
   **/
  void aliensWalk() {
    // Make aliens walk through the screen.
    for (Alien alien : aliensArray) {
      newAliensArray.add(new Alien(alien.x+2, alien.y+2));
      alien.multiply();
    }

    for (Alien alien : newAliensArray) {
      alien.multiply();
    }
  }

  /**
   Exit the wormhole.
   **/
  void exitWormhole() {
    playerRadius = 50;
    wormhole = null; // make current wormhole null. So that the user is not in an endless loop.
    powerUp.setPositionOutOfScreen();
    gameMode = 0;
  }
}
