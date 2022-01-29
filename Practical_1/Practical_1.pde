PImage img;
Player player;
float playerYCoord = 640;
boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 5;

int lives = 3;
Asteroid[] asteroids;
Ufo[] ufos;
Obstacle[] obstacles;

PowerUp powerUp;

// Timer
int savedTime;
int passedSeconds;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
    initAsteroids(5);
    initUfos(1);
    initObstacles(1);
    savedTime = millis();
    
    powerUp = new PowerUp();
}

void draw() {
     passedSeconds = (millis() - savedTime)/1000;
     
     
      // Resize image.
     img.resize(1280, 0);
     image(img,0,0);
     
    
     
     moveAsteroids();
     moveUfos();
     moveObstacles();
     
     playerSpeed();
     
     player = new Player(playerYCoord);  
     
     randomAttacks();
     
     powerUp.bounce();
      
     screenElements();
}

void screenElements() {
    textSize(40); 
    text("Seconds: "+(int)passedSeconds, 50, 80);
    text("Lives: "+(int) lives, 1100, 80);
}

void playerSpeed() {
  if (mousePressed && playerYCoord > 20) {
      // Increase speed if mouse is pressed for a lot of time.
      if (sizeSpeed <= maxSpeed) {
         sizeSpeed = sizeSpeed * 1.08; // Increase speed incrementally
      }
      
      playerYCoord = playerYCoord - sizeSpeed; // increase player's speed.
      
     } else if (playerYCoord < 640) {
      playerYCoord = playerYCoord + sizeSpeed;;
    }
}

void mouseReleased() {
  // Reinstantiate sizeSpeed to original value.
  sizeSpeed = 4;
}

void randomAttacks() {
  
  // Every 600 frames generate an attack.
  if (frameCount % 600 == 0) {
        int attackNo = (int) random(1,5);
        
        switch(attackNo) {
          case 1:
            initAsteroids((int) random(3, min(passedSeconds/7, 40))); 
            initObstacles((int) random(1,10));
            break;
          case 2:
            initUfos((int) random(1, min(passedSeconds/7, 4)));  //TODO: make 2 or 3 different ufos.
            initObstacles((int) random(1,10));
            break;
          case 3:
            initAsteroids((int) random(3, min(passedSeconds/7, 40))); 
            initUfos((int) random(1, min(passedSeconds/5, 4)));  //TODO: make 2 or 3 different ufos.
            initObstacles((int) random(1,5));
            break;
          case 4:
            initObstacles((int) random(10,30));
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
     asteroids[i] = new Asteroid(random(1280, 2000), random(0, 720), random(5,60), random(5,60));
  }
}

void moveObstacles() {
   for(int i = 0; i < obstacles.length; i++) {
        obstacles[i].display();
        obstacles[i].move(random(1,10));
      }
}

void moveUfos(){
      for(int i = 0; i < ufos.length; i++) {
        ufos[i].display();
        ufos[i].move();
      }
}

void moveAsteroids(){
      for(int i = 0; i < asteroids.length; i++){
        if(asteroids[i].yCor > height) {
           asteroids[i].yCor = -10;
        }
        asteroids[i].display();
        asteroids[i].move(random(1, 10));
      }
}
 
