float xPosition = random(800);
float yPosition = random(800);
float appleRadius = 20;
int appleCount = 0;

float bombXPosition = -1;
float bombYPosition = -1;
float bombRadius = 80;

int maxTime = 100;
int currentTime = 0;

void setup() {
  size(800, 800);
}

void draw() {
  frameRate(50);
  fill(0, 255, 0);
  ellipse(xPosition, yPosition, appleRadius*2, appleRadius*2);
  fill(0, 0, 255);
  textSize(18);
  text("Score: " + appleCount, 20, 30);
  currentTime++;
  
  if (bombXPosition + bombYPosition > 0) {
    fill(0, 0, 255, 40);
    ellipse(bombXPosition, bombYPosition, bombRadius * 2, bombRadius * 2);
  }
  
  if (currentTime > maxTime) {
    moveApple();
    background(120, 0, 0);
  }
  
}

void mousePressed() {
  float distance = sqrt(pow((mouseX - xPosition), 2) + pow((mouseY - yPosition), 2));
  if (distance <= appleRadius) {
    background(random(255));
    moveApple();
    appleCount++;
    maxTime -= 5;
  }
}

void keyPressed() {
  if (key == 'b') {
    bombXPosition = mouseX;
    bombYPosition = mouseY;
  }
  if (key == ' ') {
    float distance = sqrt(pow((bombXPosition - xPosition), 2) + pow((bombYPosition - yPosition), 2));
    if (distance <= bombRadius) {
      background(0, 0, random(255));
      moveApple(); 
      appleCount++;
      maxTime -= 5;
    } else {
      background(0); 
    }
    bombXPosition = -1;
    bombYPosition = -1;
    
  }
}

void moveApple() {
    xPosition = random(800);
    yPosition = random(800);
    currentTime = 0;
}