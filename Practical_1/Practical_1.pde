import processing.serial.*;

PImage bg, powerUpImg;

GameFlow gf = new GameFlow();

int posX;
int posY;

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

Wormhole wormhole;

ArrayList<Ant> antArray = new ArrayList<>();
ArrayList<Ant> newantArray = new ArrayList<>();
color c = color(random(255), random(255), random(255));

void setup() {
    posX = 0;
    posY = 0;
   size(1280,720);
   myPort = new Serial(this, Serial.list()[5], 115200);
   restart();
   
   for(int i=0; i<3; i++) {
     antArray.add(new Ant(random(0,1000), random(0,230), c));
     antArray.add(new Ant(random(0,1000), random(580,720), c));
  }
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
     
     gf.moveWormhole();
     
     player.playerSpeed();

     gf.randomAttacks();

     powerUp.bounce();
     
     screenElements();
    } else if (gameMode == 1) {
       fill(255, 40, 40);
       text("Lost a life, Click A to continue", 10, 230);
        rect(0, 240, width, 7);
      
      asteroids.removeAll(asteroids);
      readData();
    } else if (gameMode == 2) {
       //clear();
       background(30,30,30);
       
       for (Ant ant : antArray) {
         newantArray.add(new Ant(ant.x+2, ant.y+2,c));
        ant.walk();
       
       }
       
       for (Ant ant : newantArray) {
            ant.walk(); 
       }


       text("WORMHOLE", 10, 230);
       
       color ballColor = color(255, 0, 0);
       
       readData();
       
       fill(ballColor);
       noStroke();
       ellipse(posX, posY, 50, 50);
       
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
    text("Seconds: "+(int)passedSeconds, 50, 80);
    text("Lives: "+(int) lives, 1100, 80);
    
    if (holdingPowerUp){
      powerUpImg.resize(50, 0);
      image(powerUpImg,1040,40);
    }
}


void readData() {
    //println("called");
    inString =  myPort.readStringUntil('\n');  // read reading sent from microbit.

  //// read the data until the newline n appears
  //String inString =
    if(inString != null) {
          //println(inString);
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
          asteroids.removeAll(asteroids);
          restart();
          lives = 3;
        }
      } 
      
      if(inString.charAt(0) == 'W')  {
        // if the player is holding a power up and its of a specified type, then handle the power up accordingly.
        if (holdingPowerUp && holdingPowerType != 0) {
           gf.handlePowerUp();
        }
      } 
      
      if(inString.charAt(0) =='Y')  {
         println("mesa Y");
         try {
          int yStrPos = inString.indexOf("Y");
          int sepPos = inString.indexOf(";");
          println(yStrPos+" | "+sepPos);
          println(inString);
          posY = (int) map(Integer.parseInt(inString.substring(1,sepPos)), 0, 1023, 0, height);
          println("PosY"+ posY);

 
        } catch(Exception e) {
          println("caught");
        }
      }
      
      if(inString.charAt(0)=='X') {
        println("mesa X");
        try {
          int sepPos = inString.indexOf(";");
          posX = (int) map(Integer.parseInt(inString.substring(1,sepPos)), 0, 1023, 0, width);
         println("PosX"+ posX); 
        } catch(Exception e) {
          println("caught"+posX);
        }
      }
      
  }
}
