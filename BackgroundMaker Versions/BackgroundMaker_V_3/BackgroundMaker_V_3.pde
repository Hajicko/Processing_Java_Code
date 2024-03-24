ArrayList<ClassScreenShotSave> ScreenShots = new ArrayList<ClassScreenShotSave>();
color C1 = color(255, 255, 255);
color C2 = color(0, 0, 0);
color C3 = color(0, 0, 0);
color C4 = color(random(255), random(255), random(255));
int AmountOfPointsX = 500 + 2;
int AmountOfPointsY = 400 + 2;
color[] ColorResult1 = new color[AmountOfPointsX];
color[] ColorResult2 = new color[AmountOfPointsX];
color[][] GradientColorBuild = new color[AmountOfPointsX][AmountOfPointsY];
float RectSizeX;
float RectSizeY;
int OnWRectNum = -1;
float OnWRectMouseY = 0;
color OnWRectTemColor = color(0);
//Sound Stuff >
import processing.sound.*;
Sound CameraSound;
//Sound Stuff <

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  
  //fullScreen();
  size(1024, 600);
  
  RectSizeX = width/AmountOfPointsX;
  RectSizeY = height/AmountOfPointsY;
  
  GradientColorFunction(C1, C4, AmountOfPointsX, ColorResult1);
  GradientColorFunction(C2, C3, AmountOfPointsX, ColorResult2);
  
  for (int X = 0; X < AmountOfPointsX; X++) {
    color[] TemColor = new color[AmountOfPointsY];
    GradientColorFunction(ColorResult1[X], ColorResult2[X], AmountOfPointsY, TemColor);
    for (int Y = 0; Y < AmountOfPointsY; Y++) {
      GradientColorBuild[X][Y] = TemColor[Y];
    }
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  
  DrawGradientColor2(0, 0, RectSizeX, RectSizeY, 1, GradientColorBuild, GradientColorBuild);
  
  if (OnWRectNum != -1) {
    TextFunction(red(OnWRectTemColor) + ", " + green(OnWRectTemColor) + ", " + blue(OnWRectTemColor), 0 + OnWRectNum * (RectSizeX + 1) + RectSizeX/2, OnWRectMouseY, 15, color(255), 1);
  }
  
  //ScreenShot Code >
  for (int i = ScreenShots.size() - 1; i >= 0; i--) {
    ClassScreenShotSave ScreenShotRun = ScreenShots.get(i);
    if (ScreenShotRun.Delete == true) {
      ScreenShots.remove(i);
    }
  }
  for (ClassScreenShotSave ScreenShotRun : ScreenShots) {
    ScreenShotRun.Draw();
  }
  //ScreenShot Code <
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  
  
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  
  if (keyCode == 122) {
    ScreenShots.add(new ClassScreenShotSave("ScreenShots/BackgroundCC", ".png", "Images/IconCameraV_3.png", 10f, 10f, 35f, -2.5)); //"ScreenShots/ScreenShotNumData.txt", 
  }
  
}
