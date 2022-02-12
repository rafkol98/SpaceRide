import processing.serial.*;

PImage bg, powerUpImg;

GameFlow gf = new GameFlow();

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

boolean aPressed, whistle;
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
color c = color(255, 204, 0);
;
int inWormholeSeconds;


void setup() {
  playerXCoordJoy = 0;
  playerYCoordJoy = 0;
  fullScreen();
  myPort = new Serial(this, Serial.list()[5], 115200);
  initialiseGame();
  gf.initAsteroids(5);
  wormhole = new Wormhole(random(1280, 2000), random(0, 800), 80);
  savedTime = millis();
  powerUp = new PowerUp(1);

  // Aliens.
  for (int i=0; i<8; i++) {
    aliensArray.add(new Alien(random(0, 1000), random(0, 230), c));
    aliensArray.add(new Alien(random(0, 1000), random(580, 720), c));
  }
}

void draw() {
  passedSeconds = (millis() - savedTime)/1000;
  println(passedSeconds);
  if (lives > 0) {

    if (gameMode == 0) {

      if (powerUpActivatedSeconds + 10 == passedSeconds) {
        playerRadius = 50;
        invincible = false;
      }

      // Resize image.
      bg.resize(width, height);
      image(bg, 0, 0);

      readData();

      position.add(velocity);
      velocity.add(gravity);

      if (position.y > 800) {
        velocity.y =0;
      }

      playerYCoord = position.y;
      player = new Player(playerYCoord, playerRadius);

      gf.moveAsteroids();

      gf.moveWormhole();

      player.playerSpeed();

      gf.randomAttacks();

      powerUp.bounce();

      screenElements();
    }

    if (gameMode == 1) {
      fill(255, 40, 40);
      text("Lost a life, Click A to continue", 10, 230);
      rect(0, 240, width, 7);

      asteroids.clear();
      readData();
    }

    // Enter the wormhole.
    if (gameMode == 2) {
      asteroids.clear();
      gf.handleWormhole();
    }

    if (gameMode == 3) {
      fill(255, 40, 40);
      text("Game Paused! Press A to unpause", 10, 230);
      rect(0, 240, width, 7);
      readData();
    }
  } else {
    background(30, 30, 30);
    fill(255, 0, 0);
    text("You Lost, Click B to play again", 10, 230);
    rect(0, 240, width, 7);
    readData();
  }
}

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


void screenElements() {
  textSize(40);
  fill(255);
  text("Score: "+(int) score, 50, 80);
  text("Lives: "+(int) lives, 1100, 80);

  if (holdingPowerUp) {
    powerUpImg.resize(50, 0);
    image(powerUpImg, 1040, 40);
  }
}


void readData() {
  //println("called");
  inString =  myPort.readStringUntil('\n');  // read reading sent from microbit, until new line appears.

  if (inString != null) {
    //println(inString);
    if (inString.charAt(0) == 'A') {
      aPressed = true;
      if (gameMode == 1) {
        gameMode = 0;
        lives--; // subtract a life.
        if (lives == 0) {
          redraw();
        }
      }
      
      if (gameMode == 3) {
        gameMode = 0;
      }
    }

    if (inString.charAt(0) == 'B') {
      if (lives == 0) {
        println("Restarting game.");
        initialiseGame();
        lives = 3;
      }
    }

    if (inString.charAt(0) == 'W') {
      // if the player is holding a power up and its of a specified type, then handle the power up accordingly.
      if (holdingPowerUp && holdingPowerType != 0) {
        gf.handlePowerUp();
      }
    }

    if (inString.charAt(0) == 'L') {
      if (gameMode != 3) {
        gameMode = 3;
      }
    }

    if (inString.charAt(0) =='Y') {
      try {
        int sepPos = inString.indexOf(";");
        playerYCoordJoy = (int) map(Integer.parseInt(inString.substring(1, sepPos)), 0, 1023, 0, height);
      }
      catch(Exception e) {
        println("caught");
      }
    }

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
