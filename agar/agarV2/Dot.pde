class Dot {
  protected double size; // size, speed is related to size
  protected double x,y;  // position
  protected color c;
  protected int deadTime;
 
  public Dot(color c) {
    this.c = c;
    size = initialSize;
    deadTime = 0;
    x = random(1000);
    y = random(760);
  }
  
  public color getFill() {
    return 0;  
  }
  
  public void makeDead() {
    deadTime = 10; 
  }
  public void ticDead() {
    deadTime = Math.max(0, deadTime - 1);
  }
  public boolean isDead() {
     return deadTime > 0;
  }
  private boolean isNeighbor() {
    for (int i = 0; i < dots.length; ++i) {
      if (dist(dots[i]) < minDist) return true;
    }
    return false;
  }
  public void reset() {
    size = initialSize;
    
    x = random(maxX);
    y = random(maxY);
  }
  
  public double getSpeed() {
    //return Math.max(20.0/size, 1.0);
    return 1.0/Math.pow(size, 0.1);
  }
  
  public double mass() {
    return PI*size*size; 
  }
  // What to do when I eat another dot
  public void eat(Dot other) {
    // Increase size proportional to the mass of the other
    double newMass = mass() + other.mass();
    size = Math.sqrt(newMass/PI);
    size = Math.min(size, maxSize);
  } 
  
  public double getSize() {
    return size; 
  }
  
  public color getColor() {
    return c;
  }
  
  public double getX() {
    return x;
  }
  
  public double getY() {
    return y; 
  }
  
  /**
   * Functions for moving a dot
   */
  public void moveX(double i) {
    x += i * getSpeed();
    if (x >= maxX) x = maxX - 1;
  }
  public void moveY(double i) {
    y += i * getSpeed();
    if (y >= maxY) y = maxY - 1;
  }
  public void move() {
    // Does nothing
  }
  
  public void passiveLoss() {
    // Does nothing 
  }
  
  private double dist(Dot other) {
    return Math.sqrt(Math.pow((int)x - (int)other.x, 2.0) +
                            Math.pow((int)y - (int)other.y, 2.0));
  }
  public boolean canConsume(Dot other) {
    // If the distance to other dot's x,y is less than my size, I'm close to it.
    double dist = dist(other);
    if (dist < size/2.0) {
      // Can always eat food
      if (other instanceof Food) {
        return true; 
      }
      // I can consume if my mass is 25% larger than the other mass
      return mass() > 1.25 * other.mass();
    }
    return false;
  }
}