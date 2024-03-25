class ColorSelector {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float CSPosX;
  float CSPosY;
  float CSWidth;
  float CSHeight;
  color CSColor1;
  color CSColor2;
  color[] CombinedColors = new color[2];
  
  int Points = 256;
  float CSTBWidth = 50;
  float CSTBHeight = 50;
  
  float SliderPosX;
  float SliderPosY;
  float SliderWidth;
  float SliderHeight;
  boolean SliderMoved = false;
  int ColorRecieverVal = 0;
  
  color[] ColorResults = new color[Points];
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ColorSelector(float D1, float D2, float D3, float D4, color D5, color D6, int D7) {
    CSPosX = D1;
    CSPosY = D2;
    CSWidth = D3;
    CSTBWidth = CSWidth/5;
    CSWidth -= CSTBWidth;
    CSHeight = D4;
    CSTBHeight = CSHeight;
    CSColor1 = D5;
    CSColor2 = D6;
    ColorRecieverVal = D7;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    //CSColorBlend(CSColor1, CSColor2, Points, ColorResults);
    CombinedColors[0] = CSColor1;
    CombinedColors[1] = CSColor2;
    ColorResults = ResultingColors(CombinedColors, Points);
    
    if (ColorRecieverVal == 0) {
      SliderPosX = CSPosX + (CSWidth/Points) * red(CursorSC) + SliderWidth/2;
    
    } else if (ColorRecieverVal == 1) {
      SliderPosX = CSPosX + (CSWidth/Points) * green(CursorSC) + SliderWidth/2;
    
    } else if (ColorRecieverVal == 2) {
      SliderPosX = CSPosX + (CSWidth/Points) * blue(CursorSC) + SliderWidth/2;
    
    }
    SliderPosY = CSPosY;
    SliderHeight = CSHeight;
    SliderWidth = 5;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }
    
    if (CursorSC != CursorSCP) {
      if (ColorRecieverVal == 0) {
        SliderPosX = CSPosX + (CSWidth/Points) * red(CursorSC) + SliderWidth/2;
      
      } else if (ColorRecieverVal == 1) {
        SliderPosX = CSPosX + (CSWidth/Points) * green(CursorSC) + SliderWidth/2;
      
      } else if (ColorRecieverVal == 2) {
        SliderPosX = CSPosX + (CSWidth/Points) * blue(CursorSC) + SliderWidth/2;
        CursorSCP = CursorSC;
        
      }
      
    }
    
    for (int CV = 0; CV < Points; CV++) {
      if (mouseX >= CSPosX + (CSWidth/Points) * CV && mouseX < CSPosX + (CSWidth/Points) * (CV + 1) && 
          mouseY >= CSPosY && mouseY < CSPosY + CSHeight) {
        if (mousePressed && DrawingState == 0) {
          SliderPosX = mouseX - SliderWidth/2;
          SliderMoved = true;
          if (ColorRecieverVal == 0) {
            float[] ColVal = new float[3];
            ColVal[0] = red(ColorResults[CV]);
            ColVal[1] = green(CursorSC);
            ColVal[2] = blue(CursorSC);
            CursorSC = color(ColVal[0], ColVal[1], ColVal[2]);
          
          } else if (ColorRecieverVal == 1) {
            float[] ColVal = new float[3];
            ColVal[0] = red(CursorSC);
            ColVal[1] = green(ColorResults[CV]);
            ColVal[2] = blue(CursorSC);
            CursorSC = color(ColVal[0], ColVal[1], ColVal[2]);
          
          } else if (ColorRecieverVal == 2) {
            float[] ColVal = new float[3];
            ColVal[0] = red(CursorSC);
            ColVal[1] = green(CursorSC);
            ColVal[2] = blue(ColorResults[CV]);
            CursorSC = color(ColVal[0], ColVal[1], ColVal[2]);
          
          }
        
        }
        
      }
      
      Rect(CSPosX + (CSWidth/Points) * CV, CSPosY, (CSWidth/Points), CSHeight, 1, ColorResults[CV], ColorResults[CV]);
      
    }
    
    Rect(SliderPosX, SliderPosY, SliderWidth, SliderHeight, 1, color(0), color(255));
    
    //NumberTextBoxCode
    Rect(CSPosX + CSWidth, CSPosY, CSTBWidth, CSTBHeight, 1, color(0), color(255));
    if (ColorRecieverVal == 0) {
      Text(str(red(CursorSC)), CSPosX + CSWidth + CSTBWidth/2, CSPosY + CSTBHeight/2, CSTBHeight/2, color(0), 1);
    
    } else if (ColorRecieverVal == 1) {
      Text(str(green(CursorSC)), CSPosX + CSWidth + CSTBWidth/2, CSPosY + CSTBHeight/2, CSTBHeight/2, color(0), 1);
      
    } else if (ColorRecieverVal == 2) {
      Text(str(blue(CursorSC)), CSPosX + CSWidth + CSTBWidth/2, CSPosY + CSTBHeight/2, CSTBHeight/2, color(0), 1);
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
