import java.util.Scanner;
import java.io.*;

int screenWidth = 1200;
int screenHeight = 600;

void setup() {
  background(0);
  size(1200, 600);
  try {
    // Get the number of temperatures in our file.
    int numTemps = getNumTemps("/Users/nclement/Documents/texas/teaching/aces/in_class/javaII/campmabry_tmax_1015_F.txt");
    
    // Actually read the file
    Scanner inputer = new Scanner(new File("/Users/nclement/Documents/texas/teaching/aces/in_class/javaII/campmabry_tmax_1015_F.txt"));
    double[] temps = new double[numTemps];
    
    double sum = 0;
    int count = 0;
    while (inputer.hasNextDouble()) {
      double d = inputer.nextDouble();
      temps[count] = d;
      count++;
    }
    plotTemps(temps);
        
    System.out.println("Average temp is: " + sum/count);
  }
  catch(FileNotFoundException e) {
    System.out.println("Oops... File not found? " + e.getMessage()); 
  }
}

int getNumTemps(String file) throws FileNotFoundException {
  Scanner inputer = new Scanner(new File(file));
  int count = 0;
  while (inputer.hasNextDouble()) {
    inputer.nextDouble();
    count++; 
  }
  inputer.close();
  return count;
}

double getAvg(double[] arr){
  double sum = 0;
  for(int i = 0; i < arr.length; i++){
    sum += arr[i];
  }
  double avg = (sum/arr.length);
  return avg;
}
double getMin(double[] arr){
  double min = 200;
  for(int i = 0; i <arr.length; i ++){
    if(arr[i] < min){
      min = arr[i];
    }
  }
  return min;
}

double getMax(double[] arr) {
  double max = 0;
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] > max) {
      max = arr[i]; 
    }
  }
  return max;
}



void plotTemps(double[] arr) {
  // Turn off the stroke.
  noStroke();
  // Save these variables for later
  double avgTemp = getAvg(arr);
  double maxTemp = getMax(arr);
  double minTemp = getMin(arr);
  // We want each rectangle to be this wide
  float rectWidth = (float)screenWidth/arr.length;
  
  // Low color
  color blue = color(0, 0, 255);
  //color white = color(255, 255, 255);
  color white = #B9B9B9;
  color red = color(255, 0, 0);
  
  // Now, print all the rectangles
  for (int i = 0; i < arr.length; i++) {
    double d = arr[i];
    
    if (d > avgTemp) {
      // How far are we from the average?
      float span = (float)((d-avgTemp)/(maxTemp-avgTemp));
      
      // Create a color that's between red and white.
      color c = lerpColor(white, red, span);
      fill(c);
    } else {
      // How far are we from the average?
      float span = (float)((avgTemp-d)/(avgTemp-minTemp));
      
      // Create a color that's between blue and white.
      color c = lerpColor(white, blue, span);
      fill(c);
    }
    d = d / maxTemp * screenHeight;
    rect((float)i * rectWidth, (float)(screenHeight - d), rectWidth, (float)d); 
  }
}