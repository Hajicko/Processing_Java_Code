import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Component;

Robot robot;

Terrain WorldT;
PImage WorldImg;

int WindowSetPosX;
int WindowSetPosY;
int WindowSetX = 0;
int WindowSetY = 0;
color BackgroundCol = color(0, 0, 255);
float[] CameraPos = {-50, 300, -50};
float[] CameraRotations = {0, -1, 0};
float CameraViewAngle = radians(160);
float CameraLookingBallRadius = 200;
float RenderTim = 20;
float[] RenderRange = {0.01, 100 *RenderTim};
float AngleXZ = 45;
float AngleY = -45;
float MinAngleMovementY = -80;
float MaxAngleMovementY = 80;
float MouseLookingSpeed = 0.2;
float CameraMoveSpeed = 5;
float KeyLookingSpeed = 1;

int MouseMovement = 0;
boolean[] Keys = new boolean[223];
boolean KeyPressed = false;

void setup() {
  fullScreen(P3D);
  surface.setLocation(0, 30);
  //size(500, 500, P3D);
  //WindowSetPosX = 0;//round(displayWidth/2) -round(width/2);
  //WindowSetPosY = 30;//round(displayHeight/2) -round(height/2);
  //surface.setLocation(WindowSetPosX, WindowSetPosY);
  surface.setResizable(false);
  //println(frame.getX());
  //println(frame.getY());
  //noCursor();
  //cursor(CROSS);
  
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
  
  WindowSetX = round(displayWidth/2) +(displayWidth-width); //frame.getLocation().x +width/2;//
  WindowSetY = round(displayHeight/2) +24;//+(displayHeight-height);//frame.getLocation().y +height/2;//
  //println("WinXY: " +WindowSetX +" | " +WindowSetY);
  UpdateMousePos();
  //println("WinXY: " +WindowSetX +" | " +WindowSetY);
  
  int Num = int(new File(dataPath("Assets/Saves")).listFiles().length +1);
  if (WorldImg == null)
    if (new File(dataPath("Assets/Saves/Map-" +Num +".png")).exists())
      WorldImg = loadImage(dataPath("Assets/Saves/Map-" +Num +".png"));
    else
    {
      WorldImg = createImage(100, 100, ARGB);
      noiseDetail(52);
      randomSeed(33);
      int[] Nums = new int[256];
      for (int RRNums = 0; RRNums < 256; RRNums++)
        Nums[RRNums] = round(random(0, 1));
        
      for (int LPx1 = 0; LPx1 < WorldImg.width; LPx1++)
        for (int LPy1 = 0; LPy1 < WorldImg.height; LPy1++)
        {
          float[] Val = {map(noise(LPx1, LPy1, 0) *0.1, 0, 1, 0, 255*3), map(noise(LPx1, LPy1, 1) *0.1, 0, 1, 0, 255*3), map(noise(LPx1, LPy1, 2) *0.1, 0, 1, 0, 255*3)};
          WorldImg.set(LPx1, LPy1, color(Val[0], Val[1], Val[2]));
          //WorldImg.set(LPx1, LPy1, color(map(noise(LPx1, LPy1) *0.4, 0, 1, 0, 255)));
        }
        
      WorldImg.save(dataPath("Assets/Saves/Map-" +Num +".png"));
    }
  WorldT = new Terrain(-1000, 0, -1000, 2000, 2000, WorldImg);
  
  //println("\n" +(displayHeight -WindowSetY) +", " +(displayHeight -height) +"\n");
  
}

void draw() {
  background(0, 0, 255);
  
  //perspective(PI/3.0, width/height,  ((height/2.0) / tan(PI*60.0/360.0))/10,  ((height/2.0) / tan(PI*60.0/360.0)) *10);
  perspective(CameraViewAngle/2, 2, RenderRange[0], RenderRange[1]);
  camera(CameraPos[0], CameraPos[1], CameraPos[2], CameraPos[0] + CameraLookingBallRadius * cos(radians(AngleXZ)) * cos(radians(AngleY)), CameraPos[1] + CameraLookingBallRadius * sin(radians(AngleY)), 
  CameraPos[2] + CameraLookingBallRadius * sin(radians(AngleXZ)) * cos(radians(AngleY)), CameraRotations[0], CameraRotations[1], CameraRotations[2]); 
  
  //TexturedCube(CameraPos[0] -2.5, CameraPos[1] -5, CameraPos[2] -2.5, 5, 1, 5, null, 2, color(0), color(255), 1);
  
  Point(CameraPos[0], 0, CameraPos[2], 10, color(255, 0, 0));
  
  XYZDraw(0, 0.1, 0, CameraLookingBallRadius, 5, 10, 0);
  //TexturedCube(50, 50, 50, 50, 50, 50, null, 2, color(255), color(0), 1);
  
  WorldT.Draw();
  
  if (keyPressed)
    KeyResults();
    
  //we check to see if the mouses pos change then run updater
  if (MouseMovement == 0 && (mouseY != WindowSetY))//mouseX != WindowSetX || 
    UpdateMousePos();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void UpdateMousePos() {
    AngleXZ += (WindowSetX - mouseX) * MouseLookingSpeed;
    if (mouseY > pmouseY && AngleY >= MinAngleMovementY) 
      AngleY += -abs((mouseY -pmouseY) * MouseLookingSpeed);
    else if (mouseY < pmouseY && AngleY <= MaxAngleMovementY) 
      AngleY += abs((mouseY -pmouseY) * MouseLookingSpeed);
    
    //println("MouseXY: Be: " +mouseX +" | " +mouseY);
    robot.mouseMove(WindowSetX, WindowSetY +30);
    mouseX = WindowSetX;
    pmouseX = WindowSetX;
    mouseY = WindowSetY;
    pmouseY = WindowSetY;
    //println("MouseXY: Af: " +mouseX +" | " +mouseY);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  //ESC
  if (keyCode == 27)
    key = 0;
  
  Keys[keyCode] = true;
  KeyPressed = true;
  
  KeyResults();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  Keys[keyCode] = false;
  KeyPressed = false;
  
  KeyResults();
  
  //ESC
  if (keyCode == 27) {
    if (MouseMovement == 0) {
      MouseMovement = 1;
      cursor(ARROW);
      
    } else if (MouseMovement == 1) {
      MouseMovement = 0;
      //noCursor();
      cursor(CROSS);
      
    }
    
  }
  
  //End
  if (keyCode == 3)
    exit();
  
  //println("key: " + key + ", keyCode: " + keyCode);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void KeyResults() {
  //UP
  if (Keys[38]) {
    //DOWN
    if (MaxAngleMovementY > AngleY + KeyLookingSpeed) {
      AngleY += KeyLookingSpeed;
      
    } else {
      AngleY = MaxAngleMovementY;
      
    }
    
  }
  //LEFT
  if (Keys[37]) {
    AngleXZ += KeyLookingSpeed;
    
  }
  //DOWN
  if (Keys[40]) {
    //UP
    if (MinAngleMovementY < AngleY - KeyLookingSpeed) {
      AngleY -= KeyLookingSpeed;
      
    } else {
      AngleY = MinAngleMovementY;
      
    }
    
  }
  //RIGHT
  if (Keys[39]) {
    AngleXZ -= KeyLookingSpeed;
    
  }
  
  //w
  if (Keys[87]) {
    CameraPos[2] += (sin(radians(AngleXZ))) * CameraMoveSpeed;
    CameraPos[0] += (cos(radians(AngleXZ))) * CameraMoveSpeed;
    
  }
  //a
  if (Keys[65]) {
    CameraPos[2] += (sin(radians(AngleXZ + 90))) * CameraMoveSpeed;
    CameraPos[0] += (cos(radians(AngleXZ + 90))) * CameraMoveSpeed;
    
  }
  //s
  if (Keys[83]) {
    CameraPos[2] -= (sin(radians(AngleXZ))) * CameraMoveSpeed;
    CameraPos[0] -= (cos(radians(AngleXZ))) * CameraMoveSpeed;
    
  }
  //d
  if (Keys[68]) {
    CameraPos[2] += (sin(radians(AngleXZ - 90))) * CameraMoveSpeed;
    CameraPos[0] += (cos(radians(AngleXZ - 90))) * CameraMoveSpeed;
    
  }
  
  //Space
  if (Keys[32]) {
    CameraPos[1] += CameraMoveSpeed;
    
  }
  
  //Shift
  if (Keys[16]) {
    CameraPos[1] -= CameraMoveSpeed;
    
  }
  
}
