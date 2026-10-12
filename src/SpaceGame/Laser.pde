class Laser {
  // Member Variables
  int x, y, w, h, speed;
  

  // Constructor
  Laser(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    w = 8;
    h = 12;
    this.speed = speed;
  }

  // Member Methods
  void display() {
    fill(0, 0, 255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move() {
    y = y - speed;
  }

  boolean isOffScreen() {
    if (y<-15) {
      return true;
    } else {
      return false;
    }
  }

  // add isHit()
}
