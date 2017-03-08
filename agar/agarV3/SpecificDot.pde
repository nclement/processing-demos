class Player extends Dot {
  public Player(color c) {
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
    double newMass = (1 - gradualLossPlayer) * mass();
    size = Math.sqrt(newMass/PI);
    
    // Don't get too small
    size = Math.max(size, initialPlayerSize);
  }
}
class SplitPlayer extends Player {
  public SplitPlayer(color c) {
    super(c);
  }
  
  public void ticDead() {
    // Do nothing, as I'll always remain dead.
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
    boolean otherAlive = false;
    for (int i = 0; i < player.length; ++i) {
      if (!player[i].isDead()) {
        otherAlive = true;
        break;
      }
    }
    
    // If someone is alive, just delete yourself.
    if (otherAlive) {
      makeDead();
    }
    else {
      x = random(maxX);
      y = random(maxY);
    }
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
    dotEatingIndex = Math.round(random(numFood + numBots));
  }
  
  public void reset() {
    size = initialSize;
    
    x = random(maxX);
    y = random(maxY);
    dotEatingIndex = Math.round(random(numFood + numBots));
  }
  
  public void move() {
    // With probability 0.8, move toward the target.
    if (random(1.0) > 0.2) {
      double dX, dY;
      // Kill the player if you're bigger
      if (getSize() > player[0].getSize() && random(1.0) >= 1) {
        dX = player[0].x; dY = player[0].y;
      } else {
        // otherwise, chase food or a bot
        if (dotEatingIndex < numFood) {
          dX = food[dotEatingIndex].x;
          dY = food[dotEatingIndex].y;
        } else {
          dX = food[dotEatingIndex - numFood].x;
          dY = food[dotEatingIndex - numFood].y;
        }
      }
      
      // Find the distance to your location
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
  
  // Gradually loses mass over time.
  public void passiveLoss() {
    // Reduce mass by .1% every time
    double newMass = (1 - gradualLossBot) * mass();
    size = Math.sqrt(newMass/PI);
    
    // Don't get too small
    size = Math.max(size, initialSize);
  }
}