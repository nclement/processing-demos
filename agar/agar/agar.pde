Dot[] dots;
Dot[] food;

int count = 0;
int initialSize = 20;

int numFood = 50;
int foodSize = 10;

int numBots = 10;

color foodCol = color(255, 0, 0);
color myCol = color(0, 0, 255);

float minDist = 40;

int maxX = 1000;
int maxY = 760;
void setup() {
  size(1000, 760);
  background(0);
  
  food = new Dot[numFood];
  for (int i = 0; i < numFood; ++i) {
     food[i] = new Dot(foodCol); 
     food[i].increaseSize(-2);
  }
  
  // First dot is always the user.
  dots = new Dot[numBots + 1];
  dots[0] = new Dot(myCol);
  for (int i = 1; i <= numBots; ++i) {
    // new dots have random colors 
    dots[i] = new Dot(color(random(255), random(255), random(255)));
  }
  dots[0].increaseSize(-15);
}

void draw() {
  frameRate(20);
  background(0);
  fill(255);
  // First, draw all the food.
  for (int i = 0; i < food.length; ++i) {
    stroke(foodCol);
    ellipse(food[i].getX(), food[i].getY(), foodSize, foodSize); 
  }
  
  // Draw all the dots
  for (int i = 0; i < dots.length; ++i) {
    if (!dots[i].isDead()) {
      stroke(dots[i].getColor());
      //System.out.println(dots[i].getColor());
      ellipse(dots[i].getX(), dots[i].getY(), dots[i].getSize(), dots[i].getSize());
    }
  }
 
  // Move your dot toward the mouse pointer
  float dX = mouseX - dots[0].getX();
  float dY = mouseY - dots[0].getY();
  // Move a max of 1 in either direction
  float myMoveX = dX / Math.max(Math.abs(dY), Math.abs(dX));
  float myMoveY = dY / Math.max(Math.abs(dY), Math.abs(dX));
  dots[0].moveX(myMoveX);
  dots[0].moveY(myMoveY);
  /*
  if (myMoveX < 0) {
    dots[0].moveX(-1);
  } else if (myMoveX > 0) {
    dots[0].moveX(1);
  }
  if (myMoveY < 0) {
    dots[0].moveY(-1);
  } else if (myMoveY > 0) {
    dots[0].moveY(1);
  }
  */
  
  // Then, move all the bots
  for (int i = 1; i < dots.length; ++i) {
     dots[i].moveRandom();
  }
  
  int[] sizes = new int[dots.length];
  // Determine what gets eaten.
  for (int i = 0; i < dots.length; ++i) {
    if (dots[i].isDead()) continue;
    
    for (int j = 0; j < food.length; ++j) {
      if (dots[i].isCrossing(food[j])) {
        // Then move the food.
        food[j] = new Dot(foodCol);
        // Increase my size
        sizes[i]++;
      }
    }
     
    // Did I eat any other dots?
    for (int j = 0; j < dots.length; ++j) {
      // Gotta ignore yourself
      if (i == j) continue;
      // And ignore the other dot if it's dead
      if (dots[j].isDead()) continue;
      
      // See if we've eaten another dot
      if (dots[i].isCrossing(dots[j])) {
        dots[j].makeDead();
        // Add the devoured dot to your size.
        sizes[i] += dots[j].getSize() / initialSize;
      }
    }
  }
  
  // Change everyone's size
  for (int i = 0; i < dots.length; ++i) {
    dots[i].increaseSize(sizes[i]);
  }
  
  // Check if we're dead
  for (int i = 0; i < dots.length; ++i) {
    if (dots[i].isDead()) {
      if (i == 0) {
        System.out.println("I'm dead..." + count++);
      }
      dots[i].ticDead(); 
      dots[i].reset();
    }
  }
}