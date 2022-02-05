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


void setup() {
    size(1280,720);
    printArray(Serial.list());
    bg = loadImage("bg.jpeg");
    powerUpImg = loadImage("power.png");
    gf.initAsteroids(5);

    savedTime = millis();
   
    powerUp = new PowerUp(2);
    
    myPort = new Serial(this, Serial.list()[5], 115200);
    println("Starting");
}

void draw() {
    if (lives > 0) {
      
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
      }
      
      if(inString.charAt(0) == 'W')  {
        // if the player is holding a power up and its of a specified type, then handle the power up accordingly.
        if (holdingPowerUp && holdingPowerType != 0) {
           gf.handlePowerUp();
        }
      }
  }
}
