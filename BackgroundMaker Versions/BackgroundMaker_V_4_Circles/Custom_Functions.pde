void GradientColorFunction(color Color1, color Color2, int AmountOfMidPoints, color[] ColorResults) {
  int RDirection = 0;
  int GDirection = 0;
  int BDirection = 0;
  float GradientNumR = 0;
  float GradientNumG = 0;
  float GradientNumB = 0;
  if (red(Color1) > red(Color2)) {
    RDirection = 0;
    GradientNumR = (red(Color1) - red(Color2))/(AmountOfMidPoints - 1);
  } else if (red(Color1) == red(Color2)) {
    RDirection = 1;
    GradientNumR = 0;
  } else if (red(Color1) < red(Color2)) {
    RDirection = 2;
    GradientNumR = (red(Color2) - red(Color1))/(AmountOfMidPoints - 1);
  }
  if (green(Color1) > green(Color2)) {
    GDirection = 0;
    GradientNumG = (green(Color1) - green(Color2))/(AmountOfMidPoints - 1);
  } else if (green(Color1) == green(Color2)) {
    GDirection = 1;
    GradientNumG = 0;
  } else if (green(Color1) < green(Color2)) {
    GDirection = 2;
    GradientNumG = (green(Color2) - green(Color1))/(AmountOfMidPoints - 1);
  }
  if (blue(Color1) > blue(Color2)) {
    BDirection = 0;
    GradientNumB = (blue(Color1) - blue(Color2))/(AmountOfMidPoints - 1);
  } else if (blue(Color1) == blue(Color2)) {
    BDirection = 1;
    GradientNumB = 0;
  } else if (blue(Color1) < blue(Color2)) {
    BDirection = 2;
    GradientNumB = (blue(Color2) - blue(Color1))/(AmountOfMidPoints - 1);
  }
  for (int i = 0; i < AmountOfMidPoints; i++) {
    if (i == 0) {
      ColorResults[i] = Color1;
    } else if (i == AmountOfMidPoints - 1) {
      ColorResults[i] = Color2;
    } else {
      float TemColR = 0;
      float TemColG = 0;
      float TemColB = 0;
      if (RDirection == 0) {
        TemColR = red(Color1) - i * GradientNumR;
      } else if (RDirection == 1) {
        TemColR = red(Color1);
      } else if (RDirection == 2) {
        TemColR = red(Color1) + i * GradientNumR;
      }
      if (GDirection == 0) {
        TemColG = green(Color1) - i * GradientNumG;
      } else if (GDirection == 1) {
        TemColG = green(Color1);
      } else if (GDirection == 2) {
        TemColG = green(Color1) + i * GradientNumG;
      }
      if (BDirection == 0) {
        TemColB = blue(Color1) - i * GradientNumB;
      } else if (BDirection == 1) {
        TemColB = blue(Color1);
      } else if (BDirection == 2) {
        TemColB = blue(Color1) + i * GradientNumB;
      }
      ColorResults[i] = color(constrain(TemColR, 0, 255), constrain(TemColG, 0, 255), constrain(TemColB, 0, 255));
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DrawGradientColor(float PosX, float PosY, float PosXLength, float PosYLength, float LengthSpace, int StrokeWeight, color RectStroke, color[] RectFill) {
  
  for (int i = 0; i < AmountOfPointsX; i++) {
    RectFunction(PosX + i * (LengthSpace + 1), PosY, PosXLength, PosYLength, RectStroke, RectFill[i], StrokeWeight);
    //EllipseFunction(PosX + i * (LengthSpace + 1), PosY, PosXLength + random(-2, 2), PosYLength + random(-2, 2), RectStroke, RectFill[i], StrokeWeight);
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DrawGradientColor2(float PosX, float PosY, float PosXLength, float PosYLength, int StrokeWeight, color[][] RectStroke, color[][] RectFill) {
  
  for (int X = 0; X < AmountOfPointsX; X++) {
    for (int Y = 0; Y < AmountOfPointsY; Y++) {
      //RectFunction(PosX + X * (PosXLength + 1), PosY + Y * (PosYLength + 1), PosXLength, PosYLength, RectStroke[X][Y], RectFill[X][Y], StrokeWeight);
      //EllipseFunction(PosX + X * (PosXLength + 1), PosY + Y * (PosYLength + 1), PosXLength + random(-10, 10), PosYLength + random(-10, 10), RectStroke[X][Y], RectFill[X][Y], StrokeWeight);
      EllipseFunction(PosX + X * (PosXLength + 1) + random(-10, 10), PosY + Y * (PosYLength + 1) + random(-10, 10), PosXLength + random(-10, 10), PosYLength + random(-10, 10), RectStroke[X][Y], RectFill[X][Y], StrokeWeight);
  }
  }
  
}
