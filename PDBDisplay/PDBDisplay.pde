// This boolean value is set to false in setup() because otherwise we'll try and draw our 
// atoms when they're not in existence.
boolean isValid;
// An ArrayList of atoms
ArrayList<Atom> atoms;

// This x value is for plotting in 3d. You don't need to change it; I've
// done everything to make it work.
float x;

// The required setup function.
void setup() {
  // In your size function, include a third argument that tells Processing to use 3d
  size(500, 500, P3D);
  // Make sure to set this to false, otherwise it will break.
  isValid = false;
  
  // Here's how you call the file selector function. The first parameter is the text
  // that is displayed in the file selector. The second parameter is the name of the
  // function that should be called with the result.
  selectInput("Select a file to process:", "fileSelected");
  
  // Sets x to be zero here (any value is okay)
  x = 0;
  
  scale(10);
}

// This function is called after the sure has selected a valid value.
void fileSelected(File selection) {
  // Make sure they didn't press cancel or close the window
  // You could also check here to make sure the file ends in a .pdb suffix (how?)
 if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    // Success! Now, get the information from this file.
    println("User selected " + selection.getAbsolutePath());
    PDBUtils pb = new PDBUtils(selection.getAbsolutePath());
    atoms = pb.getAtoms();
    // Once the atoms have been set up, set this to be true so the program knows
    // when to draw it.
    isValid = true;
    
    /*
    for (Atom a : atoms) {
      println(a); 
    }
    */
  }
}

// Draw function.
void draw() {
  background(255);
  /* The next couple of lines of code deal with rotating in 3d. Don't change them. */
  // The translate function allows us to draw things as if the screen was centered
  // with (0,0,0) in the middle.
  translate(width/2, height/2, 0);
  // Each time, rotate along the x-axis slightly.
  rotateX(x*PI/360);
  x++;
  /* End don't change code */
  
  // If the atoms are not valid, quit early.
  if (!isValid) return;
  
  // Now, draw each atom and its connections.
  for (Atom a : atoms) {
    a.draw();
    a.drawConnections(atoms);
  }
}