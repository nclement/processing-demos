
float totalSurfaceArea = 0;
  
void setup(){
  size(800, 600);
  background(255);
}

// Keep drawing balloons until the surface area > 10,000
void draw() {
  frameRate(100);
  
  //if (totalSurfaceArea <= 100000) {
    float balloonSize = random(20, 50);
    //drawBalloon(random(800), random(600), balloonSize, random(60, 120), 
    //        color(random(255), random(255), random(255), 100));
    drawBalloon(mouseX, mouseY, balloonSize, random(60, 120), 
            color(0, 0, random(255), 30));
    
    // Surface area is 4*pi*r^2
    float r = balloonSize / 2;
    float surf = 4 * PI * r * r;
    totalSurfaceArea += surf;
  //}
}

void mousePressed() {
  background(random(255), random(255), random(255));  
}

void drawBalloon (float x, float y, float balloonSize, float lineHeight, color c){
  // Set the fill color to the value passed in
  fill(c);
  noStroke();
  // Draws a circle at point (x,y) with diameter balloonSize
  ellipse(x, y, balloonSize, balloonSize);
  // Draw a line from the center of the balloon
  //line(x,y+balloonSize/2, x,y+balloonSize/2 + lineHeight);
}

void drawPopsicle(float x, float y, float balloonSize, float lineHeight, color c){
  // Set the fill color to the value passed in
  fill(c);
  // Draws a circle at point (x,y) with diameter balloonSize
  //ellipse(x, y, balloonSize, balloonSize);
  rect(x,y, balloonSize, balloonSize*1.25, balloonSize/3);
  // Draw a line from the center of the balloon
  //line(x,y+balloonSize/2, x,y+balloonSize/2 + lineHeight);
  line(x+balloonSize/2,y+balloonSize*1.25, x+balloonSize/2,y+balloonSize*1.25 + lineHeight);
}