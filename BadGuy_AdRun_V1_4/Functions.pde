int getMillisMappedToSec() {
  return floor(millis() /1000);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void TextFunction(String Text, float TexPosX, float TexPosY, float TexSize, color TexCol, int Point) {
  
  fill(TexCol);
  stroke(TexCol);
  textSize(TexSize);
  if (Point == 0) {
    text(Text, TexPosX - textWidth(Text) + (TexSize/2), TexPosY + (TexSize/2) + (TexSize/4));
  } else if (Point == 1) {
    text(Text, TexPosX - textWidth(Text)/2 + (TexSize/2), TexPosY + (TexSize/2) + (TexSize/4));
  } else if (Point == 2) {
    text(Text, TexPosX + (TexSize/2), TexPosY + TexSize + (TexSize/2) + (TexSize/4));
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void RectFunction(float RecPosX, float RecPosY, float RecWidth, float RecHeight, float RecStrokeWeight, color RecColStroke, color RecColFill) {
  
  strokeWeight(RecStrokeWeight);
  stroke(RecColStroke);
  fill(RecColFill);
  rect(RecPosX, RecPosY, RecWidth, RecHeight);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void EllipseFunction(float EllPosX, float EllPosY, float EllWidth, float EllHeight, float EllStrokeWeight, color EllColStroke, color EllColFill) {
  
  strokeWeight(EllStrokeWeight);
  stroke(EllColStroke);
  fill(EllColFill);
  ellipse(EllPosX + EllWidth/2, EllPosY + EllHeight/2, EllWidth, EllHeight);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void LineFunction(float LinPosX1, float LinPosY1, float LinPosX2, float LinPosY2, float LinStrokeWeight, color LinColStroke) {
  
  strokeWeight(LinStrokeWeight);
  stroke(LinColStroke);
  line(LinPosX1, LinPosY1, LinPosX2, LinPosY2);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PointFunction(float PoiPosX, float PoiPosY, float PoiStrokeWeight, color PoiColStroke) {
  
  strokeWeight(PoiStrokeWeight);
  stroke(PoiColStroke);
  point(PoiPosX, PoiPosY);
  
}
