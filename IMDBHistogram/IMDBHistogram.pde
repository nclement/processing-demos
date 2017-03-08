import java.util.*;
import java.io.*;
import java.net.*;

// TODO: How many should totalCounts be???
int totalCounts = -1;
int[] counts;
// TODO: What should maxCount be??
int maxCount = 10;

// Make these global variables so we can access them later.
Scanner infile;
boolean infileValid = false;

float screenWidth = 600;
float screenHeight = 600;

void setup() {
  size(600, 600);
  counts = new int[totalCounts];
  try {
    // Can also read from a file!!
    String IMDBUrl = "http://www.cs.utexas.edu/~nclement/cs312/in_class/ratings.list";
    infile = new Scanner(new URL(IMDBUrl).openStream());
    // Ignore the header
    infile.nextLine();

    // Make sure we set this so it's valid.
    System.out.println("is cool");
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
}

void draw() {
  if (infileValid && infile.hasNextLine()) {
    String line = infile.nextLine();
    Scanner lineScan = new Scanner(line);

    // Ignore the number of votes and the rating
    int numVotes = lineScan.nextInt();
    double rating = lineScan.nextDouble();
    // The movie is everything at the end of the line
    String movie = lineScan.nextLine();
    // Loop over the movie name, and add each character to our histogram
    // Make sure to do three things:
    // 1. Start with i = 1, because the first character is a space
    // 2. Keep track of the max count; so each time you add to the array,
    //    check if it's the max.
    // 3. Sometimes we get weird characters. So if you see something
    //    that has a value greater than the max value, set it to be zero.
    for (int i = 1; i < movie.length(); ++i) {
      // TODO: Fill me out!!
    } 
  } else {
    System.out.println("Finished!"); 
  }

  // TODO: Plot each character with a rectangle falling from the sky.
}