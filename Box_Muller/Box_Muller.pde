int n_bucket = 100;

int hist_short = 200;
int hist_long = 800;
int main_dim = 800;
float xy_scale = 50;
int point_width = 4;

int x_hist_buckets[];
int y_hist_buckets[];

void setup() {
  size(1000,1000);
  colorMode(HSB, 255);
  background(255);
  
  x_hist_buckets = new int[n_bucket];
  y_hist_buckets = new int[n_bucket];
  
  stroke(0);
  fill(255);
  ellipse(main_dim/2, hist_short + main_dim/2, main_dim,main_dim);
}

/*
histogram on top: top 100 pixels
histogram on right: right 100 pixels
   h h h
  --------
  |      | h
  |      | h
  |      | h
  --------
*/
void draw() {
  if (mousePressed) {
    // Clear the histogram spaces 
    noStroke();
    fill(255);
    rect(0, 0, hist_long, hist_short);
    rect(hist_long, hist_short, hist_short, hist_long);
   
    print_hists();
  }
  
  float u1 = random(1);
  float u2 = random(1);
  float r = sqrt(-2*log(u1));
  float theta = 2*PI*u2;
  float x = r*cos(theta),
        y = r*sin(theta);
        
  // Need to scale x and y now
  x = x*xy_scale + main_dim/2;
  y = y*xy_scale + main_dim/2;
  float xpos = (x/(main_dim))*n_bucket;
  float ypos = (y/(main_dim))*n_bucket;
  x_hist_buckets[min((int)xpos, n_bucket-1)]++;
  y_hist_buckets[min((int)ypos, n_bucket-1)]++;
  
  fill(random(255), random(255), random(255));
  ellipse(x-point_width/2, hist_short + y-point_width/2, 
          point_width, point_width); 
  //println("x: " + x + " y: " + y + " " + xpos + " " + ypos);
}

void print_hists() {
  fill(160, 120, 120);
  float hist_width = main_dim/n_bucket;
  float xmx = max(x_hist_buckets);
  float ymx = max(y_hist_buckets);
  for (int i = 0; i < n_bucket; ++i) {
    rect(i*hist_width, hist_short-x_hist_buckets[i]/xmx*hist_short, hist_width, x_hist_buckets[i]/xmx*hist_short);
    rect(hist_long, hist_short+i*hist_width, y_hist_buckets[i]/ymx*hist_short, hist_width);
  }
}

int xmax() { return max(x_hist_buckets); }
int ymax() { return max(y_hist_buckets); }

int xsum() { return sum(x_hist_buckets); }
int ysum() { return sum(y_hist_buckets); }
int sum(int h[]) {
  int s = 0;
  for (int i = 0; i < n_bucket; ++i) {
    s += h[i];
  }
  return s;
}