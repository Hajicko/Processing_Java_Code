

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Box(float PosX, float PosY, float PosZ, float Width, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    box(Width);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Sphere(float PosX, float PosY, float PosZ, float Width, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    strokeWeight(StrokeWeight);
    //stroke(StrokeCol);
    noStroke();
    fill(FillCol);
    sphere(Width);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Rect(float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, float Width, float Height, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    
    rect(0, 0, Width, Height);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Ellipse(float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, float Width, float Height, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    
    ellipse(0, 0, Width, Height);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Arc(float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, float Width, float Height, float ArcSize, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    
    arc(0, 0, Width, Height, 0, ArcSize, PIE);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Text(String SText, float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, int TextSize, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    fill(FillCol);
    textSize(TextSize);
    
    text(SText, 0, 0);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Line(float PosX1, float PosY1, float PosZ1, float PosX2, float PosY2, float PosZ2, int StrokeWeight, color StrokeCol) {
    
  strokeWeight(StrokeWeight);
  stroke(StrokeCol);
  
  line(PosX1, PosY1, PosZ1, PosX2, PosY2, PosZ2);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Point(float PosX, float PosY, float PosZ, int StrokeWeight, color StrokeCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    
    point(0, 0, 0);
  popMatrix();
  
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Triangle(float PosX1, float PosX2, float PosX3, float PosZ1, float PosZ2, float PosZ3, float PosY, float RotX, float RotY, float RotZ, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX1, PosY, PosZ1);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    
    triangle(PosX1, PosZ1, PosX2, PosZ2, PosX3, PosZ3);
  popMatrix();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void TexturedCube(float CbX, float CbY, float CbZ, float CbXW, float CbH, float CbZW, PImage Texture, int CbSw, color CbSCol, color CbFCol, int Type) 
{
  strokeWeight(CbSw);
  stroke(CbSCol);
  
  beginShape(QUADS);
  if (Type == 0)
    texture(Texture);
  else
  {
    fill(CbFCol);
  }
  
    // +Z "front" face
    vertex(CbX, CbY, CbZ +CbZW);
    vertex(CbX +CbXW, CbY, CbZ +CbZW);
    vertex(CbX +CbXW, CbY -CbH, CbZ +CbZW);
    vertex(CbX, CbY -CbH, CbZ +CbZW);
    
    // -Z "front" face
    vertex(CbX, CbY, CbZ);
    vertex(CbX +CbXW, CbY, CbZ);
    vertex(CbX +CbXW, CbY -CbH, CbZ);
    vertex(CbX, CbY -CbH, CbZ);
    
    // +X "front" face
    vertex(CbX +CbXW, CbY, CbZ);
    vertex(CbX +CbXW, CbY, CbZ +CbZW);
    vertex(CbX +CbXW, CbY -CbH, CbZ +CbZW);
    vertex(CbX +CbXW, CbY -CbH, CbZ);
    
    // -X "front" face
    vertex(CbX, CbY, CbZ);
    vertex(CbX, CbY, CbZ +CbZW);
    vertex(CbX, CbY -CbH, CbZ +CbZW);
    vertex(CbX, CbY -CbH, CbZ);
    
    // +Y "front" face
    vertex(CbX, CbY, CbZ);
    vertex(CbX +CbXW, CbY, CbZ);
    vertex(CbX +CbXW, CbY, CbZ +CbZW);
    vertex(CbX, CbY, CbZ +CbZW);
    
    // -Y "front" face
    vertex(CbX, CbY -CbH, CbZ);
    vertex(CbX +CbXW, CbY -CbH, CbZ);
    vertex(CbX +CbXW, CbY -CbH, CbZ +CbZW);
    vertex(CbX, CbY -CbH, CbZ +CbZW);
    
    
    
    //// +Z "front" face
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ +CbZW/2, Texture.width, Texture.height);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ +CbZW/2, Texture.width, 0);
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ +CbZW/2, 0, 0);
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ +CbZW/2, 0, Texture.height);
    
    //// -Z "front" face
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ -CbZW/2, Texture.width, Texture.height);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ -CbZW/2, Texture.width, 0);
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ -CbZW/2, 0, 0);
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ -CbZW/2, 0, Texture.height);
    
    //// +X "front" face
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ +CbZW/2, Texture.width, Texture.height);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ +CbZW/2, Texture.width, 0);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ -CbZW/2, 0, 0);
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ -CbZW/2, 0, Texture.height);
    
    //// -X "front" face
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ +CbZW/2, Texture.width, Texture.height);
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ +CbZW/2, Texture.width, 0);
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ -CbZW/2, 0, 0);
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ -CbZW/2, 0, Texture.height);
    
    //// +Y "front" face
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ +CbZW/2, Texture.width, Texture.height);
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ +CbZW/2, Texture.width, 0);
    //vertex(CbX +CbXW/2, CbY -CbH/2, CbZ -CbZW/2, 0, 0);
    //vertex(CbX -CbXW/2, CbY -CbH/2, CbZ -CbZW/2, 0, Texture.height);
    
    //// +Y "front" face
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ +CbZW/2, Texture.width, Texture.height);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ +CbZW/2, Texture.width, 0);
    //vertex(CbX +CbXW/2, CbY +CbH/2, CbZ -CbZW/2, 0, 0);
    //vertex(CbX -CbXW/2, CbY +CbH/2, CbZ -CbZW/2, 0, Texture.height);
  endShape();
}
