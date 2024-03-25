color BackgroundColor = color(200);
color CanvasStartingColor = color(255);
ArrayList<FadeText> FTexts = new ArrayList<FadeText>();

//Global Effect Variables
float CanvasZoomIncrease = 0.1;
float CanvasZoom = 1;
float CanvasMaxZoom = 15.5;
float CanvasMinZoom = 0;
float CanvasMoveSpeed = 5;
float CanvasZoomMoveX = 0;
float CanvasZoomMoveY = 0;
float CanvasZoomFocalPointX = width/2;
float CanvasZoomFocalPointY = height/2;
float GBPosX;
float GBPosY;

//Canvas Variables
  
  //Canvas Other
  ArrayList<Canvas> BaseCanvas = new ArrayList<Canvas>();
  float CanvasPixelScale = 5;
  
  boolean SavedCanvas = false;
  boolean CanvasClicked = false;
  
  
//Cursor Variables
boolean CursorChanged = false;
color CursorSC = color(255, 0, 0);
color CursorSCP = color(255, 0, 0);
boolean CursorWindow = false;
int CursorTool = 0;
int BrushR = 1;

//Windows
Window MainWindow;
boolean InsideWindow = false;

//Key Variables
boolean[] KeyStates = new boolean[223];
boolean KeyPressed = false;
int[] KeyCoolDownG = {0};
int KCDGTime = 1;
String[] InputWord = {""};

//Mouse Variables
boolean MousePressed = false;
int DrawingState = 0;
int[] ClickCoolDownG = {0};
int CCDGTime = 10;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  fullScreen();
  
  MainWindow = new Window(20, 20);
  
  noCursor();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  background(BackgroundColor);
  
  if (BaseCanvas.size() > 1) {
    for (int Del = BaseCanvas.size() - 1; Del > 0; Del--) {
      if (Del != 0) {
        BaseCanvas.remove(Del);
      
      }
      
    }
    
  }
  if (BaseCanvas.size() > 0) {
    for (int A1 = 0; A1 < BaseCanvas.size(); A1++) {
      Canvas RCanvas = BaseCanvas.get(A1);
      RCanvas.Draw();
    
    }
    
  }
  
  MainWindow.Draw();
  
  if (FTexts.size() > 0) {
    boolean CheckDelete = false;
    for (int A2 = 0; A2 < FTexts.size(); A2++) {
      FadeText RCanvas = FTexts.get(A2);
      RCanvas.Draw();
      if (RCanvas.Delete) {
        CheckDelete = true;
        
      }
    
    }
    if (CheckDelete) { 
      for (int Del = FTexts.size() - 1; Del > 0; Del--) {
        FadeText RCanvas = FTexts.get(Del);
        if (RCanvas.Delete) {
          FTexts.remove(Del);
        
        }
        
      }
      
    }
    
  }
  
  if (SavedCanvas) {
    keyResults();
    
  }
  
  //Nothing runs after the cursor
  Triangle(mouseX, mouseY, mouseX + 10, mouseY, mouseX, mouseY + 10, 2, color(0), CursorSC);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mousePressed() {
  MousePressed = true;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseReleased() {
  MousePressed = false;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void keyPressed() {
  KeyPressed = true;
  
  KeyStates[keyCode] = true;
  
  keyResults();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  KeyPressed = false;
  
  KeyStates[keyCode] = false;
  
  //println("key: " + key + ", keyCode: " + keyCode);
  
}



void keyResults() {
  //coma
  if (KeyStates[44] && CanvasZoom < CanvasMaxZoom && BaseCanvas.size() > 0 && DrawingState == 0) {
    //in
    CanvasZoom += CanvasZoomIncrease;
    CanvasZoomMoveX = ((CanvasZoom - 1) * mouseX) / CanvasZoom;
    CanvasZoomMoveY = ((CanvasZoom - 1) * mouseY) / CanvasZoom;
    FTexts.add(new FadeText("ZI:" + CanvasZoom, 2.5, 1, 10, mouseX, mouseY, color(0)));
    
  } 
  //period
  if (KeyStates[46] && CanvasZoom > CanvasMinZoom && BaseCanvas.size() > 0 && DrawingState == 0) {
    //out
    CanvasZoom -= CanvasZoomIncrease;
    CanvasZoomMoveX = ((CanvasZoom - 1) * mouseX) / CanvasZoom;
    CanvasZoomMoveY = ((CanvasZoom - 1) * mouseY) / CanvasZoom;
    FTexts.add(new FadeText("ZO:" + CanvasZoom, 2.5, 1, 10, mouseX, mouseY, color(0)));
    
  }

  //Arrow Key Up
  if (KeyStates[38] && DrawingState == 0) {
    GBPosY -= CanvasMoveSpeed * CanvasZoom;
    
  }
  //Arrow Key Left
  if (KeyStates[37] && DrawingState == 0) {
    GBPosX -= CanvasMoveSpeed * CanvasZoom;
    
  }
  //Arrow Key Down
  if (KeyStates[40] && DrawingState == 0) {
    GBPosY += CanvasMoveSpeed * CanvasZoom;
    
  }
  //Arrow Key Right
  if (KeyStates[39] && DrawingState == 0) {
    GBPosX += CanvasMoveSpeed * CanvasZoom;
    
  }
  
  //ctrl + s
  if (((KeyStates[17] && KeyStates[83]) || (SavedCanvas)) && BaseCanvas.size() > 0) {
    BaseCanvas.get(0).SaveCanvas();
    
    SavedCanvas = false;
    
  }
  
  //z
  if (KeyStates[90] && BaseCanvas.size() > 0 && DrawingState == 0) {
    if (BaseCanvas.get(0).CanvasBack != 0) {
      BaseCanvas.get(0).CanvasBack--;
      BaseCanvas.get(0).CanvasPixelColors = PImageToColArray(BaseCanvas.get(0).CanvasImage[BaseCanvas.get(0).CanvasBack]);
    
    }
    KeyStates[90] = false;
    
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

color[] ResultingColors(color[] Allcolors, int AmountOfPoints) {
  color[] FinishedProduct = new color[AmountOfPoints];
  int LengthRun = Allcolors.length - 1;
  int Section = round(AmountOfPoints/LengthRun);
  
  for (int L = 0; L < LengthRun; L++) {
    for (int AC = 0; AC < Section; AC++) {
      float Ratio = map(AC, 0, Section-1, 0, 1);
      FinishedProduct[AC + Section * L] = lerpColor(Allcolors[L], Allcolors[L + 1], Ratio);
      
    }
  }
  
  return FinishedProduct;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

color[][] Grid2DCreator(color[] ColSet1, color[] ColSet2, int XPoints, int YPoints) {
  color[][] FinishedProduct = new color[XPoints][YPoints];

  color[][] TemCol = new color[2][YPoints];
  color[] Combined = new color[2];
  TemCol[0] = ResultingColors(ColSet1, XPoints);
  TemCol[1] = ResultingColors(ColSet2, XPoints);
  for (int X = 0; X < XPoints; X++) {
    Combined[0] = TemCol[0][X];
    Combined[1] = TemCol[1][X];
    FinishedProduct[X] = ResultingColors(Combined, YPoints);
    
  }
  
  return FinishedProduct;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean FileExists(String path) {
  File file = new File(path);
  //println(file.getName());
  boolean exists = file.exists();
  if (exists) {
    //println("true");
    return true;
  }
  else {
    //println("false");
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PImage ColArrayToPImage(int Width, int Height, color[][] ColArray) {
  PImage Image = createImage(Width, Height, ARGB);
  Image.loadPixels();
  int ImageSliceX = 1;
  for (int Pix = 0; Pix < Image.pixels.length; Pix++) {
    if (Pix == ImageSliceX * Width && (ImageSliceX + 1) * Width <= Image.pixels.length) {
      ImageSliceX += 1;
      
    }
    int X = ((ImageSliceX - 1) * -Width) + Pix;
    int Y = ImageSliceX - 1;
    
    Image.pixels[Pix] = ColArray[X][Y]; 
  }
  Image.updatePixels();
  
  return Image;

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

color[][] PImageToColArray(PImage Image) {
  color[][] ColArray = new color[Image.width][Image.height];
  
  for (int X = 0; X < Image.width; X++) {
    for (int Y = 0; Y < Image.height; Y++) {
      ColArray[X][Y] = Image.get(X, Y);
  
    }
    
  }
  
  return ColArray;

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int GetIntValue(String DataNameWant) {
  int RecievedIntValue = -1;
  
  background(255);
  Text(DataNameWant, width/2, height/2, 33, color(0), 1);
  
  return RecievedIntValue;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void KBI(String WhatToInput, String[] RecieveWord, int[] KeyCoolDown, boolean[] Finished) {
  int KeyTimer = 3;
  if (KeyPressed) {
    if ((keyCode == 10 || key == ENTER) && KeyCoolDown[0] == 0) {
      Finished[0] = true;
      
    } else if (key == BACKSPACE && KeyCoolDown[0] == 0) {
      if (RecieveWord[0].length() > 0) {
        RecieveWord[0] = RecieveWord[0].substring(0, RecieveWord[0].length()-1);
        KeyCoolDown[0] = KeyTimer;
        
      }
      
    } else if (keyCode != 10 && keyCode != 16 && KeyCoolDown[0] == 0) {
      RecieveWord[0] += key;
      KeyCoolDown[0] = KeyTimer;
      
    } else if (KeyCoolDown[0] != 0) {
      KeyCoolDown[0]--;
      
    }
  
  }
  
  textSize(33);
  Rect(width/2 - textWidth(WhatToInput)/2 - 10, height/2 - 80, textWidth(WhatToInput) + 20, 50, 2, color(0), color(255));
  Text(WhatToInput, width/2, height/2 - 80 + 33, 33, color(0), 1);
  
  Rect(width/2 - textWidth(RecieveWord[0])/2, height/2 - 50/2, textWidth(RecieveWord[0]) + 20, 50, 2, color(0), color(255));
  Text(RecieveWord[0], width/2 + 33/4, height/2 + 33/2, 33, color(0), 1);
  
  
}
