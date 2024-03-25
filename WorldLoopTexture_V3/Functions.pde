void Text(String Text, float TexPosX, float TexPosY, float TexSize, color TexCol, int Point) {
  
  fill(TexCol);
  stroke(TexCol);
  textSize(TexSize);
  if (Point == 0) {
    text(Text, TexPosX - textWidth(Text) + (TexSize/2), TexPosY + (TexSize/2) + (TexSize/4));
  } else if (Point == 1) {
    text(Text, TexPosX - textWidth(Text)/2, TexPosY);
  } else if (Point == 2) {
    text(Text, TexPosX + (TexSize/2), TexPosY + TexSize + (TexSize/2) + (TexSize/4));
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Rect(float RecPosX, float RecPosY, float RecWidth, float RecHeight, float RecStrokeWeight, color RecColStroke, color RecColFill) {
  
  strokeWeight(RecStrokeWeight);
  stroke(RecColStroke);
  if (RecColFill != color(0, 255)) {
    fill(RecColFill);
  } else {
    noFill();
  }
  rect(RecPosX, RecPosY, RecWidth, RecHeight);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Ellipse(float EllPosX, float EllPosY, float EllWidth, float EllHeight, float EllStrokeWeight, color EllColStroke, color EllColFill, int Point) {
  
  strokeWeight(EllStrokeWeight);
  stroke(EllColStroke);
  fill(EllColFill);
  if (Point == 0) {
    ellipse(EllPosX - EllWidth/2, EllPosY - EllHeight/2, EllWidth, EllHeight);
  } else if (Point == 1) {
    ellipse(EllPosX, EllPosY, EllWidth, EllHeight);
  } else if (Point == 2) {
    ellipse(EllPosX + EllWidth/2, EllPosY + EllHeight/2, EllWidth, EllHeight);
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Line(float LinPosX1, float LinPosY1, float LinPosX2, float LinPosY2, float LinStrokeWeight, color LinColStroke) {
  
  strokeWeight(LinStrokeWeight);
  stroke(LinColStroke);
  line(LinPosX1, LinPosY1, LinPosX2, LinPosY2);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Point(float PoiPosX, float PoiPosY, float PoiStrokeWeight, color PoiColStroke) {
  
  strokeWeight(PoiStrokeWeight);
  stroke(PoiColStroke);
  point(PoiPosX, PoiPosY);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Triangle(float TriPosX1, float TriPosY1, float TriPosX2, float TriPosY2, float TriPosX3, float TriPosY3, float TriStrokeWeight, color TriColStroke, color TriColFill) {
  
  strokeWeight(TriStrokeWeight);
  stroke(TriColStroke);
  fill(TriColFill);
  triangle(TriPosX1, TriPosY1, TriPosX2, TriPosY2, TriPosX3, TriPosY3);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void RectButton(float RBPosX, float RBPosY, float RBWidth, float RBHeight, float RBStrokeWeight, color RBColStroke, color RBColFill, 
                        String RBTextInfo, float RBTextSize, color RBTextColFill,
                        boolean PressedOn, boolean[] ClickResult, boolean ClickResultState, int[] ClickTimeSpacer, int ResetClickTimeSpacer) {
  
  fill(RBColFill);
  stroke(RBColStroke);
  strokeWeight(RBStrokeWeight);
  rect(RBPosX, RBPosY, RBWidth, RBHeight);
  
  fill(RBTextColFill);
  textSize(RBTextSize);
  text(RBTextInfo, RBPosX + RBWidth/2 - textWidth(RBTextInfo)/2, RBPosY + RBHeight/2);
  
  if (PressedOn == true && ClickTimeSpacer[0] == 0 && mouseX > RBPosX && mouseX < RBPosX + RBWidth && mouseY > RBPosY && mouseY < RBPosY + RBHeight) {
    ClickResult[0] = ClickResultState;
    background(RBColFill);
    
    ClickTimeSpacer[0] = ResetClickTimeSpacer;
  } else if (ClickTimeSpacer[0] != 0) {
    ClickTimeSpacer[0]--;
  }
  
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int RR(float N1, float N2) {
  
  return round(random(N1 - 0.5, N2 + 0.5));
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Box(float BFPosX, float BFPosY, float BFPosZ, float BFPosWidth) {
  
  pushMatrix();
    translate(BFPosX, BFPosY, BFPosZ);
    box(BFPosWidth);
    
  popMatrix();
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Hexagon(float PosX, float PosY, float SizeX, float SizeY, float StrokeWeight, color StrokeCol, color FillCol) {
  float CenPointWidth = SizeX * (1 + (1 - 0.8649));
  float CenPointHeight = SizeY * (1 + (1 - 0.8649));
  fill(FillCol);
  stroke(StrokeCol);
  strokeWeight(StrokeWeight);
  beginShape();
    vertex(PosX + cos(radians(60)) * CenPointWidth, PosY + sin(radians(60)) * CenPointHeight);
    vertex(PosX + cos(radians(120)) * CenPointWidth, PosY + sin(radians(120)) * CenPointHeight);
    vertex(PosX + cos(radians(180)) * CenPointWidth, PosY + sin(radians(180)) * CenPointHeight);
    vertex(PosX + cos(radians(240)) * CenPointWidth, PosY + sin(radians(240)) * CenPointHeight);
    vertex(PosX + cos(radians(300)) * CenPointWidth, PosY + sin(radians(300)) * CenPointHeight);
    vertex(PosX + cos(radians(360)) * CenPointWidth, PosY + sin(radians(360)) * CenPointHeight);
  endShape(CLOSE);
  
}
