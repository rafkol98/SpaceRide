import processing.serial.*;

PImage bg, powerUpImg;

GameFlow gf = new GameFlow();

int playerXCoordJoy;
int playerYCoordJoy;

// Initialise player.
Player player;
float playerYCoord = 640;
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

int gameMode = 0;

// Wormhole.
Wormhole wormhole;
ArrayList<Alien> aliensArray = new ArrayList<>();
ArrayList<Alien> newAliensArray = new ArrayList<>();
color c = color(255, 10, 71);
int inWormholeSeconds;
//ExtraScoreCircle extraScore;

void setup() {
  playerXCoordJoy = 0;
  playerYCoordJoy = 0;
  size(1280, 720);
  myPort = new Serial(this, Serial.list()[5], 115200);
  initialiseGame();

  // Aliens.
  for (int i=0; i<4; i++) {
    aliensArray.add(new Alien(random(0, 1000), random(0, 230), c));
    aliensArray.add(new Alien(random(0, 1000), random(580, 720), c));
  }
}

void draw() {
  passedSeconds = (millis() - savedTime)/1000;

  if (lives > 0) {

    if (gameMode == 0) {

      if (powerUpActivatedSeconds + 10 == passedSeconds) {
        //TODO: new method.
        playerRadius = 50;
        invincible = false;
      }
      
      //extraScore = new ExtraScoreCircle(random(1,width),random(1,height),40);

      // Resize image.
      bg.resize(1280, 0);
      image(bg, 0, 0);

      readData();

      position.add(velocity);
      velocity.add(gravity);

      if (position.y > 640) {
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

      asteroids.removeAll(asteroids);
      readData();
    }

    if (gameMode == 2) {
      asteroids.clear();
      
      if (inWormholeSeconds + 10 == passedSeconds) {
        playerRadius = 50;
        wormhole = null; // make current wormhole null. So that the user is not in an endless loop.
        powerUp.setPosition();
        gameMode = 0;
        redraw();
      } else {
        // initialise and handle the wormhole.
        gf.handleWormhole();
      }
    }
  } else {
    clear();
    fill(255, 0, 0);
    text("You Lost, Click B to play again", 10, 230);
    rect(0, 240, width, 7);
    readData();
  }
}

void initialiseGame() {
  playerRadius = 50;
  printArray(Serial.list());
  bg = loadImage("bg.jpeg");
  powerUpImg = loadImage("power.png");
  gf.initAsteroids(5);

  wormhole = new Wormhole(random(1280, 2000), random(0, 720), 80);

  savedTime = millis();
  powerUp = new PowerUp(2);
  println("Starting");
}


void screenElements() {
  textSize(40);
  fill(255, 204, 0);
  text("Score: "+(int)passedSeconds, 50, 80);
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
    }

    if (inString.charAt(0) == 'B') {
      if (lives == 0) {
        println("Restarting game.");
        asteroids.removeAll(asteroids);
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
