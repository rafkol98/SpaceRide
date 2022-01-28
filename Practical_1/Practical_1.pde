PImage img;
Player player;
float playerYCoord = 640;
boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 5;
Asteroid[] asteroids;
Ufo[] ufos;

// Timer
int savedTime;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
    initAsteroids(5);
    initUfos(1);
    savedTime = millis();
}

void draw() {
      // Resize image.
     img.resize(1280, 0);
     image(img,0,0);
     
     moveAsteroids();
     moveUfos();

     
     playerSpeed();
     
     player = new Player(playerYCoord);  
     
     randomAttacks();
     
}

public void playerSpeed() {
  if (mousePressed && playerYCoord > 20) {
      // Increase speed if mouse is pressed for a lot of time.
      if (sizeSpeed <= maxSpeed) {
         sizeSpeed = sizeSpeed * 1.02; // Increase speed incrementally
      }
      
      playerYCoord = playerYCoord - sizeSpeed; // increase player's speed.
      
     } else if (playerYCoord < 640) {
      playerYCoord = playerYCoord + sizeSpeed;;
    }
}

public void randomAttacks() {
  int passedSeconds = (millis() - savedTime)/1000;

  // Every 10 seconds generate an attack.
  if (frameCount % 600 == 0) {
         int attackNo = (int) random(1,3);
        println(attackNo);
     
        switch(attackNo) {
          case 1:
            initAsteroids((int) random(1, min(passedSeconds/5, 30))); 
            break;
          case 2:
            initUfos((int) random(1, min(passedSeconds/5, 4)));  //TODO: make 2 or 3 different ufos.
            break;
          case 3:
            initAsteroids((int) random(1, min(passedSeconds/5, 30))); 
            initUfos((int) random(1, min(passedSeconds/5, 4)));  //TODO: make 2 or 3 different ufos.
            break;
        }
    } 
}


void mouseReleased() {
  // Reinstantiate sizeSpeed to original value.
  sizeSpeed = 2;
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

void moveUfos(){
      for(int i = 0; i < ufos.length; i++) {
        ufos[i].display();
        ufos[i].walk();
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
 
