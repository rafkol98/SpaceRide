PImage img;
Player player;
int playerYCoord = 100;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
  
    
}

void draw() {
     img.resize(1280, 0);
     image(img,0,0);
     
     color c = color(255, 204, 0); 
     player = new Player(playerYCoord, c);
     
}

void mouseDragged(){
  if(mouseY <= 600){
    playerYCoord = mouseY;
  }
 
}
