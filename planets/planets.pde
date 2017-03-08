// Classes are little objects you can mess with. I'm going to define
// a Planet class here, and then I can use it later. You can add 
// additional stuff to it (a member function that gives its color, for
// example), and create functions inside of it. For more or classes,
// see this page:
//   https://processing.org/reference/class.html
class Planet {
    // You can give a class "attributes", like x and y position, and size
    float x, y, size;
    
    // This is called the constructor. It's what happens whenever you say
    // something like Point p = new Point(6.0, 17.4, 5.3).
    Planet(float xPos, float yPos, float s) {
        x = xPos;
        y = yPos;
        size = s;
    }
    
    // These are some helper functions so you can get access to the details
    float getX() {
        return x;
    }
    float getY() {
        return y;
    }
    float getSize() {
        return size;
    }
    
    // These functions will actually change the values here
    void updatePosition(float newX, float newY) {
        x = newX;
        y = newY;    
    }
    void updateSize(float newSize) {
        size = newSize;
    }
}


// This is the same as a vector, but it's of type Planet.
// You can find more about ArrayLists here:
//    https://processing.org/reference/ArrayList.html
ArrayList<Planet> planets;

void setup() {  //setup function called initially, only once
  size(250, 250);
  background(0);  //set background white
  colorMode(HSB);   //set colors to Hue, Saturation, Brightness mode
  planets = new ArrayList<Planet>();

  // Instead of push_back, use add() for ArrayLists
  planets.add(new Planet(10, 50, 5));
  planets.add(new Planet(250, 170, 50));
  planets.add(new Planet(200, 70, 150));
}

void draw() {  //draw function loops 
  // This will just move all the planets in a random direction. You'll probably want
  // to do something more.
  for (int i = 0; i < planets.size(); i++) {
     float oldX = planets.get(i).getX();
     float oldY = planets.get(i).getY();
     int direction = int(random(8));
     if (direction == 0) { // move it up one
         oldX += 1;
     } else if (direction == 1) { // move it up and right
         oldX += 1;
         oldY += 1;
     } else if (direction == 2) { // move it right
         oldY += 1;
     } else if (direction == 3) { // move it down and right
         oldX -= 1;
         oldY += 1;
     } else if (direction == 4) { // move it down
         oldY -= 1;
     } else if (direction == 5) { // move it down and left
         oldX -= 1;
         oldY -= 1;
     } else if (direction == 6) { // move it left
         oldX -= 1;
     } else if (direction == 7) { // move it up and left
         oldX += 1;
         oldY -= 1;
     }
     
     // Since planets[i] is a Planet, you can call this function on it.
     planets.get(i).updatePosition(oldX, oldY);
  }
  
  // Now, re-draw all the planets
  background(0);  //set background black
  for (int i = 0; i < planets.size(); i++) {
      fill(random(256), random(256), 180);
      float size = planets.get(i).getSize();
      ellipse(planets.get(i).getX(), planets.get(i).getY(), size, size);
  }
}

void mousePressed() {
  
  float x = mouseX;
  float y = mouseY;
  float size = random(150);
  
  // Add a new planet at this point.
  planets.add(new Planet(x, y, size));
}
