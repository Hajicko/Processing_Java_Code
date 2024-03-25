class IconBar {
      
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float TBPosX;
  float TBPosY;
  float TBWidth;
  float TBHeight;
  int IconAmount = 5;
  String[] IconStringData = {"FileName", "Save", "New Canvas", "Exit", "FileFormat"};
  int[] IconTextSize = {12, 15, 10, 15, 12};
  int IconClicked = -1;
  int Recieve = 0;
  String[] NewCanvasPixelWidth = {""};
  String[] NewCanvasPixelHeight = {""};
  boolean[] InputDone = {false};
  
  boolean SetupRunned = false;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  IconBar(float D1, float D2, float D3, float D4) {
    TBPosX = D1;
    TBPosY = D2;
    TBWidth = D3;
    TBHeight = D4;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() {
    
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!SetupRunned) {
      Setup();
      SetupRunned = true;
      
    }

    Rect(TBPosX, TBPosY, TBWidth, TBHeight, 1, color(0), color(255));
    
    IconDraw();
    
    if (IconClicked != -1) {
      IconClick();
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void IconDraw() {
    for (int i = 0; i < IconAmount; i++) {
      Rect(TBPosX + i * (TBWidth/IconAmount), TBPosY, (TBWidth/IconAmount), TBHeight, 1, color(0), color(255));
      if (mouseX > TBPosX + i * (TBWidth/IconAmount) && mouseX < TBPosX + (i + 1) * (TBWidth/IconAmount) && mouseY > TBPosY && mouseY < TBPosY + TBHeight) {
        if (mousePressed && ClickCoolDownG[0] == 0 && DrawingState == 0) {
          IconClicked = i;
          ClickCoolDownG[0] = CCDGTime;
          
        }
        
      }
      
      if (i == IconClicked) {
        Text(IconStringData[i], TBPosX + (TBWidth/IconAmount)/2 + i * (TBWidth/IconAmount), TBPosY + TBHeight/2, IconTextSize[i], color(255, 0, 0), 1);
        
      } else {
        Text(IconStringData[i], TBPosX + (TBWidth/IconAmount)/2 + i * (TBWidth/IconAmount), TBPosY + TBHeight/2, IconTextSize[i], color(0), 1);
        
      }
      
    }
    if (ClickCoolDownG[0] != 0) {
      ClickCoolDownG[0]--;
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void IconClick() {
    if (IconClicked == 0) {
      if (BaseCanvas.size() > 0) {
        KBI("Name Of File", InputWord, KeyCoolDownG, InputDone);
        DrawingState = 1;
        if (InputDone[0]) {
          BaseCanvas.get(0).CanvasName = InputWord[0];
          InputWord[0] = "";
          IconClicked = -1;
          DrawingState = 0;
          InputDone[0] = false;
        
        }
        if (IconClicked != 0) {
          background(0);
        }
      
      } else {
        FTexts.add(new FadeText("Need to make a canvas first", 2, 1, 33, mouseX, mouseY, color(255, 0, 0)));
        IconClicked = -1;
        
      }
      
    } else if (IconClicked == 1) {
      if (BaseCanvas.size() > 0) {
        SavedCanvas = true;
        background(0);
        
        IconClicked = -1;
      
      } else {
        FTexts.add(new FadeText("Need to make a canvas to save onto", 2, 1, 20, mouseX, mouseY, color(255, 0, 0)));
        IconClicked = -1;
        
      }
      
    } else if (IconClicked == 2) {
      if (Recieve == 0) {
        KBI("Pixel Width", NewCanvasPixelWidth, KeyCoolDownG, InputDone);
        DrawingState = 1;
        if (InputDone[0]) {
          Recieve++;
          KeyCoolDownG[0] = KCDGTime;
          InputDone[0] = false;
        
        }
        
      } else if (Recieve == 1) {
        KBI("Pixel Height", NewCanvasPixelHeight, KeyCoolDownG, InputDone);
        if (InputDone[0]) {
          Recieve++;
          KeyCoolDownG[0] = KCDGTime;
          InputDone[0] = false;
        
        }
        
      } else if (Recieve == 2) {
        BaseCanvas.add(new Canvas(int(NewCanvasPixelWidth[0]), int(NewCanvasPixelHeight[0]), width/2, height/2));
        NewCanvasPixelWidth[0] = "";
        NewCanvasPixelHeight[0] = "";
        Recieve = 0;
        IconClicked = -1;
        DrawingState = 0;
      
      }
      
    } else if (IconClicked == 3) {
      exit();
      
      IconClicked = -1;
      
    } else if (IconClicked == 4) {
      if (BaseCanvas.size() > 0) {
        KBI("File Format", InputWord, KeyCoolDownG, InputDone);
        DrawingState = 1;
        
        if (InputDone[0]) {
          BaseCanvas.get(0).CanvasImageFormat = InputWord[0];
          InputWord[0] = "";
          DrawingState = 0;
          InputDone[0] = false;
          IconClicked = -1;
        
        }
        if (IconClicked != 4) {
          background(0);
        }
      
      } else {
        FTexts.add(new FadeText("Need to make a canvas first", 2, 1, 33, mouseX, mouseY, color(255, 0, 0)));
        IconClicked = -1;
        
      }
      
    } else {
      FTexts.add(new FadeText("Error", 3, 0, 33, width/2, height/2, color(255, 0, 0)));
      
      IconClicked = -1;
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
