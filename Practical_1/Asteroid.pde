class Asteroid {
  
  // Initialise Asteroid variables.
  float x;
  float y;
  float radius;

  /**
   Create a new asteroid. Passing in the x, y coordinates and the radius.
   **/
  Asteroid(float x, float y, float r) {
    this.x = x;
    this.y = y;
    radius= r;
  }

  /**
   Move asteroid to the left.
   **/
  void move(float speed) {
    x -= speed;
  }

  /**
   Display asteroid.
   **/
  void display() {
    fill(150, 102, 20);
    stroke(10);
    circle(x, y, radius);
  }
}
