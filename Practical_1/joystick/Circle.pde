class Circle {
  float x;
  float y;
  float circleWidth;
  float circleHeight;

  public Circle(float x, float y, float circleWidth, float circleHeight) {
    this.x = x;
    this.y = y;
    this.circleWidth = circleWidth;
    this.circleHeight = circleHeight;
  }
  
  
  void show() {
    fill(255,0,0);
    ellipse(x,y,circleWidth, circleHeight);
    
    if (dist(posX, posY, x, y) <  2 + circle.circleWidth) {
      fill(255, 0,0);
      text("My circles are touching!", width/2, height/2);
      fill(255, 0, 0);
    }
  }
}
