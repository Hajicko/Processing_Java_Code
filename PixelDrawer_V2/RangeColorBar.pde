class RangeColorBar {
    
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float RCBPosX;
  float RCBPosY;
  float RCBWidth;
  float RCBHeight;
  color[] SetColors = {color(255, 0, 0), color(0, 0, 255), color(0, 255, 0), color(255, 0, 0)};
  
  int Points = 768;
  
  float SliderPosX;
  float SliderPosY;
  float SliderWidth;
  float SliderHeight;
  
  color[] ColorResults = new color[Points];
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  RangeColorBar(float D1, float D2, float D3, float D4) {
    RCBPosX = D1;
    RCBPosY = D2;
    RCBWidth = D3;
    RCBHeight = D4;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    ColorResults = ResultingColors(SetColors, Points);
    
    SliderPosX = RCBPosX + (RCBWidth/Points) * 0 + (RCBWidth/Points)/2;
    SliderPosY = RCBPosY;
    SliderHeight = RCBHeight;
    SliderWidth = 5;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }
    
    for (int CV = 0; CV < Points; CV++) {
      if (mouseX >= RCBPosX + (RCBWidth/Points) * CV && mouseX < RCBPosX + (RCBWidth/Points) * (CV + 1) && 
          mouseY >= RCBPosY && mouseY < RCBPosY + RCBHeight) {
        if (mousePressed && DrawingState == 0) {
          SliderPosX = mouseX - SliderWidth/2;
          CursorSC = ColorResults[CV];
          CursorChanged = true;
        
        }
        
      }
      
      Rect(RCBPosX + (RCBWidth/Points) * CV, RCBPosY, (RCBWidth/Points), RCBHeight, 1, ColorResults[CV], ColorResults[CV]);
      
    }
    
    Rect(SliderPosX, SliderPosY, SliderWidth, SliderHeight, 1, color(0), color(255));
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
