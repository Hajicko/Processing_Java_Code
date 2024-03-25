
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

void Text(String SText, float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, int TextSize, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
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

void Point(float PosX, float PosY, float PosZ, float RotX, float RotY, float RotZ, int StrokeWeight, color StrokeCol, color FillCol) {
  pushMatrix();
    translate(PosX, PosY, PosZ);
    rotateX(RotX);
    rotateY(RotY);
    rotateZ(RotZ);
    
    strokeWeight(StrokeWeight);
    stroke(StrokeCol);
    fill(FillCol);
    
    point(0, 0, 0);
  popMatrix();
  
}
