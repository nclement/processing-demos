import java.util.*;
import java.io.*;
import java.net.*;


// There's 128 characters in the ASCII table, so set that here.
public static final int totalCounts = 128;
int[] counts;
// Set this to zero at the beginning
int maxCount = 0;

// Make these global variables so we can access them later.
Scanner infile;
boolean infileValid = false; // This should be set to false at the beginning.
// If we're using the IMDB database, we need to do some special things.
boolean usingIMDB = false;

// Use Courier-Bold for the font
PFont courier_bold;

void setup() {
  size(600, 600);
  counts = new int[totalCounts];
  try {
    String IMDBUrl = "http://www.cs.utexas.edu/~nclement/cs312/in_class/ratings.list";
    String nonIMDB = "https://www.gutenberg.org/files/2600/2600-0.txt";
    infile = new Scanner(new URL(nonIMDB).openStream());
    if (usingIMDB) {
      // Ignore the header
      infile.nextLine();
    }
    
    System.out.println("is coo");
    // If we set this here, it means we can actually read the file.
    infileValid = true;
  }
  catch(FileNotFoundException e) {
    System.out.println("Error: File not found!");
    infileValid = false;
  }
  catch(MalformedURLException e) {
    System.out.println("Your URL is wrong: " + e.getMessage());
    infileValid = false;
  }
  catch(IOException e) {
    System.out.println("What?? " + e.getMessage());
    infileValid = false;
  }
  
  courier_bold = createFont("Courier-Bold", 16);
}

void draw() {
  // Keep going until we hit the end of the file.
  // Also make sure the infile is valid.
  if (infileValid && infile.hasNextLine()) {
    String line = infile.nextLine();
    String movie;
    if (usingIMDB) {
      Scanner lineScan = new Scanner(line);
      
      int numVotes = lineScan.nextInt();
      double rating = lineScan.nextDouble();
      movie = lineScan.nextLine();
    } else {
      movie = line; 
    }
    
    // Loop over the movie name, and add each character to our histogram
    // Make sure to do three things:
    // 1. Start with i = 1, because the first character is a space
    // 2. Keep track of the max count; so each time you add to the array,
    //    check if it's the max.
    // 3. Sometimes we get weird characters. So if you see something
    //    that has a value greater than the max value, set it to be zero.
    for (int i = 1; i < movie.length(); ++i) {
      char at = movie.charAt(i);
      if (at >= totalCounts) {
        at = 0;
      }
      counts[at]++;
      if (counts[at] > maxCount) {
        maxCount = counts[at];
      }
    } 
  } else {
    infileValid = false;
    System.out.println("Finished!"); 
  }
  
  // Turn off the stroke
  noStroke();
  // Make sure you "redraw" the rectangles
  background(255);
  float rectWidth = width/totalCounts;
  // Loop over each of the counts
  int summedCount = 0;
  for (int i = 0; i < totalCounts; ++i) {
    summedCount += counts[i];
    // Our color is going from blue to red
    fill(255.0/totalCounts*i, 0, 255 - 255.0/totalCounts*i);
    // Rectangle from the top
    rect(i*rectWidth, 0.0, rectWidth, (float)counts[i]/maxCount*height);
  }
  
  updateMouse(maxCount, summedCount);
}

void updateMouse(int maxCount, int summedCount) {
  // Get the location of the mouse (which bar it corresponds with)
  float rectWidth = width / totalCounts;
  int histBar = (int)(mouseX / rectWidth);
 
  if (mouseY < ceil((float)counts[histBar] / maxCount * height)) {
    fill(0);
    textFont(courier_bold);
    // write the letter at this position
    text(String.format("[%c]: %d=%.2f%%", (char)histBar, counts[histBar], (float)counts[histBar]/summedCount*100),
         mouseX + 10, mouseY + 10); 
  //} else if (histBar > 20 && histBar < 100) {
  //  System.out.printf("%d not less than %f\n", mouseY, (float)counts[histBar] / maxCount * height);  
  }
}