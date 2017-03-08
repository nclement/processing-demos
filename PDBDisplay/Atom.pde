public class Atom {
  private final double SCALE = 30;
  private final float SPHERE_SCALE = 5;
  private int x, y, z;
  AtomType type;
  ArrayList<Integer> connections;
  
  public Atom(double x, double y, double z, AtomType type) {
    this.x = (int)(x*SCALE);
    this.y = (int)(y*SCALE);
    this.z = (int)(z*SCALE);
    this.type = type;
    connections = new ArrayList<Integer>();
  }

  public Atom(double x, double y, double z, char atomC) {
    this.x = (int)(x*SCALE);
    this.y = (int)(y*SCALE);
    this.z = (int)(z*SCALE);
    switch(atomC) {
    case 'C':
      this.type = AtomType.CARBON;
      break;
    case 'H':
      this.type = AtomType.HYDROGEN;
      break;
    case 'N':
      this.type = AtomType.NITROGEN;
      break;
    case 'O':
      this.type = AtomType.OXYGEN;
      break;
    }
    
    connections = new ArrayList<Integer>();
  }

  public void setConnections(ArrayList<Integer> connections) {
    this.connections = connections;  
  }
  
  public void draw() {
    int size;
    color col;
    // Data from https://en.wikipedia.org/wiki/Atomic_radius
    switch(type) {
    case CARBON:
      size = 70;
      col = color(0, 0, 255); // blue
      break;
    case NITROGEN:
      size = 65;
      col = color(0, 255, 0); // green
      break;
    case OXYGEN:
      size = 60;
      col = color(255, 0, 0); // red
      break;
    case HYDROGEN:
      size = 25;
      col = color(255, 127, 80); // orange
      break;
    default: // ?? What to do?
      size = 50;
      col = color(0, 0, 0); // black
    }

    noStroke();
    fill(col);
    translate(x, y, z);
    sphere(size/SPHERE_SCALE);
    // then translate back
    translate(-x, -y, -z);
    //ellipse(x, y, size/SPHERE_SCALE, size/SPHERE_SCALE);
  }
  
  public void drawConnections(ArrayList<Atom> atoms) {
    stroke(0);
    for (Integer i : connections) {
      line(x, y, z, 
          atoms.get(i-1).x, atoms.get(i-1).y, atoms.get(i-1).z); 
    }
  }
  
  public String toString() {
    return "" + x + "," + y + "," + z + " with " + connections.size() + " connections"; 
  }
}