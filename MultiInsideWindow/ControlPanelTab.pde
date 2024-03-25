class ControlPanelTab {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean WindowEdgeSelected = false;
  
  int AmountOfIcons = 5;
  int SelectedIcon = -1;
  boolean IconChanged = false;
  
  PImage[] Icons;
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  ControlPanelTab() {
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Setup() {
    int AmountOfIcons = 1;
    Icons = new PImage[AmountOfIcons];
    for (int i = 0; i < AmountOfIcons; i++) {
      Icons[i] = loadImage("Assets/AllIcons/Icon" + i + ".png");
      
    }
    
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
    //Rect(WindowsPos[0], WindowsPos[1], width * WindowsPos[2]-1, WindowsPos[3]-1, 1, color(0), color(255));
    Rect(WindowsPos[0], WindowsPos[1], WindowsPos[2], WindowsPos[3]-1, 1, color(0), color(255));
    
    for (int i = 0; i < AmountOfIcons; i++) {
      if (mouseX > WindowsPos[0] && mouseX < WindowsPos[0] + WindowsPos[2] && mouseY > WindowsPos[1] + WindowsPos[2] * i && mouseY < WindowsPos[1] + WindowsPos[2] * i + WindowsPos[2]) {
        //if mouse pressed inside of mini icon
        if (mousePressed && !IconChanged) {
          if (SelectedIcon == i) {
            SelectedIcon = -1;
            ScreenLeveling = 0;
            IconChanged = true;
            
          }
          
          else {
            SelectedIcon = i;
            ScreenLeveling = 1;
            IconChanged = true;
            
          }
          
          Rect(WindowsPos[0], WindowsPos[1] + WindowsPos[2] * i, WindowsPos[2], WindowsPos[2], 1, color(0), color(205));
          
        } else 
        Rect(WindowsPos[0], WindowsPos[1] + WindowsPos[2] * i, WindowsPos[2], WindowsPos[2], 1, color(0), color(230));
        
      } else 
      Rect(WindowsPos[0], WindowsPos[1] + WindowsPos[2] * i, WindowsPos[2], WindowsPos[2], 1, color(0), color(255));
      
      if (i < Icons.length)
        image(Icons[i], WindowsPos[0], WindowsPos[1] + WindowsPos[2] * i, WindowsPos[2], WindowsPos[2]);
      
      if (SelectedIcon == i) {
        IconPopup();
        
      }
      
    }
    
    if (!MousePressed && IconChanged)
      IconChanged = false;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void IconPopup() {
    //-------------------------------------------------------------------------------------------//
    if (SelectedIcon == 0) {
      //inside popup box
      Rect(WindowsPos[0] + WindowsPos[2], WindowsPos[1] + WindowsPos[2] * SelectedIcon, 200, 100, 1, color(0), color(255));
      
      float BoxSpacing = 10;
      
      if (mouseX > WindowsPos[0] + WindowsPos[2] + BoxSpacing && mouseX < WindowsPos[0] + WindowsPos[2] + BoxSpacing + WindowsPos[2] && 
          mouseY > WindowsPos[1] + WindowsPos[2] * SelectedIcon + BoxSpacing && mouseY < WindowsPos[1] + WindowsPos[2] * SelectedIcon + BoxSpacing + WindowsPos[2]) {
        //if mouse pressed inside of mini icon
        if (mousePressed) {
          
          
          Rect(WindowsPos[0] + WindowsPos[2] + BoxSpacing, WindowsPos[1] + WindowsPos[2] * SelectedIcon + BoxSpacing, WindowsPos[2], WindowsPos[2], 1, color(0), color(205));
          
        } else 
          Rect(WindowsPos[0] + WindowsPos[2] + BoxSpacing, WindowsPos[1] + WindowsPos[2] * SelectedIcon + BoxSpacing, WindowsPos[2], WindowsPos[2], 1, color(0), color(230));
        
      } else 
        Rect(WindowsPos[0] + WindowsPos[2] + BoxSpacing, WindowsPos[1] + WindowsPos[2] * SelectedIcon + BoxSpacing, WindowsPos[2], WindowsPos[2], 1, color(0), color(255));
      
      //-------------------------------------------------------------------------------------------//
    } else if (SelectedIcon == 1) {
      Point(WindowsPos[0] + WindowsPos[2]/2, WindowsPos[1] + WindowsPos[2] * SelectedIcon + WindowsPos[2]/2, WindowsPos[2]/2, color(200, 0, 0));
      
      //-------------------------------------------------------------------------------------------//
    } else if (SelectedIcon == 2) {
      Point(WindowsPos[0] + WindowsPos[2]/2, WindowsPos[1] + WindowsPos[2] * SelectedIcon + WindowsPos[2]/2, WindowsPos[2]/2, color(150, 0, 0));
      
      //-------------------------------------------------------------------------------------------//
    } else if (SelectedIcon == 3) {
      Point(WindowsPos[0] + WindowsPos[2]/2, WindowsPos[1] + WindowsPos[2] * SelectedIcon + WindowsPos[2]/2, WindowsPos[2]/2, color(100, 0, 0));
      
      //-------------------------------------------------------------------------------------------//
    } else if (SelectedIcon == 4) {
      Point(WindowsPos[0] + WindowsPos[2]/2, WindowsPos[1] + WindowsPos[2] * SelectedIcon + WindowsPos[2]/2, WindowsPos[2]/2, color(50, 0, 0));
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
