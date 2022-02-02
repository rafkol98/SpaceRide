import processing.serial.*;

PImage img;

// Initialise player.
Player player;
float playerYCoord = 640;
float playerXCoord = 80;
float playerRadius = 50;

boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 30;

boolean isCollided;

int lives = 3;
Asteroid[] asteroids;
Ufo[] ufos;
Obstacle[] obstacles;

// 
Serial myPort;
boolean aPressed;
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
    initUfos(1);
    initObstacles(1);
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
     player = new Player(playerYCoord);  
     
     moveAsteroids();
     moveUfos();
     moveObstacles();
     
     //playerSpeed();
     
     
     //if (!isCollided) {
      randomAttacks();
      //println(isCollided);
     //} else {
     //  println("collided");
     //}
     
     powerUp.bounce();
     screenElements();
}

void screenElements() {
    textSize(40); 
    text("Seconds: "+(int)passedSeconds, 50, 80);
    text("Lives: "+(int) lives, 1100, 80);
}

void playerSpeed() {
  if (aPressed && playerYCoord > 20) {
      // Increase speed if mouse is pressed for a lot of time.
      if (sizeSpeed <= maxSpeed) {
         sizeSpeed = sizeSpeed * 2; // Increase speed incrementally
         //println("NOW");
         myPort.write(15);
      }
      playerYCoord = playerYCoord - sizeSpeed; // increase player's speed.
     } else if (playerYCoord < 640 && sizeSpeed > 1) {
      playerYCoord = playerYCoord + (sizeSpeed/20);
    }
    aPressed = false;
}

//void mouseReleased() {
//  // Reinstantiate sizeSpeed to original value.
//  sizeSpeed = 4;
//}

void randomAttacks() {
  
  // Every 600 frames generate an attack.
  if (frameCount % 600 == 0) {
        int attackNo = (int) random(1,5);
        
        switch(attackNo) {
          case 1:
            initObstacles((int) random(1,3));
            initAsteroids((int) random(3, min(passedSeconds/7, 40)));
            break;
          case 2:
            initObstacles((int) random(1,3));
            initUfos((int) random(1, min(passedSeconds/7, 4)));  //TODO: make 2 or 3 different ufos.            
            break;
          case 3:
       
            initObstacles((int) random(1,3));
            initAsteroids((int) random(3, min(passedSeconds/7, 40))); 
            initUfos((int) random(1, min(passedSeconds/5, 4)));  //TODO: make 2 or 3 different ufos.
            break;
          case 4:
            initObstacles((int) random(3,5));
            break;
        }
    } 
}

void initObstacles(int num) {
   obstacles = new Obstacle[num];
  
  for (int i=0; i<obstacles.length; i++) {
     obstacles[i] = new Obstacle(random(1280, 2200), random(100,300), random(100,280));
  }
}

void initUfos(int num) {
  ufos = new Ufo[num];
 
  for(int i = 0; i < ufos.length; i++){
     ufos[i] = new Ufo(random(1280, 2000), random(0, 720));
  }
}

void initAsteroids(int num){
  asteroids = new Asteroid[num];
 
  for(int i = 0; i < asteroids.length; i++) {
     asteroids[i] = new Asteroid(random(1280, 2000), random(0, 720), random(5,60));
  }
}

void moveObstacles() {
   for(int i = 0; i < obstacles.length; i++) {
        obstacles[i].display();
        isCollided = obstacles[i].move(random(1,10));
      }
}

void moveUfos(){
      for(int i = 0; i < ufos.length; i++) {
        ufos[i].display();
        isCollided = ufos[i].move();
      }
}

void moveAsteroids(){
      for(int i = 0; i < asteroids.length; i++){
        if(asteroids[i].yPos > height) {
           asteroids[i].yPos = -10;
        }
        asteroids[i].display();
        isCollided = asteroids[i].move(random(1, 10));
      }
}

void readData() {
inString = myPort.readString(); 
    if(inString != null  ) {
       
       inString = inString.substring(1);
       inString = trim(inString);
       String[] list = split(inString, ";");
       // Check because sometime it does not transmit one value
       if ( list.length == 2) {
         try {
           playerYCoord = (int) map(Integer.parseInt(list[0]), -180, 180, 0, width); 
           Integer.parseInt(list[1]);
         } catch (NumberFormatException e) {
           println("Exception");
         }
        println(inString);
       }
    
    
  }
}

//void serialEvent(Serial p) { 
//  inString = p.readString(); 
//  if(inString != null) {
//    print(inString);
//    aPressed = true;
//  }
//} 
 
