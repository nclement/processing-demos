Dot[] dots;
Dot[] food;

int count = 0;
int initialSize = 20;
int initialPlayerSize = 15;
int foodSize = 8;
int maxSize = 100;

int numFood = 300;

int numBots = 20;

color foodCol = color(255, 0, 0);
color myCol = color(0, 0, 255);

float minDist = 40;

int maxX = 1000;
int maxY = 760;
void setup() {
  size(1000, 760);
  background(255);
  
  food = new Dot[numFood];
  for (int i = 0; i < numFood; ++i) {
     food[i] = new Food(foodCol); 
  }
  
  // First dot is always the user.
  dots = new Dot[numBots + 1];
  dots[0] = new PlayerDot(myCol);
  for (int i = 1; i <= numBots; ++i) {
    // new bots have random colors 
    dots[i] = new Bot(color(random(255), random(255), random(255)));
  }
}

void draw() {
  frameRate(100);
  background(255);
  
  // Display your score in the corner
  fill(0, 102, 153);
  textSize(12);
  //text("size: " + dots[0].getSize(), maxX - 180,  130, 80, 30);
  text(String.format("size: %.2f", dots[0].getSize()), 20,  20);
  
  fill(255);
  // First, draw all the food.
  for (int i = 0; i < food.length; ++i) {
    stroke(foodCol);
    ellipse((float)food[i].getX(), (float)food[i].getY(), 
            (float)foodSize, (float)foodSize); 
  }
  
  // Draw all the dots
  for (int i = 0; i < dots.length; ++i) {
    if (!dots[i].isDead()) {
      stroke(dots[i].getColor());
      fill(dots[i].getFill());
      //System.out.println(dots[i].getColor());
      ellipse((float)dots[i].getX(), (float)dots[i].getY(), 
               (float)dots[i].getSize(), (float)dots[i].getSize());
    }
  }
  
  // Then, move all the bots (and user, too)
  for (int i = 0; i < dots.length; ++i) {
     dots[i].move();
  }
  
  // Determine what gets eaten.
  for (int i = 0; i < dots.length; ++i) {
    // ignore yourself if you're dead
    if (dots[i].isDead()) continue;
    
    for (int j = 0; j < food.length; ++j) {
      if (dots[i].canConsume(food[j])) {
        // First, eat the food.
        dots[i].eat(food[j]);
        
        // Then move the food.
        food[j] = new Food(foodCol);
      }
    }
     
    // Did I eat any other dots?
    for (int j = 0; j < dots.length; ++j) {
      // Gotta ignore yourself
      if (i == j) continue;
      // And ignore the other dot if it's dead
      if (dots[j].isDead()) continue;
      
      // See if we've eaten another dot
      if (dots[i].canConsume(dots[j])) {
        // Add the devoured dot to your size.
        dots[i].eat(dots[j]);
        // Then kill the dot.
        dots[j].makeDead();
      }
    }
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
  
  // Also, do the passive loss thing
  for (int i = 0; i < dots.length; ++i) {
    if (!dots[i].isDead()) {
      dots[i].passiveLoss(); 
    }
  }
}