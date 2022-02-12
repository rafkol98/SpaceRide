class GameFlow {

  /**
   Generate random attacks, every few frames.
   **/
  void randomAttacks() {
    // Every 600 frames (10 seconds) generate an asteroid attack.
    if (frameCount % 600 == 0) {
      score++; // the score increases every 600 frames.
      initAsteroids((int) random(3, min(passedSeconds/4, 25)));
    }

    // Every 1800 frames (30 seconds) generate a wormhole.
    if (frameCount % 1800 == 0) {
      wormhole = new Wormhole(random(1280, 2000), random(0, 800), 20);
    }

    // Every 2400 frames (40 seconds) generate a power up.
    if (frameCount % 2400 == 0) {
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

  /**
   Make all the asteroids to move to the left (attack the player).
   **/
  void moveAsteroids() {
    for (Asteroid asteroid : asteroids) {
      // if the player collides with an asteroid and they are not invincible, then make the gameMode equal to 1 (which pauses game and deduces a life).
      if ((dist(playerXCoord, playerYCoord, asteroid.x, asteroid.y) <  (playerRadius/10) + asteroid.radius) && !invincible) {
        fill(255);
        text("Collided!", width/2, height/2);
        fill(255, 0, 0);
        gameMode = 1;
      }
      // if the player is touching an asteroid, but he is invinvible, show him a message!
      else if ((dist(playerXCoord, playerYCoord, asteroid.x, asteroid.y) < (playerRadius/10) + asteroid.radius) && invincible) {
        fill(0, 240, 20);
        text("Invincibility saved you a life!", width/2, height/2);
      }

      // if asteroid's y position is bigger than screen's height move them down.
      if (asteroid.y > height) {
        asteroid.y = -10;
      }

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

    readData(); // read data from controller.

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
