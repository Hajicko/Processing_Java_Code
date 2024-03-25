class Canvas {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean SetupRunned = false;
  int CanvasPixelWidth;
  int CanvasPixelHeight;
  float CanvasPosX;
  float CanvasPosY;
  String CanvasName = "Image";
  String CanvasImageFormat = ".png";
  color[][] CanvasPixelColors;
  PImage[] CanvasImage;
  int CanvasBack = 1;
  int CanvasBackLimit = 10;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Canvas(int D1, int D2, float D3, float D4) {
    CanvasPixelWidth = D1;
    CanvasPixelHeight = D2;
    CanvasPosX = D3;
    CanvasPosY = D4;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    CanvasPosX = width/2 - (CanvasPixelWidth * CanvasPixelScale)/2;
    CanvasPosY = height/2 - (CanvasPixelHeight * CanvasPixelScale)/2;
    
    CanvasPixelColors = new color[CanvasPixelWidth][CanvasPixelHeight];
    CanvasImage = new PImage[CanvasBackLimit];
    for (int X = 0; X < CanvasPixelWidth; X++) {
      for (int Y = 0; Y < CanvasPixelHeight; Y++) {
        CanvasPixelColors[X][Y] = CanvasStartingColor;
        
      }
      
    }
    for (int I = 0; I < CanvasBackLimit; I++) {
      CanvasImage[I] = ColArrayToPImage(CanvasPixelWidth, CanvasPixelHeight, CanvasPixelColors);
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }
    
    //Start of canvas loop
    for (int X = 0; X < CanvasPixelWidth; X++) {
      for (int Y = 0; Y < CanvasPixelHeight; Y++) {
        
        if (mousePressed && mouseX > ((CanvasPosX + GBPosX - CanvasZoomMoveX) + (X * CanvasPixelScale)) * CanvasZoom && 
                            mouseX < ((CanvasPosX + GBPosX - CanvasZoomMoveX) + (X * CanvasPixelScale) + CanvasPixelScale) * CanvasZoom &&
                            mouseY > ((CanvasPosY + GBPosY - CanvasZoomMoveY) + (Y * CanvasPixelScale)) * CanvasZoom && 
                            mouseY < ((CanvasPosY + GBPosY - CanvasZoomMoveY) + (Y * CanvasPixelScale) + CanvasPixelScale) * CanvasZoom && CursorWindow == false && DrawingState == 0) {
          if (CanvasBack == 0) {
            CanvasBack = 1;
            CanvasImage[CanvasBack] = CanvasImage[0];
            
          }
          
          if (CursorTool == 0) {
            Pencil(X, Y);
            
          } else if (CursorTool == 1) {
            Eraser(X, Y);
            
          } else if (CursorTool == 2) {
            Brush(BrushR, X, Y);
            
          } else if (CursorTool == 3) {
            Sensor(X, Y);
            
          }
          
          CanvasClicked = true;
          
        }
        
        Rect((CanvasPosX + GBPosX - CanvasZoomMoveX + X * CanvasPixelScale) * CanvasZoom, (CanvasPosY + GBPosY - CanvasZoomMoveY + Y * CanvasPixelScale) * CanvasZoom, CanvasPixelScale * CanvasZoom, 
              CanvasPixelScale * CanvasZoom, 1, CanvasPixelColors[X][Y], CanvasPixelColors[X][Y]);
        
      }
      
    }
    //End of canvas loop
    
    if (CanvasClicked && !MousePressed) {
      if (CanvasBack == CanvasBackLimit - 1) {
        CanvasBack = 0;
        CanvasImage[CanvasBack] = ColArrayToPImage(CanvasPixelWidth, CanvasPixelHeight, CanvasPixelColors);
        
      } else if (CanvasBack < CanvasBackLimit - 1) {
        CanvasImage[CanvasBack] = ColArrayToPImage(CanvasPixelWidth, CanvasPixelHeight, CanvasPixelColors);
        CanvasBack++;
      
      }
      CanvasClicked = false;
    
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void SaveCanvas() {
    CanvasSave(CanvasName, CanvasImageFormat);
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void CanvasSave(String FileName, String FileFormat) {
    PImage SaveImage = ColArrayToPImage(CanvasPixelWidth, CanvasPixelHeight, CanvasPixelColors);
    
    boolean TrySave = true;
    int SaveNum = 0;
    while (TrySave) {
      if (!FileExists(sketchPath("Projects/" + FileName + FileFormat))) {
        SaveImage.save("Projects/" + FileName + FileFormat);
        TrySave = false;
      
      } else if (!FileExists(sketchPath("Projects/" + FileName + SaveNum + FileFormat))) {
        SaveImage.save("Projects/" + FileName + SaveNum + FileFormat);
        TrySave = false;
        
      } else {
        SaveNum++;
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Pencil(int X, int Y) {
    CanvasPixelColors[X][Y] = CursorSC;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Eraser(int X, int Y) {
    CanvasPixelColors[X][Y] = CanvasStartingColor;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Brush(int Radius, int X, int Y) {
    for (int LX = -Radius; LX != Radius; LX++) {
      for (int LY = -Radius; LY != Radius; LY++) {
        if (X + LX >= 0 && X + LX <= CanvasPixelWidth - 1 && Y + LY >= 0 && Y + LY <= CanvasPixelHeight - 1) {
          if (dist((CanvasPosX + GBPosX - CanvasZoomMoveX + X * CanvasPixelScale) * CanvasZoom, (CanvasPosY + GBPosY - CanvasZoomMoveY + Y * CanvasPixelScale) * CanvasZoom, 
                 (CanvasPosX + GBPosX - CanvasZoomMoveX + (X + LX) * CanvasPixelScale) * CanvasZoom, (CanvasPosY + GBPosY - CanvasZoomMoveY + (Y + LY) * CanvasPixelScale) * CanvasZoom) <= (Radius * CanvasPixelScale) * CanvasZoom) {
            CanvasPixelColors[X + LX][Y + LY] = CursorSC;
            
          }
          
        }
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Sensor(int X, int Y) {
    CursorSC = CanvasPixelColors[X][Y];
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
