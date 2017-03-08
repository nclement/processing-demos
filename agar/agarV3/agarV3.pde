Dot[] player;
Dot[] bots;
Dot[] food;

int maxPlayerSplit = 16;

int count = 0;
int initialSize = 20;
int initialPlayerSize = 15;
int foodSize = 8;
int maxSize = 100;

double gradualLossPlayer = 0.001;
double gradualLossBot = 0.0002;

// Can't split below this size
double minSplitSize = 20;

int numFood = 200;

int numBots = 20;

color foodCol = color(255, 0, 0);
color myCol = color(0, 0, 255);

float minDist = 40;

int maxX = 1000;
int maxY = 760;
void setup() {
  size(1000, 760);
  background(255);
  
  // Generate the food
  food = new Dot[numFood];
  for (int i = 0; i < numFood; ++i) {
     food[i] = new Food(foodCol); 
  }
  
  // First dot is always the user.
  player = new Dot[maxPlayerSplit];
  player[0] = new Player(myCol);
  for (int i = 1; i < maxPlayerSplit; ++i) {
    player[i] = new SplitPlayer(myCol);
    // Kill everyone but the first one.
    player[i].makeDead();
  }
  
  // Generate the bots
  bots = new Dot[numBots];
  for (int i = 0; i < numBots; ++i) {
    // new bots have random colors 
    bots[i] = new Bot(color(random(255), random(255), random(255)));
  }
}

void keyPressed() {
  if (key == ' ') {
    handleSplit();
  }
}


void handleSplit() {
  // Count up the number of 'alive' players
  double totalMass = 0;
  int count = 0;
  for (int i = 0; i < player.length; ++i) {
    if (!player[i].isDead() && player[i].getSize() > minSplitSize) {
      count++;
      totalMass += player[i].mass();
    }
  }
    
  double newMass = totalMass / (count*2);
    
  // Now, make a bunch more dots that are alive
  // Get the position
  double midX = player[0].getX();
  double midY = player[0].getY();
    
  int rebirthed = 0;
  for (int i = 0; i < player.length; ++i) {
    if (player[i].isDead() && rebirthed < count) {
      player[i] = new Player(myCol);
      rebirthed++;
      player[i].setPos(midX + random((float)player[0].getSize()),
                       midY + random((float)player[0].getSize()));
    }
      
    // Make sure to set the mass for all players to be the same.
    player[i].setMass(newMass);
  }
}

void draw() {
  frameRate(60);
  background(255);
  
  // Display your score in the corner
  fill(0, 102, 153);
  textSize(12);
  //text("size: " + dots[0].getSize(), maxX - 180,  130, 80, 30);
  text(String.format("size: %.2f", player[0].getSize()), 20,  20);
  
  fill(255);
  // First, draw all the food.
  for (int i = 0; i < food.length; ++i) {
    stroke(foodCol);
    ellipse((float)food[i].getX(), (float)food[i].getY(), 
            (float)foodSize, (float)foodSize); 
  }
  
  // Then, draw all the bots
  for (int i = 0; i < bots.length; ++i) {
    if (!bots[i].isDead()) {
      stroke(bots[i].getColor());
      fill(bots[i].getFill());
      //System.out.println(dots[i].getColor());
      ellipse((float)bots[i].getX(), (float)bots[i].getY(), 
               (float)bots[i].getSize(), (float)bots[i].getSize());
    }
  }
  
  // Then, draw all the player dots
  for (int i = 0; i < player.length; ++i) {
    if (!player[i].isDead()) {
      stroke(player[i].getColor());
      fill(player[i].getFill());
      //System.out.println(dots[i].getColor());
      ellipse((float)player[i].getX(), (float)player[i].getY(), 
               (float)player[i].getSize(), (float)player[i].getSize());
    }
  }
  
  // Then, move all the bots
  for (int i = 0; i < bots.length; ++i) {
     bots[i].move();
  }
  // and the user
  for (int i = 0; i < player.length; ++i) {
     player[i].move();
  }
  
  // Eat food first with the player
  eatFood(player);
  // then with the bots.
  eatFood(bots);
  
  // Player kill bots
  dotsEatDots(player, bots);
  // Bots kill player
  dotsEatDots(bots, player);
  // Bots kill other bots
  dotsEatDots(bots, bots);
  
  // Passive loss for all
  passiveLoss(player);
  passiveLoss(bots);
  
  // Check if we're dead
  checkIfDead(player);
  checkIfDead(bots);
}

void eatFood(Dot[] dots) {
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
  }
}

void dotsEatDots(Dot[] p, Dot[] other) {
  for (int i = 0; i < p.length; ++i) {
    // Ignore if dead.
    if (p[i].isDead()) continue;
    
    // Did I eat any other dots?
    for (int j = 0; j < other.length; ++j) {
      // Gotta ignore yourself
      if (p[i] == other[j]) continue;
      // And ignore the other dot if it's dead
      if (other[j].isDead()) continue;
      
      // See if we've eaten another dot
      if (p[i].canConsume(other[j])) {
        // Add the devoured dot to your size.
        p[i].eat(other[j]);
        // Then kill the dot.
        other[j].makeDead();
      }
    }
  }
}

void checkIfDead(Dot[] dots) {
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

void passiveLoss(Dot[] dots) {
  // Also, do the passive loss thing
  for (int i = 0; i < dots.length; ++i) {
    if (!dots[i].isDead()) {
      dots[i].passiveLoss(); 
    }
  } 
}