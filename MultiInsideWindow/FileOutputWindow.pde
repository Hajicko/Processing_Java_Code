class FileOutputWindow {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  FileOutputWindow() {
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Setup() {
    SetupRunned = true;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned)
      Setup();
    
    WindowBackground();
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void WindowBackground() {
    //Top Text of the tab
    Rect(WindowsPos[8], 0, width * WindowsPos[10]-1, WindowsPos[11], 1, color(0), color(255));
    textSize(33);
    if (textWidth(FileOpened) <= width * WindowsPos[10]-1)
      Text(FileOpened, WindowsPos[8] + (width * WindowsPos[10]-1)/2, 40, 33, color(0), 1);
    else if (textWidth("...") <= width * WindowsPos[10]-1)
      Text("...", WindowsPos[8] + (width * WindowsPos[10]-1)/2, 40, 33, color(0), 1);
    
    Rect(WindowsPos[8], WindowsPos[9], width * WindowsPos[10]-1, WindowsPos[11]-1, 1, color(0), color(255));
    
    float Spacer = 4;
    if (SelectedWindowEdge != 1 && (SelectedWindowEdge == 2 || (mouseX > WindowsPos[8] - Spacer && mouseX < WindowsPos[8] + Spacer && mouseY > WindowsPos[9] && mouseY < WindowsPos[11])) && 
        mouseX > WindowsPos[4] + Spacer && mouseX < width - Spacer) {
      if (CursorType == 0) {
        cursor(MOVE);
        CursorType = 1;
        CursorOver = 2;
        
      }
      
      if (mousePressed) {
        Line(WindowsPos[8], WindowsPos[9], WindowsPos[8], WindowsPos[11], Spacer*2 - 2, color(0));
        if (SelectedWindowEdge == 0)
          SelectedWindowEdge = 2;
          
        WindowsPos[6] = ((mouseX)/( width + 0.0)) - (WindowsPos[2]/ (width+0.0));
        ResetWindowPosition();
          
      } else if (!mousePressed) {
        SelectedWindowEdge = 0;
        
      }
      
      
    } else if (SelectedWindowEdge == 2) {
      if (mouseX > width - WindowsPos[2] - Spacer) {
        WindowsPos[6] = (width - WindowsPos[2] - Spacer)/( width+0.0);
        ResetWindowPosition();
        
      } else if (mouseX < WindowsPos[4] + Spacer) {
        WindowsPos[6] = ((WindowsPos[4] + Spacer)/( width+0.0)) - (WindowsPos[2]/( width+0.0));
        ResetWindowPosition();
        
      } 
      
      if (!mousePressed) {
        SelectedWindowEdge = 0;
        
      }
      
    } else if (CursorOver == 2) {
      CursorOver = 0;
      
    } else if (CursorType == 1 && SelectedWindowEdge == 0 && CursorOver == 0) {
      cursor(ARROW);
      CursorType = 0;
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
