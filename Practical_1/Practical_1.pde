import processing.serial.*;

PImage bg, powerUpImg;

GameFlow gf = new GameFlow();

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

boolean generateAst = true;
boolean collided = false;

int lives = 3;
ArrayList<Asteroid> asteroids;

// Port for serial.
Serial myPort;

boolean aPressed, whistle;
String inString;

boolean holdingPowerUp = false;
int holdingPowerType = 0;
int powerUpActivatedSeconds;
boolean invincible = false;

PowerUp powerUp;

// Timer
int savedTime;
int passedSeconds;

int gameMode = 0;


void setup() {
   size(1280,720);
   myPort = new Serial(this, Serial.list()[5], 115200);
   restart();
}

void draw() {
    if (lives > 0) {
    
    if (gameMode == 0) {
      
      if (powerUpActivatedSeconds + 10 == passedSeconds) {
        //TODO: new method.
        playerRadius = 50;
        invincible = false;
      }
      
     passedSeconds = (millis() - savedTime)/1000;
      // Resize image.
     bg.resize(1280, 0);
     image(bg,0,0);
     
     readData();
     
     position.add(velocity);
     velocity.add(gravity);
    
    if (position.y > 640) {
      velocity.y =0;
    }
    
     playerYCoord = position.y;
     player = new Player(playerYCoord, playerRadius);  
     
     gf.moveAsteroids();
     
     player.playerSpeed();

     gf.randomAttacks();

     powerUp.bounce();
     
     screenElements();
    }
    
    // lost a life.
    if (gameMode == 1) {
       fill(255, 40, 40);
       text("Lost a life, Click A to continue", 10, 230);
        rect(0, 240, width, 7);
      
      asteroids.removeAll(asteroids);
      readData();
    }
   } else {
     clear();
     fill(255, 0, 0);
     text("You Lost, Click B to play again", 10, 230);
     rect(0, 240, width, 7);
     readData();
   }
}


void restart() {
    
    printArray(Serial.list());
    bg = loadImage("bg.jpeg");
    powerUpImg = loadImage("power.png");
    gf.initAsteroids(5);

    savedTime = millis();
   
    powerUp = new PowerUp(2);
  
    println("Starting");
}


void screenElements() {
    textSize(40); 
    fill(255, 204, 0);
    text("Seconds: "+(int)passedSeconds, 50, 80);
    text("Lives: "+(int) lives, 1100, 80);
    
    if (holdingPowerUp){
      powerUpImg.resize(50, 0);
      image(powerUpImg,1040,40);
    }
}


void readData() {
    inString = myPort.readString();  // read reading sent from microbit.
    if(inString != null) {
      
      if(inString.charAt(0) == 'A')  {
        aPressed = true;
        if (gameMode == 1) {
          gameMode = 0;
          lives--; // subtract a life.
          if (lives == 0) {
            redraw();
          }
        }
      }
      
      if(inString.charAt(0) == 'B')  {
        if (lives == 0) {
          println("Restarting game.");
          restart();
          lives = 3;
          asteroids.removeAll(asteroids);
          //holdingPowerUp = false;
          //holdingPowerType = 0;
          //powerUpActivatedSeconds = 0;

          //lives = 3;
        }
      }
      
      if(inString.charAt(0) == 'W')  {
        // if the player is holding a power up and its of a specified type, then handle the power up accordingly.
        if (holdingPowerUp && holdingPowerType != 0) {
           gf.handlePowerUp();
        }
      }
  }
}
