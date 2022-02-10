import processing.serial.*;

int posX;
int posY;

//ArrayList<Integer> valuesXTry;
//ArrayList<Integer> valuesYTry;

ArrayList<Ant> antArray = new ArrayList<>();
ArrayList<Ant> newantArray = new ArrayList<>();

//int xmeow = 0;
//int ymeow = 0;

// The serial port.
Serial myPort;
String inString;
color ballColor = color(255, 204, 0);

// Timer
int savedTime;
int passedSeconds;

Circle circle;

//ArrayList<Circle> circles = new ArrayList<Circle>();
       color c = color(random(255), random(255), random(255));
void setup() {
    

 size(1000, 720);
   
 printArray(Serial.list());
 // Open the port you are using at the rate you want:
  //valuesXTry = new ArrayList<>();
  //valuesYTry = new ArrayList<>();
  posX = 0;
  posY = 0;

  circle = new Circle(50,80, 40, 40);
  

  myPort = new Serial(this, Serial.list()[5], 115200);
  println("Starting");
   savedTime = millis();
   
   for(int i=0; i<3; i++) {

     antArray.add(new Ant(random(0,1000), random(0,230), c));
     antArray.add(new Ant(random(0,1000), random(580,720), c));
  }

}

void draw() {
     background(30,30,30);
  for (Ant ant : antArray) {
         newantArray.add(new Ant(ant.xPos+2, ant.yPos+2,c));
        ant.walk();
       
   }
   
   for (Ant ant : newantArray) {
         //newantArray.add(new Ant(ant.xPos+2, ant.yPos+2,c));
        ant.walk();
       
   }

  //findAndRemoveMin();
  savedTime = millis();
  
  if(savedTime%100 == 0) {
      //myPort.write("R");
  }

   //readData();
   fill(ballColor);
   noStroke();
   
   //(int) valuesYTry.stream().mapToInt(val -> val).average().orElse(posY)
   //ellipse((int) valuesXTry.stream().mapToInt(val -> val).average().orElse(posX), height/2, 20, 20);
   ellipse(posX, posY, 50, 50);
   
   circle.show();
   
    
   
}


// data support from the serial port
void serialEvent(Serial myPort) 
{
  //// read the data until the newline n appears
  String val = myPort.readStringUntil('\n');
  
  if(val!=null) {
      if(val.charAt(0)=='X') {
        try {
          int sepPos = val.indexOf(";");
          posX = (int) map(Integer.parseInt(val.substring(1,sepPos)), 0, 1023, 0, width);
          
        } catch(Exception e) {
          println("caught"+posX);
        }
      }
      
       if(val.charAt(0)=='Y') {
         try {
          int sepPos = val.indexOf(";");
          posY = (int) map(Integer.parseInt(val.substring(1,sepPos)), 0, 1023, 0, height);
          //valuesYTry.add(y);
 
        } catch(Exception e) {
          //println("caught");
        }
      }
}
}
