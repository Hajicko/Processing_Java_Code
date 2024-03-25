PShape svg; 

void setup() {
  size(400, 400);
  // Load the SVG file
  svg = loadShape("TopOfGiftBox_V2.svg");
  
  //e-4 a 14.399224,10.184446 0 0 0 -14.04279,-7.933769 z
  
  //e-4 a 13.66315,9.4479442 0 0 0 -13.32498,-7.360158 z
  
}

void draw() {
  background(255);
  // Draw the SVG at position (0, 0)
  shape(svg, 0, 0);
}
