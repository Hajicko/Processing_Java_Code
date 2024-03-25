class Window {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  PVector WindowPos = new PVector(0, 0);
  PVector WindowAdd = new PVector(0, 0);
  PVector WindowSize = new PVector(0, 0);
  
  //Baby Windows
  ArrayList<ColorSelector> ColorSelectorWindows = new ArrayList<ColorSelector>();
  color[] CSCA = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};
  RangeColorBar RCBWindow;
  ColorSaturationBrightness CSBWindow;
  IconBar IBWindow;
  ToolBar TBWindow;
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Window(float D1, float D2) {
    WindowPos.x = D1;
    WindowPos.y = D2;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    for (int i = 0; i < 3; i++) {
      int XSpacing = 350;
      int YSpacing = 30;
      ColorSelectorWindows.add(new ColorSelector(WindowPos.x + WindowAdd.x, WindowPos.y + WindowAdd.y, XSpacing, YSpacing, color(0), CSCA[i], i));
      WindowAddReposition(XSpacing, YSpacing);
      
    }
    
    RCBWindow = new RangeColorBar(WindowPos.x + WindowAdd.x, WindowPos.y + WindowAdd.y, 350, 30);
    WindowAddReposition(350, 30);
    
    CSBWindow = new ColorSaturationBrightness(WindowPos.x + WindowAdd.x, WindowPos.y + WindowAdd.y, 350, 350);
    WindowAddReposition(350, 350);
    
    IBWindow = new IconBar(WindowPos.x + WindowAdd.x, WindowPos.y + WindowAdd.y, 350, 75);
    WindowAddReposition(350, 75);
    
    TBWindow = new ToolBar(WindowPos.x + WindowAdd.x, WindowPos.y + WindowAdd.y, 350, 75);
    WindowAddReposition(350, 75);
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }
    
    if (mouseX >= WindowPos.x - 5 && mouseX <= WindowPos.x - 5 + WindowSize.x + 10 && mouseY >= WindowPos.y - 5 && mouseY <= WindowPos.y - 5 + WindowSize.y + 10) {
      CursorWindow = true;
      
    } else {
      CursorWindow = false;
      
    }
    
    Rect(WindowPos.x - 5, WindowPos.y - 5, WindowSize.x + 10, WindowSize.y + 10, 3, color(0), color(255));
    
    for (int i = 0; i < ColorSelectorWindows.size(); i++) {
      ColorSelector ColorSelectorWindow = ColorSelectorWindows.get(i);
      
      ColorSelectorWindow.Draw();
      
    }
    RCBWindow.Draw();
    
    CSBWindow.Draw();
    
    IBWindow.Draw();
    
    TBWindow.Draw();
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void WindowAddReposition(float AddX, float AddY) {
    WindowSize.y += AddY;
    WindowAdd.y += AddY;
    
    if (AddX > WindowSize.x) {
      WindowSize.x = AddX;
    
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
