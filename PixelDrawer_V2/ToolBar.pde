class ToolBar {
      
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float TBPosX;
  float TBPosY;
  float TBWidth;
  float TBHeight;
  int AmountOfTools = 4;
  String[] ToolName = {"Pixel Pen", "Eraser", "Paint Brush", "Pick Color"};
  PImage[] ToolIcon;
  int ToolClicked = -1;
  boolean[] InputDone = {false};
  int KeyCoolDownTimer = 0;
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ToolBar(float D1, float D2, float D3, float D4) {
    TBPosX = D1;
    TBPosY = D2;
    TBWidth = D3;
    TBHeight = D4;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    ToolIcon = new PImage[AmountOfTools];
    for (int TI = 0; TI < AmountOfTools; TI++) {
      ToolIcon[TI] = loadImage(sketchPath("Assets/ToolIcons/Icon" + TI + ".png"));
    
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }

    Rect(TBPosX, TBPosY, TBWidth, TBHeight, 1, color(0), color(255));
    
    IconDraw();
    
    if (ToolClicked != -1) {
      IconClick();
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void IconDraw() {
    for (int i = 0; i < AmountOfTools; i++) {
      Rect(TBPosX + i * (TBWidth/AmountOfTools), TBPosY, (TBWidth/AmountOfTools), TBHeight, 1, color(0), color(255));
      if (mouseX > TBPosX + i * (TBWidth/AmountOfTools) && mouseX < TBPosX + (i + 1) * (TBWidth/AmountOfTools) && mouseY > TBPosY && mouseY < TBPosY + TBHeight) {
        if (mousePressed && ToolClicked == -1 && DrawingState == 0) {
          ToolClicked = i;
          
        }
        
      }
      
      image(ToolIcon[i], TBPosX + i * (TBWidth/AmountOfTools), TBPosY, (TBWidth/AmountOfTools), TBHeight);
      
      if (i == CursorTool) {
        Text(ToolName[i], TBPosX + (TBWidth/AmountOfTools)/2 + i * (TBWidth/AmountOfTools), TBPosY + TBHeight/2, 15, color(255, 0, 0), 1);
        
      } else {
        Text(ToolName[i], TBPosX + (TBWidth/AmountOfTools)/2 + i * (TBWidth/AmountOfTools), TBPosY + TBHeight/2, 15, color(0), 1);
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void IconClick() {
    if (ToolClicked == 0) {
      CursorTool = 0;
      
      ToolClicked = -1;
      
    } else if (ToolClicked == 1) {
      CursorTool = 1;
      
      ToolClicked = -1;
      
    } else if (ToolClicked == 2) {
      CursorTool = 2;
      
      KBI("Brush Size", InputWord, KeyCoolDownG, InputDone);
      DrawingState = 1;
      
      if (InputDone[0]) {
        InputDone[0] = false;
        DrawingState = 0;
        BrushR = int(InputWord[0]);
        InputWord[0] = "";
        ToolClicked = -1;
        
      }
      
    } else if (ToolClicked == 3) {
      CursorTool = 3;
      
      ToolClicked = -1;
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
