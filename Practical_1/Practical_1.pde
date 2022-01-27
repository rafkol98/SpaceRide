PImage img;
Player player;
float playerYCoord = 640;
boolean generateAst = true;
float sizeSpeed = 1;
float maxSpeed = 5;
Asteroid[] asteroids;
Ufo ufo;

// Timer
int savedTime;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
    initAsteroids(5);
    savedTime = millis();
    ufo = new Ufo(random(1280, 2000), random(0, 720));
}

void draw() {
      // Resize image.
     img.resize(1280, 0);
     image(img,0,0);
     
     moveAsteroids();
     
     ufo.walk();
     
     if (mousePressed && playerYCoord > 20) {
      // Increase speed if mouse is pressed for a lot of time.
      if (sizeSpeed <= maxSpeed) {
         sizeSpeed = sizeSpeed * 1.02; // Increase speed incrementally
      }
      
      playerYCoord = playerYCoord - sizeSpeed; // increase player's speed.
      
     } else if (playerYCoord < 640) {
      playerYCoord = playerYCoord + sizeSpeed;;
    }
     
     player = new Player(playerYCoord);  
     
     generateAsteroids();
     
}

void generateAsteroids() {
  // Calculate seconds passed.
     int passedSeconds = (millis() - savedTime)/1000;
     println(passedSeconds);
     if (passedSeconds % 10 == 0) {
       if (generateAst) {
         initAsteroids((int) random(passedSeconds/20, 20));
         generateAst = false;
       }
     } else {
       generateAst = true;
     }
     
}


void mouseReleased() {
  // Reinstantiate sizeSpeed to original value.
  sizeSpeed = 2;
}


void initAsteroids(int num){
  asteroids = new Asteroid[num];
 
  for(int i = 0; i < asteroids.length; i++){
     float x = random(1280, 2000);
     float y = random(0, 720);
     asteroids[i] = new Asteroid(x, y, random(5,60), random(5,60));
  }
}

void moveAsteroids(){
      for(int i = 0; i < asteroids.length; i++){
        if(asteroids[i].yCor > height){
           asteroids[i].yCor = -10;
        }
        asteroids[i].display();
        asteroids[i].move(random(1, 10));
      }
}
 
