boolean isRunning = false;
String runningText = "Start";

int xgrid_size, ygrid_size;
int xsize, ysize;
int cell_size = 10;
boolean living_now[][];
boolean living_next[][];

void setup() {
  size(2000, 1000);
  xgrid_size = width;
  ygrid_size = height;
  xsize = width/cell_size;
  ysize = height/cell_size;
  background(0, 0, 0);
  noStroke();
  living_now = new boolean[xsize][ysize];
  living_next = new boolean[xsize][ysize];
  
  drawStartPause();
  //randomizeBoard();
  drawLiving();
}

void randomizeBoard() {
  for (int i = 0; i < xsize; ++i) {
    for (int j = 0; j < ysize; ++j) {
      if (random(1) > 0.9) {
         living_now[i][j] = true; 
      } else {
        //living_now[i][j] = false;
      }
    }
  }
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

void drawLiving() {
  for(int i = 0; i < xsize; ++i) {
    for(int j = 0; j < ysize; ++j) {
       if (isCorner(i*cell_size, j*cell_size))
         continue;
       if (living_now[i][j]) {
         fill(0, 102, 153);
         //rect(i*cell_size-cell_size/2, j*cell_size-cell_size/2, cell_size, cell_size);
         ellipse(i*cell_size-cell_size/2, j*cell_size-cell_size/2, cell_size, cell_size);
       }
    }
  }
}

int numLiving(int cellX, int cellY) {
  int neighborsX[] = new int[9];
  int neighborsY[] = new int[9];
  
  neighborsX[0] = cellX-1;
  neighborsX[1] = cellX-1;
  neighborsX[2] = cellX-1;
  neighborsX[3] = cellX;
  neighborsX[4] = cellX;
  neighborsX[5] = cellX;
  neighborsX[6] = cellX+1;
  neighborsX[7] = cellX+1;
  neighborsX[8] = cellX+1;
  
  if (cellX == 0) {
     neighborsX[0] = xsize-1;
     neighborsX[1] = xsize-1;
     neighborsX[2] = xsize-1;
  } else if (cellX == xsize-1) {
     neighborsX[6] = 0;
     neighborsX[7] = 0;
     neighborsX[8] = 0;
  }
  
  // Set all Y's
  neighborsY[0] = cellY-1;
  neighborsY[3] = cellY-1;
  neighborsY[6] = cellY-1;
  neighborsY[1] = cellY;
  neighborsY[4] = cellY;
  neighborsY[7] = cellY;
  neighborsY[2] = cellY+1;
  neighborsY[5] = cellY+1;
  neighborsY[8] = cellY+1;
 
  if (cellY == 0) {
     neighborsY[0] = ysize-1;
     neighborsY[3] = ysize-1;
     neighborsY[6] = ysize-1;
  } else if (cellY == ysize-1) {
     neighborsY[2] = 0;
     neighborsY[5] = 0;
     neighborsY[8] = 0;
  }
  
  /*
  if (living_now[cellX*xsize + cellY]) {
    
    for (int i = 0; i < 3; ++i) {
     for (int j = 0; j < 3; ++j) {
        print(living_now[(cellX+i-1)*xsize + cellY+j-1]);
     }
     print(",");
    }
    print("\n");
  
    print("nbs of", cellX, cellY, ": ");
    for (int i = 0; i < 9; ++i) {
      print(living_now[neighborsX[i]*xsize+neighborsY[i]], ";");
    }
    print("\n");
  }
  */
  
  // Check for neighbors
  int neighborCount = 0;
  for (int i = 0; i < 9; ++i) {
     if (i == 4) continue;
     if (living_now[neighborsX[i]][neighborsY[i]]) neighborCount++;
  }
  return neighborCount; 
}

void clearLiving(boolean l[][]) {
  for (int i = 0; i < xsize; ++i) {
    for (int j = 0; j < ysize; ++j) {
      l[i][j] = false; 
    }
  }

}

void setLiving() {
  clearLiving(living_next);
  for (int i = 0; i < xsize; ++i) {
    for (int j = 0; j < ysize; ++j) {
      int nc = numLiving(i, j);
      if (living_now[i][j]) {
        if (nc < 2) {
          //print("Dead, neighbors is", nc);
          living_next[i][j] = false;
        } else if (nc > 3) {
          //print("Dead, neighbors is", nc);
          living_next[i][j] = false;
        } else { //2 or 3 lives on to the next generation
          living_next[i][j] = true;
        }
      } else {
        if (nc == 3) {
          living_next[i][j] = true;
        }
      }
    }
  }
  
  // Once done calculating everything, set the next round to this round
  for (int i = 0; i < xsize; ++i) {
    for (int j = 0; j < ysize; ++j) {
      living_now[i][j] = living_next[i][j]; 
    }
  }
}

void draw() {
  // Do something
  background(10, 10, 0);
  if (isRunning) {
    setLiving();
  }
  
  drawLiving();
  drawStartPause();
}

// Is the box for corner?
boolean isCorner(int x, int y) {
  if (0 <= x && x <= 70
      && 0 <= y && y <= 30)
      return true;
  return false;
}

// Is the box for Randomize?
boolean isRandom(int x, int y) {
  //rect(0, 31, 70, 30);
  if (0 <= x && x <= 70
      && 31 <= y && y <= 61) {
    return true;      
  }
  return false;
}

void mousePressed() {
  if (isCorner(mouseX, mouseY)) {
    if (isRunning) {
      isRunning = false;
      runningText = "Start";
    } else {
      isRunning = true;
      runningText = "Pause";
    }
    drawStartPause();
  } else if (isRandom(mouseX, mouseY)) {
    print("Doing random...");
    randomizeBoard();
  } else {
    int arrPosX = (mouseX + cell_size/2)/cell_size;
    int arrPosY = (mouseY + cell_size/2)/cell_size;
    
    if (living_now[arrPosX][arrPosY]) {
       living_now[arrPosX][arrPosY] = false;
    } else {
       living_now[arrPosX][arrPosY] = true; 
    }
  }
}