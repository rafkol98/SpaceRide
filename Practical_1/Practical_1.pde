PImage img;
Player player;
float playerYCoord = 640;
boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 5;
Asteroid[] asteroids;

// Timer
int savedTime;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
    initAsteroids(0, 720, 5);
    savedTime = millis();
    
      
}

void draw() {
      // Resize image.
     img.resize(1280, 0);
     image(img,0,0);
     
     moveAsteroids();
     
     if (mousePressed && playerYCoord > 20) {
      // Increase speed if mouse is pressed for a lot of time.
      if (sizeSpeed <= maxSpeed) {
         sizeSpeed = sizeSpeed * 1.02; // Increase speed incrementally
      }
      
      playerYCoord = playerYCoord - sizeSpeed; // increase player's speed.
      
     } else if (playerYCoord < 640) {
      playerYCoord++;
    }
     
     player = new Player(playerYCoord);  
     
     // Calculate seconds passed.
     int passedSeconds = (millis() - savedTime)/1000;
     println(passedSeconds);
     if (passedSeconds % 10 == 0) {
       if (generateAst) {
         initAsteroids(0, 720, passedSeconds);
         generateAst = false;
       }
     } else {
       generateAst = true;
     }
     
     
    
     
}



void mouseReleased() {
  // Reinstantiate sizeSpeed to original value.
  sizeSpeed = 1;
}


void initAsteroids(int yMin, int yMax, int num){
  asteroids = new Asteroid[num];
 
  for(int i = 0; i < asteroids.length; i++){
     int x = (int)random(1280, 2000);
     int y = (int)random(yMin, yMax);
     asteroids[i] = new Asteroid(x, y, (int) random(5,30), (int) random(5,30));
  }
}

void moveAsteroids(){
      for(int i = 0; i < asteroids.length; i++){
        if(asteroids[i].yCor > height){
           asteroids[i].yCor = -10;
        }
        asteroids[i].display();
        asteroids[i].drop(random(1, 10));
      }
}
 
