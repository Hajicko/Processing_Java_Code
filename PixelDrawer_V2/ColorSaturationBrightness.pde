class ColorSaturationBrightness {
      
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float CSBPosX;
  float CSBPosY;
  float CSBWidth;
  float CSBHeight;
  float CSBSizeX;
  float CSBSizeY;
  
  int AllPointsX = 75;
  int AllPointsY = 75;
  
  color[][] AllColors = new color[AllPointsX][AllPointsY];
  color[] RowColor = new color[AllPointsX];
  
  color[] ALL1 = {color(255), color(255, 0, 0)};
  color[] ALL2 = {color(1), color(1)};
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ColorSaturationBrightness(float D1, float D2, float D3, float D4) {
    CSBPosX = D1;
    CSBPosY = D2;
    CSBWidth = D3;
    CSBHeight = D4;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    AllColors = Grid2DCreator(ALL1, ALL2, AllPointsX, AllPointsY);
    
    CSBSizeX = (CSBWidth/AllPointsX);
    CSBSizeY = (CSBHeight/AllPointsY);
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }
    
    if (CursorSC != CursorSCP) {
      color[] TemCol = new color[2];
      TemCol[0] = color(255);
      TemCol[1] = CursorSC;
      AllColors = Grid2DCreator(TemCol, ALL2, AllPointsX, AllPointsY);
      
    }
    
    for (int X = 0; X < AllPointsX; X++) {
      for (int Y = 0; Y < AllPointsY; Y++) {
        if (mouseX >= CSBPosX + X * CSBSizeX && mouseX <= CSBPosX + (X + 1) * CSBSizeX &&
            mouseY >= CSBPosY + Y * CSBSizeY && mouseY <= CSBPosY + (Y + 1) * CSBSizeY) {
          //MouseColorHover = "R: " + red(ColAP[X][Y]) + ", G: " + green(ColAP[X][Y]) + ", B:" + blue(AllColors[X][Y]);
          
          if (mousePressed && DrawingState == 0) {
            CursorSC = AllColors[X][Y];
            
          }
          
        }
        Rect(CSBPosX + X * CSBSizeX, CSBPosY + Y * CSBSizeY, CSBSizeX, CSBSizeY, 1, AllColors[X][Y], AllColors[X][Y]);
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
