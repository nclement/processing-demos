/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/188015*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/188015*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
int counter_in;
int counter_out;
int counter_total;
int radius;
int myX, myY;
int prev_time;

void setup() {  //setup function called initially, only once
  size(500, 500);
  radius = 500;
  background(255);  //set background white
  ellipse(0, 0, radius*2, radius*2);
  counter_in = 0;
  counter_out = 0;
  counter_total = 0;
  noStroke();
  prev_time = millis();
}

void draw() {  //draw function loops
  if(mousePressed == true) { //add some interaction
      
    stroke(0);
    noFill();
    ellipse(0, 0, radius*2, radius*2);

    noStroke();
    fill(255, 255, 255);
    rect(5, radius-25, 150, 20);
    rect(radius-130, radius-25, 120, 20);
    fill(0, 102, 153);
    text("PI is " + Float.toString((4*(float)counter_in/counter_total)), 10, radius-10, 10);
    text("Number of dots: " + Float.toString(counter_total), radius-130, radius-10, 10);
  }
  
  if (millis() - prev_time < 1) {
    return;
  }
  prev_time = millis();
  
  //print("Difference is", pow(QUARTER_PI - (float)counter_in/counter_total, 2), counter_in, counter_out, counter_total, QUARTER_PI, (float)counter_in/counter_total, "\n");
  
  noStroke();
  myX = int(random(radius));
  myY = int(random(radius));
  if (myX*myX + myY*myY > radius*radius) {
    int r = int(random(40));
    fill(230, 100, 120, 80);
    ellipse(myX, myY, r, r);
    counter_out++;
  } else {
    int r = int(random(40));
    fill(100, 180, 230, 80);
    ellipse(myX, myY, r, r);
    counter_in++;
  }
  counter_total ++;
}