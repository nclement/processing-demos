import java.util.*;

class PDBUtils {
  public String fn;
  
  public PDBUtils(String fn) {
    this.fn = fn;
  }
  
  private Atom getAtom(String line) {
    Scanner lineScan = new Scanner(line);
    // ignore the first few things
    lineScan.next(); // ATOM
    lineScan.next(); // Index
    char atomType = lineScan.next().charAt(0);
    lineScan.next(); // Chain
    lineScan.next(); // resi
    double x = lineScan.nextDouble();
    double y = lineScan.nextDouble();
    double z = lineScan.nextDouble();
    
    return new Atom(x, y, z, atomType);
  }
  
  private void parseConnect(String line, ArrayList<Atom> atoms) {
    Scanner lineS = new Scanner(line);
    lineS.next(); // ignore CONECT
    int from = lineS.nextInt();
    ArrayList<Integer> to = new ArrayList<Integer>();
    while(lineS.hasNext()) {
      to.add(lineS.nextInt());
    }
    
    // Now, add it to the atom.
    atoms.get(from - 1).setConnections(to);
  }
  
  public ArrayList<Atom> getAtoms() {
    ArrayList<Atom> atoms = new ArrayList<Atom>();
    try {
      Scanner inf = new Scanner(new File(fn));
      while(inf.hasNextLine()) {
        String line = inf.nextLine();
        Scanner lineS = new Scanner(line);
        String type = lineS.next();
        if (type.equals("ATOM") || type.equals("HETATM")) {
          atoms.add(getAtom(line));        
        }
        // Should be after all atoms have come.
        else if (type.equals("CONECT")) {
          parseConnect(line, atoms);
        }
      }
    }
    catch(IOException e) {
      print("Could not open file! " + e.getMessage()); 
    }
    
    return atoms;
  }
}