import processing.serial.*;

PImage img;

// Initialise player.
Player player;
float playerYCoord = 640;
float playerXCoord = 80;
float playerRadius = 50;

color playerColor = color(255, 204, 0); 

// Gravity
PVector position = new PVector(playerXCoord, playerYCoord); 
PVector velocity = new PVector(0, 0);
PVector gravity = new PVector(0, 0.10);
PVector jump = new PVector(0, -2);

boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 50;

boolean isCollided;

int lives = 3;
ArrayList<Asteroid> asteroids;

// Port for serial.
Serial myPort;

boolean aPressed;
boolean whistle;
String inString;

PowerUp powerUp;

// Timer
int savedTime;
int passedSeconds;

void setup() {
    size(1280,720);
    printArray(Serial.list());
    img = loadImage("bg.jpeg");
    initAsteroids(5);

    savedTime = millis();
   
    powerUp = new PowerUp();
    
    myPort = new Serial(this, Serial.list()[5], 115200);
    println("Starting");
    
}

void draw() {
     passedSeconds = (millis() - savedTime)/1000;
      // Resize image.
     img.resize(1280, 0);
     image(img,0,0);
     readData();
     
    position.add(velocity);
    velocity.add(gravity);
    
    if (position.y > 640) {
      velocity.y =0;
    }
    
       //position.y = min(position.y, 640);
     playerYCoord = position.y;
     player = new Player(playerYCoord, playerColor);  
     
     moveAsteroids();
     
     playerSpeed();

     randomAttacks();

     powerUp.bounce();
     screenElements();
}

void screenElements() {
    textSize(40); 
    fill(255,0,0);
    text("Seconds: "+(int)passedSeconds, 50, 80);
    text("Lives: "+(int) lives, 1100, 80);
    
}

void playerSpeed() {
  if (aPressed && playerYCoord > 20) {
    velocity.add(jump);
    
}
    aPressed = false;
}


void randomAttacks() {
  
  // Every 600 frames generate an attack.
  if (frameCount % 600 == 0) {
        initAsteroids((int) random(3, min(passedSeconds/7, 40)));

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
         if (dist(playerXCoord, playerYCoord, asteroid.xPos, asteroid.yPos) <  10 + asteroid.radius) {
          fill(255);
          text("My circles are touching!", width/2, height/2);
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        
        if(asteroid.yPos > height) {
           asteroid.yPos = -10;
        }
        asteroid.move(random(1, 10));
        asteroid.display();
        
      }
}

void readData() {
inString = myPort.readString(); 
    if(inString != null  ) {
       
      if(inString.charAt(0) == 'A')  {
        aPressed = true;
      }
      
      if(inString.charAt(0) == 'W')  {
        whistle = true;
        playerColor = color(random(1,255), random(1,255), random(1,255));
      }
  }
}
