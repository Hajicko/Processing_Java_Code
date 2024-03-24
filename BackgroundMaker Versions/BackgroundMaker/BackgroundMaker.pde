ArrayList<ClassScreenShotSave> ScreenShots = new ArrayList<ClassScreenShotSave>();
color C1 = color(random(255), random(255), random(255));
color C2 = color(random(255), random(255), random(255));
int AmountOfPoints = 1000;
int TotalAmountOfPoints = AmountOfPoints + 2;
color[] GradientColorBuild = new color[TotalAmountOfPoints];
float RectSize;
int OnWRectNum = -1;
float OnWRectMouseY = 0;
color OnWRectTemColor = color(0);
import processing.sound.*;
Sound CameraSound;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  
  fullScreen();
  
  RectSize = width/TotalAmountOfPoints;
  
  int RDirection = 0;
  int GDirection = 0;
  int BDirection = 0;
  float GradientNumR = 0;
  float GradientNumG = 0;
  float GradientNumB = 0;
  if (red(C1) > red(C2)) {
    RDirection = 1;
    GradientNumR = (red(C1) - red(C2))/(TotalAmountOfPoints - 1);
  } else if (red(C1) < red(C2)) {
    RDirection = 0;
    GradientNumR = (red(C2) - red(C1))/(TotalAmountOfPoints - 1);
  }
  if (green(C1) > green(C2)) {
    GDirection = 1;
    GradientNumG = (green(C1) - green(C2))/(TotalAmountOfPoints - 1);
  } else if (green(C1) < green(C2)) {
    GDirection = 0;
    GradientNumG = (green(C2) - green(C1))/(TotalAmountOfPoints - 1);
  }
  if (blue(C1) > blue(C2)) {
    BDirection = 1;
    GradientNumB = (blue(C1) - blue(C2))/(TotalAmountOfPoints - 1);
  } else if (blue(C1) < blue(C2)) {
    BDirection = 0;
    GradientNumB = (blue(C2) - blue(C1))/(TotalAmountOfPoints - 1);
  }
  for (int i = 0; i < TotalAmountOfPoints; i++) {
    if (i == 0) {
      GradientColorBuild[i] = C1;
    } else if (i == TotalAmountOfPoints - 1) {
      GradientColorBuild[i] = C2;
    } else {
      float TemColR = 0;
      float TemColG = 0;
      float TemColB = 0;
      if (RDirection == 0) {
        TemColR = red(C1) + i * GradientNumR;
      } else if (RDirection == 1) {
        TemColR = red(C1) - i * GradientNumR;
      }
      if (GDirection == 0) {
        TemColG = green(C1) + i * GradientNumG;
      } else if (GDirection == 1) {
        TemColG = green(C1) - i * GradientNumG;
      }
      if (BDirection == 0) {
        TemColB = blue(C1) + i * GradientNumB;
      } else if (BDirection == 1) {
        TemColB = blue(C1) - i * GradientNumB;
      }
      GradientColorBuild[i] = color(constrain(TemColR, 0, 255), constrain(TemColG, 0, 255), constrain(TemColB, 0, 255));
    }
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  
  for (int i = 0; i < TotalAmountOfPoints; i++) {
    RectFunction(0 + i * (RectSize + 1), 0, RectSize, height, GradientColorBuild[i], GradientColorBuild[i], 1);
    if (mouseX > 0 + i * (RectSize + 1) && mouseX < 0 + i * (RectSize + 1) + RectSize) {
      OnWRectNum = i;
      OnWRectTemColor = GradientColorBuild[i];
      OnWRectMouseY = mouseY;
    }
  }
  if (OnWRectNum != -1) {
    TextFunction(red(OnWRectTemColor) + ", " + green(OnWRectTemColor) + ", " + blue(OnWRectTemColor), 0 + OnWRectNum * (RectSize + 1) + RectSize/2, OnWRectMouseY, 15, color(255), 1);
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
  
  //println(key);
  //println(keyCode);
  //println();
  if (keyCode == 122) {
    ScreenShots.add(new ClassScreenShotSave("ScreenShots/BackgroundCC", ".png", "ScreenShots/ScreenShotNumData.txt", "Images/IconCameraV_3.png", 10, 10, 35, -2.5));
  }
  
}
