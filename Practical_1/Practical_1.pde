PImage img;
Player player;
float playerYCoord = 640;
boolean up = false;
float sizeSpeed = 1;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
  
    
}

void draw() {
     img.resize(1280, 0);
     image(img,0,0);
     
   
     println(sizeSpeed);
     
     if (mousePressed) {
      sizeSpeed = sizeSpeed * 1.02;
      //speed 
      playerYCoord = playerYCoord - sizeSpeed;
      
     } else if (playerYCoord < 640) {
      playerYCoord++;
    }
     
     color c = color(255, 204, 0); 
     player = new Player(playerYCoord, c);      
}



void mouseReleased() {
  // Reinstantiate sizeSpeed to original value.
  sizeSpeed = 1;
}

 
