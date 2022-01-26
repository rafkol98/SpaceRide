PImage img;
Player player;

void setup() {
    size(1280,720);
    img = loadImage("bg.jpeg");
    color c = color(255, 204, 0); 
    player = new Player(100, c);
}

void draw() {
     img.resize(1280, 0);
     image(img,0,0);
     
}
