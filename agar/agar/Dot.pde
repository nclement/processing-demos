class Dot {
  private int dotEatingIndex; // The dot it will be chasing (food, other bot, or player--in that order)
  private int size; // size, speed is related to size
  private float x,y;  // position
  private color c;
  private int deadTime;
 
  public Dot(color c) {
    this.c = c;
    size = initialSize;
    deadTime = 0;
    x = random(1000);
    y = random(760);
    dotEatingIndex = Math.round(random(numFood + numBots + 1));
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
    dotEatingIndex = Math.round(random(numFood + numBots + 1));
    
    x = random(maxX);
    y = random(maxY);
  }
  
  public float getSpeed() {
    return Math.max(20.0/size, 1.0); 
  }
  
  public void increaseSize(int i) {
    size += i;
  } 
  public int getSize() {
    return size; 
  }
  
  public color getColor() {
    return c;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y; 
  }
  
  /**
   * Functions for moving a dot
   */
  public void moveX(float i) {
    x += i * getSpeed();
    if (x >= maxX) x = maxX - 1;
  }
  public void moveY(float i) {
    y += i * getSpeed();
    if (y >= maxY) y = maxY - 1;
  }
  public void moveRandom() {
    // With probability 1/2, move toward the target.
    if (random(1.0) > 0.5) {
      float dX, dY;
      if (dotEatingIndex == (numFood + numBots + 1)) {
        dX = dots[0].x; dY = dots[0].y;
      } else if (dotEatingIndex >= numFood) {
        dX = dots[dotEatingIndex - numFood].x;
        dY = dots[dotEatingIndex - numFood].y;
      } else {
        dX = food[dotEatingIndex].x;
        dY = food[dotEatingIndex].y;
      }
      // Decrement your location.
      dX -= x;
      dY -= y;
      // Move a max of 1 in either direction
      float myMoveX = dX / Math.max(Math.abs(dY), Math.abs(dX));
      float myMoveY = dY / Math.max(Math.abs(dY), Math.abs(dX));
      moveX(myMoveX);
      moveY(myMoveY);
    } else {
      // Otherwise, just move in a random location.
      moveX(random(-1.0, 1.0));
      moveY(random(-1.0, 1.0));
    }
     
  }
  
  private double dist(Dot other) {
    return Math.sqrt(Math.pow((int)x - (int)other.x, 2.0) +
                            Math.pow((int)y - (int)other.y, 2.0));
  }
  public boolean isCrossing(Dot other) {
    // If the distance to other dot's x,y is less than my size, I'm crossing.
    double dist = dist(other);
    if (dist < size/2.0 && size > other.size) {
      return true; 
    }
    return false;
  }
}