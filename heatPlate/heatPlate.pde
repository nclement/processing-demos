boolean isRunning = false;
boolean isFinished = false;
String runningText = "Start";

int count = 0;

int xgrid_size = 500, ygrid_size = 500;
int xsize = 100, ysize = 100;
int cell_size = 5;
float temp_now[][];
float temp_next[][];

int minTemp = 0;
int maxTemp = 100;
int startTemp = 80;

void setup() {
  size(500, 500);
  background(0, 0, 0);
  noStroke();
  temp_now = new float[xsize][ysize];
  temp_next = new float[xsize][ysize];
  for (int i = 0; i < xsize; i++) {
    for (int j = 0; j < ysize; j++) {
      temp_now[i][j] = startTemp; 
    }
  }
  
  drawStartPause();
  //randomizeBoard();
  //drawBoard();
}

void drawStartPause() {
  fill(255, 255, 255);
  rect(0, 0, 70, 30);
  fill(0, 102, 153);
  text(runningText, 20, 20);
  fill(255, 255, 255);
  rect(0, 31, 70, 30);
  fill(0, 102, 153);
  text("Randomize", 5, 50);
}

void drawBoard() {
  color blue = color(0, 0, 255);
  //color blue = color(255, 255, 255);
  color red = color(255, 0, 0);
  for(int i = 0; i < xsize; ++i) {
    for(int j = 0; j < ysize; ++j) {
       
       float perc = (float)temp_now[i][j]/maxTemp;
       color c = lerpColor(blue, red, perc);
       fill(c);
       
       rect(i*cell_size, j*cell_size, cell_size, cell_size);
       //ellipse(i*cell_size-cell_size/2, j*cell_size-cell_size/2, cell_size, cell_size);
    }
  }
}

void setStatic() {
  for (int i = 0; i < xsize; i++) {
    for (int j = 0; j < ysize; j++) {
      if (isMax(i, j)) {
        temp_now[i][j] = maxTemp; 
      }
      if (isMin(i, j)) {
        temp_now[i][j] = minTemp; 
      }
    }
  }
}

boolean isMax(int i, int j) {
  if ( (i < 5 && j < 5) ||
       (xsize - i < 5 && ysize - j < 5) ||
       (i < 5 && ysize - j < 5) ||
       (xsize - i < 5 && j < 5) ) {
    return true; 
  }
  
  return false;
}

boolean isMin(int i, int j) {
  //if ( (i < 2 && j == ysize/2) ||
  if ( (j == ysize/2) ||
       (i == xsize/2 && j < 2) ||
       (i == xsize/2 && j > ysize - 1 - 2) ||
       (i > xsize - 1 - 2 && j == ysize/2)) {
        return true; 
  }
  
  return false;
}

void setColors() {
  for (int i = 1; i < xsize - 1; i++) {
    for (int j = 1; j < ysize - 1; j++) {
      // find average
       float t = (temp_now[i-1][j] + 
                    temp_now[i+1][j] +
                    temp_now[i][j-1] +
                    temp_now[i][j+1]) / 4.0;
       temp_next[i][j] = t;
    }
  }
  
  // Update everything
  boolean rfin = true;
  float changed = 0;
  float minChange = 1;
  float maxChange = 0;
  for (int i = 0; i < xsize; i++) {
    for (int j = 0; j < ysize; j++) {
      if (!isMin(i,j) && !isMax(i,j)) {
        float change = Math.abs(temp_now[i][j] - temp_next[i][j]);
        if (change > 0.01)
          rfin = false;
        minChange = Math.min(minChange, change);
        maxChange = Math.max(maxChange, change);
        changed += change;
      }
      temp_now[i][j] = temp_next[i][j];
    }
  }
  
  if (rfin && count > 1) {
    isFinished = true; 
  }
  System.out.printf("Changed by %f and min,max is %.2f,%.3f\n", changed, minChange, maxChange);
}

void draw() {
  if (!isFinished) {
    runningText = "Start " + count;
    count++;
    setColors();
    setStatic();
    drawBoard();
    drawStartPause();
  } else {
    runningText = "Finished in " + count + " steps";
    drawStartPause();
  }
}