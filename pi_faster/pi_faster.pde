int size = 400;
int denom;
double pi;
float[] diffs = new float[size];
int prevColor;
int[] colors = new int[size];

void setup() {
  size(400,400);
  colorMode(HSB, size);
  prevColor = 0;
  //GLStart();
  NStart();
}

void draw() {
  
  background(0);

  //GregoryLeibniz();
  Nilakantha();
  
  shift();
  
  //float d = sqrt(sq(PI - (float)pi));
  float d = PI - (float)pi; 
  diffs[size-1] = d;
  print(pi + " " + denom + " " + 4.0/(denom+2) + "\n");
  colors[size-1] = prevColor++;
  prevColor %= size;
  
  plot();
  
  noStroke();
  fill(255, 255, 255);
  rect(5, size-25, 170, 20);
  // //rect(size-130, size-25, 120, 20);
  fill(0, 0, 0);
  text("PI is " + pi, 10, size-10, 10);
  axis();
}

void shift() {
  for(int i = 1; i < size; i++) {
     diffs[i-1] = diffs[i];
     colors[i-1] = colors[i];
  }
}

void plot() {
  //double maxD = dMax();
  float maxD = max(diffs);
  float minD = min(diffs);
  
  for (int i = 0; i < size; i++) {
    stroke(colors[i], 200, 200);
    line(i, size, i, (float)(size- (diffs[i]-minD)/(maxD-minD) * size));
  } 
}

double dMax() {
  double m = 0;
  for(double d : diffs) {
    if (m > d) d = m;
  } 
  return m;
}

void axis() {
  fill(size, size, size);
  text("max: " + max(diffs), 5, 15);
  text("" + (max(diffs)-min(diffs))/2, 5, size/2);
  text("min: " + min(diffs), 5, size-30);
}

void GLStart() {
  pi = 4;
  denom = 3;
}
void GregoryLeibniz() {
  pi += -4.0/denom + 4.0/(denom+2);
  denom += 4;
}

void NStart() {
   pi = 3; 
   denom = 2;
}

void Nilakantha() {
  pi += 4.0/(denom*(denom+1)*(denom+2))
        - 4.0/((denom+2)*(denom+3)*(denom+4));
  denom += 4;
}