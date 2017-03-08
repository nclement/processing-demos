float x;
 
// Define some colors to use.
color red = color(255, 0, 0);
color blue = color(0, 0, 255);
 
void setup() {  //setup function called initially, only once
  size(500,500,P3D);
  background(255);  //set background white
  x = 0;
}
 
/**
 * Helper function that adjusts a single point by this amount, specified as
 * 100. If you want your shapes to be bigger, increase this number.
 */
int adjVal(double x) {
  return (int)(x*100);
}
 
/**
 * Helper function that takes an x, y, and z and returns an array of new
 * values that have been adjusted by a specified amount
 */
int[] adjAll(double x, double y, double z) {
  int[] newVals = new int[3];
  newVals[0] = adjVal(x);
  newVals[1] = adjVal(y);
  newVals[2] = adjVal(z);
  return newVals;
}
 
/**
 * Function that makes it easier to draw a 3d vertex.
 * Given an array of locations, a size, and a color, draw the vertex.
 */
void drawVertex(int[] loc, int size, color c) {
  pushMatrix();
  translate(loc[0], loc[1], loc[2]);
  stroke(c);
  sphere(size);
  popMatrix();
}
 
void draw() {  //draw function loops
  background(255);
  // The translate function allows us to draw things as if the screen was centered
  // with (0,0,0) in the middle.
  translate(width/2, height/2, 0);
  // Each time, rotate along the x-axis slightly.
  rotateX(x*PI/360);
  x++;
  // Lines are black
  stroke(0);
  // No fill
  fill(120);
   
  // Start our shape.
  beginShape();
  
  int[] adjPts;
  // Starting at C1, draw the first half of the molecule, each time coming
  // back to C1 to create a complete shape.
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.481017657,  0.900917516, -1.159901318); // H1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(1.020840268,  -0.034909846,  -1.159773509); // H2
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.540462446,  -0.867553544,  -1.159247542); // H3
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  endShape();
   
  beginShape();
  // Once the first half is done, join up with C2 and start the second half.
  adjPts = adjAll(0.000135749,  0.000316366,  0.753067743); // C2
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(0.540462446,  0.867553544,  1.159247542); // H4
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(0.000135749,  0.000316366,  0.753067743); // C2
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(0.481017657,  -0.900917516,  1.159901318); // H5
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(0.000135749,  0.000316366,  0.753067743); // C2
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-1.020840268,  0.034909846,  1.159773509); // H6
  vertex(adjPts[0], adjPts[1], adjPts[2]);
   
  // And finish it by coming back to C2 and finally C1.
  adjPts = adjAll(0.000135749,  0.000316366,  0.753067743); // C2
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  vertex(adjPts[0], adjPts[1], adjPts[2]);
  // End of shape.
  endShape();
   
  // Now, draw the spheres
  adjPts = adjAll(-0.000135749,  -0.000316366,  -0.753067743); // C1
  drawVertex(adjPts, 10, red);
  adjPts = adjAll(0.000135749,  0.000316366,  0.753067743); // C2
  drawVertex(adjPts, 10, red);
  adjPts = adjAll(-0.481017657,  0.900917516, -1.159901318); // H1
  drawVertex(adjPts, 5, blue);
  adjPts = adjAll(1.020840268,  -0.034909846,  -1.159773509); // H2
  drawVertex(adjPts, 5, blue);
  adjPts = adjAll(-0.540462446,  -0.867553544,  -1.159247542); // H3 
  drawVertex(adjPts, 5, blue);
  adjPts = adjAll(0.540462446,  0.867553544,  1.159247542); // H4
  drawVertex(adjPts, 5, blue);
  adjPts = adjAll(0.481017657,  -0.900917516,  1.159901318); // H5
  drawVertex(adjPts, 5, blue);
  adjPts = adjAll(-1.020840268,  0.034909846,  1.159773509); // H6
  drawVertex(adjPts, 5, blue);
}