class PlayerDot extends Dot {
  public PlayerDot(color c) {
    super(c);
    
    size = initialPlayerSize;
  }
  
  public color getFill() {
    return c;
  }
  
  public void reset() {
    size = initialPlayerSize;
    
    x = random(maxX);
    y = random(maxY);  
  }
  
  public void move() {
    // Move your dot toward the mouse pointer
    double dX = mouseX - x;
    double dY = mouseY - y;
    // Move a max of 1 in either direction
    double myMoveX = dX / Math.max(Math.abs(dY), Math.abs(dX));
    double myMoveY = dY / Math.max(Math.abs(dY), Math.abs(dX));
    moveX(myMoveX);
    moveY(myMoveY);
  }
  
  // Gradually loses mass over time.
  public void passiveLoss() {
    // Reduce mass by .1% every time
    double newMass = 0.999 * mass();
    size = Math.sqrt(newMass/PI);
    
    // Don't get too small
    size = Math.max(size, initialPlayerSize);
  }
}

class Food extends Dot {
  public Food(color c) {
    super(c);
    
    size = foodSize;
  }
  
  public color getFill() {
    return foodCol; 
  }
  
  // Do nothing
  public void move() {
    return;
  }
  
  // Always return food size
  public double getSize() {
    return foodSize; 
  }
  
  /**
   * Food will never be "crossing" another dot (it will never consume it)
   */
  public boolean isCrossing(Dot other) {
    return false; 
  }
  
  public void reset() {
    size = foodSize;
    x = random(maxX);
    y = random(maxY);
  }
  
  public void passiveLoss() {
    // Does nothing 
  }
}

class Bot extends Dot {
  private int dotEatingIndex; // The dot it will be chasing (food, other bot, or player--in that order)

  public Bot(color c) {
    super(c);
    
    size = initialSize;
    dotEatingIndex = Math.round(random(numFood + numBots + 1));
  }
  
  public void reset() {
    size = initialSize;
    
    x = random(maxX);
    y = random(maxY);
    dotEatingIndex = Math.round(random(numFood + numBots + 1));
  }
  
  public void move() {
    // With probability 1/2, move toward the target.
    if (random(1.0) > 0.2) {
      double dX, dY;
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
      double myMoveX = dX / Math.max(Math.abs(dY), Math.abs(dX));
      double myMoveY = dY / Math.max(Math.abs(dY), Math.abs(dX));
      moveX(myMoveX);
      moveY(myMoveY);
    } else {
      // Otherwise, just move in a random location.
      moveX(random(-1.0, 1.0));
      moveY(random(-1.0, 1.0));
    } 
  }
}