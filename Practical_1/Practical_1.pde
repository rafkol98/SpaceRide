import processing.serial.*;

PImage bg, powerUpImg;

GameFlow gf = new GameFlow();

// Joystick.
int playerXCoordJoy;
int playerYCoordJoy;

// Initialise player.
Player player;
float playerYCoord = 800;
float playerXCoord = 80;
int playerRadius = 50;

// Gravity
PVector position = new PVector(playerXCoord, playerYCoord);
PVector velocity = new PVector(0, 0);
PVector gravity = new PVector(0, 0.09);
PVector jump = new PVector(0, -3.2);

int lives = 3;
ArrayList<Asteroid> asteroids;

// Port for serial.
Serial myPort;

boolean aPressed, whistle, showPowerUpIcon;
String inString;

// Power up variables.
boolean holdingPowerUp = false;
int holdingPowerType = 0;
int powerUpActivatedSeconds;
boolean invincible = false;
PowerUp powerUp;

// Timer
int savedTime;
int passedSeconds;
int score;

int gameMode = 0;

// Wormhole.
Wormhole wormhole;
ArrayList<Alien> aliensArray = new ArrayList<>();
ArrayList<Alien> newAliensArray = new ArrayList<>();


void setup() {
  playerXCoordJoy = 0;
  playerYCoordJoy = 0;
  fullScreen();
  myPort = new Serial(this, Serial.list()[5], 115200);
  initialiseGame();
  gf.initAsteroids(5);
  wormhole = new Wormhole(random(1280, 2000), random(0, 800), 20);
  savedTime = millis();
  powerUp = new PowerUp(1);

  // Aliens.
  for (int i=0; i<8; i++) {
    aliensArray.add(new Alien(random(0, 1000), random(0, 230)));
    aliensArray.add(new Alien(random(0, 1000), random(580, 720)));
  }
}

void draw() {
  passedSeconds = (millis() - savedTime)/1000;

  if (lives > 0) {
    // Normal game mode, continue normal execution of game.
    if (gameMode == 0) {

      deactivatePowerUp();

      // Resize image.
      bg.resize(width, height);
      image(bg, 0, 0);

      handlePlayerMovements();

      objectsMovements();

      screenElements();
    }

    // This game mode pauses the game when the player lost a life.
    if (gameMode == 1) {
      fill(255, 40, 40);
      text("Lost a life, Click A to continue", 10, 230);
      rect(0, 240, width, 7);

      asteroids.clear(); // clear all the asteroids that made the player crash.
      readData();
    }

    // This game mode is activated when the player enters the wormhole.
    if (gameMode == 2) {
      asteroids.clear();
      gf.handleWormhole();
    }
  }
  // if player lost all three lives, give them the chance to play again.
  else {
    background(0, 0, 0);
    fill(255, 0, 0);
    text("You Lost, Click B to play again", 10, 230);
    rect(0, 240, width, 7);
    readData();
  }
}


/**
 Handle the player's movements, gravity and velocity.
 **/
void handlePlayerMovements() {
  readData();

  position.add(velocity);
  velocity.add(gravity);

  if (position.y > 800) {
    velocity.y = 0;
  }

  playerYCoord = position.y;
  player = new Player(playerYCoord, playerRadius);
}

/**
 Move the objects in the screen.
 **/
void objectsMovements() {
  gf.moveAsteroids();
  
  player.playerSpeed();

  gf.moveWormhole();

  gf.randomAttacks();

  powerUp.bounce();
}

/**
 Initialise all the variables used in the game. Method used when restarting the game
 (after player lost all lives).
 **/
void initialiseGame() {
  clear();
  gameMode = 0;
  playerRadius = 50;
  printArray(Serial.list());
  bg = loadImage("Bg_game_new.jpg");
  powerUpImg = loadImage("power.png");
  savedTime = millis();
  score = 0;
  println("Starting");
}

/**
 Show screen elements, such as score, lives, and whether the player is holding power up.
 **/
void screenElements() {
  textSize(40);
  fill(255);
  text("Score: "+(int) score, 50, 80);
  text("Lives: "+(int) lives, width - 150, 80);
  
  activePowerUpIcon();
}

/**
Show the power up icon to indicate that the user has an active power up.
**/
void activePowerUpIcon() {
  if (showPowerUpIcon && holdingPowerType != 1) {
    powerUpImg.resize(50, 0);
    image(powerUpImg, width - 250, 40);
  }
}

/**
 Deactivate power up (if the user holds one).
 **/
void deactivatePowerUp() {
  if (powerUpActivatedSeconds + 10 == passedSeconds) {
    playerRadius = 50;
    invincible = false;
    showPowerUpIcon = false;
  }
}

/**
 Read data from the port. The serial event is not used because data is fed up too frequently creating problems with the game's
 performance and smoothness.
 **/
void readData() {
  //println("called");
  inString =  myPort.readStringUntil('\n');  // read reading sent from microbit, until new line appears.

  if (inString != null) {

    // Set the aPressed flag to true (controls player's movements).
    if (inString.charAt(0) == 'A') {
      aPressed = true;

      // if player lost a life, subtract it and continue the game.
      if (gameMode == 1) {
        gameMode = 0;
        lives--; // subtract a life.
        if (lives == 0) {
          redraw();
        }
      }
    }

    // Restart game (if dead).
    if (inString.charAt(0) == 'B') {
      if (lives == 0) {
        println("Restarting game.");
        initialiseGame();
        lives = 3;
      }
    }

    // On whistle and B together, activate power up.
    if (inString.charAt(0) == 'W') {
      // if the player is holding a power up and its of a specified type, then handle the power up accordingly.
      if (holdingPowerUp && holdingPowerType != 0) {
        gf.handlePowerUp();
      }
    }

    // Get the Y coordinates of the joystick.
    if (inString.charAt(0) =='Y') {
      try {
        int sepPos = inString.indexOf(";");
        playerYCoordJoy = (int) map(Integer.parseInt(inString.substring(1, sepPos)), 0, 1023, 0, height);
      }
      catch(Exception e) {
        println("caught"+ playerYCoordJoy);
      }
    }

    // Get the X coordinates of the joystick.
    if (inString.charAt(0)=='X') {
      try {
        int sepPos = inString.indexOf(";");
        playerXCoordJoy = (int) map(Integer.parseInt(inString.substring(1, sepPos)), 0, 1023, 0, width);
      }
      catch(Exception e) {
        println("caught"+playerXCoordJoy);
      }
    }
  }
}
