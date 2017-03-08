// This sketch can only read your finger position limited to the size of the window
// move your finger left and right to go up and down in pitch, respectively
// move your finger up and down to increase and decrease loudness


import processing.sound.*;
//SawOsc saw;
SinOsc saw;
//TriOsc saw;
//SqrOsc saw;
Float upperHz, lowerHz, multiplier;
void setup() {
  size(1000, 500);

// frequency is limited to lowerHz - upperHz
// set lowerHZ/upperHz to anything you want, human hearing is limited to 20 to 20,000 Hz
   lowerHz = 20.0;
   upperHz = 2000.0;
   
   multiplier = upperHz/width;
   
  // Create square wave oscillator.
  //saw = new SawOsc(this);
  saw = new SinOsc(this);
  //saw = new TriOsc(this);
  //saw = new SqrOsc(this);
  saw.play();
}

void draw() {
  Float volume = ((float)height - mouseY)/height;
  saw.amp(volume);
  saw.freq(lowerHz+mouseX*multiplier);
}