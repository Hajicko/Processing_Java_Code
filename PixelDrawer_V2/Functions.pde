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

void CustomSortReverse(float[] Numbers, int[] NPositions) {
  
  float FData1 = 0;
  float FData2 = 0;
  int PData1 = 0;
  int PData2 = 0;
  for (int R = 0; R < Numbers.length; R++) {
    for (int i = 0; i < Numbers.length; i++) {
      if (i != Numbers.length - 1) {
        if (Numbers[i] < Numbers[i + 1]) {
          FData1 = Numbers[i];
          FData2 = Numbers[i + 1];
          PData1 = NPositions[i];
          PData2 = NPositions[i + 1];
          
          Numbers[i] = FData2;
          Numbers[i + 1] = FData1;
          NPositions[i] = PData2;
          NPositions[i + 1] = PData1;
          
        }
        
      }
      
    }
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean mouseInside(float PointX, float PointY, float WidthZone, float HeightZone) {
  if (mouseX > PointX && mouseX < PointX + WidthZone && mouseY > PointY && mouseY < PointY + HeightZone) {
    return true;
    
  }
  
  return false;
  
}
