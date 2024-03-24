/*
  Use the wasd keys to move around and the arrow keys to look around. The shift key moves the camera down and the space key moves the camera up. 
  
  The cursor is set up for looking around also, but it has been turned off due to variations between computers.
  
  This sketch was written from scratch without the use of online tools.
*/


import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Component;

Robot robot;

Terrain WorldT = new Terrain();

int WindowSetPosX;
int WindowSetPosY;
int WindowSetX = 0;
int WindowSetY = 0;
color BackgroundCol = color(0, 0, 255);
float[] CameraPos = {-50, 300, -50};
float[] CameraRotations = {0, -1, 0};
float CameraLookingBallRadius = 200;
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
  noCursor();
  
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
  
  WindowSetX = displayWidth;//surface.getLocation().x +width/2;//round(displayWidth/2) +(displayWidth-width);
  WindowSetY = displayHeight;//surface.getLocation().y +height/2;//round(displayHeight/2) +30;//+(displayHeight-height);
  println(WindowSetX +" | " +WindowSetY);
  //robot.mouseMove(WindowSetX, WindowSetY);
  
}

void draw() {
  background(0, 0, 255);
  
  camera(CameraPos[0], CameraPos[1], CameraPos[2], CameraPos[0] + CameraLookingBallRadius * cos(radians(AngleXZ)) * cos(radians(AngleY)), CameraPos[1] + CameraLookingBallRadius * sin(radians(AngleY)), 
  CameraPos[2] + CameraLookingBallRadius * sin(radians(AngleXZ)) * cos(radians(AngleY)), CameraRotations[0], CameraRotations[1], CameraRotations[2]); 
  
  XYZDraw(0, 0.1, 0, CameraLookingBallRadius, 5, 10, 0);
  
  //ground
  //Rect(-1000, 0, -1000, radians(90), 0, 0, 2000, 2000, 2, color(0), color(0, 255, 0));
  Ellipse(0, 0, 0, radians(90), 0, 0, 2000, 2000, 2, color(0), color(90, 90, 0));
  
  //Point(0, 10, 0, radians(90), 0, 0, 15, color(255, 0, 0));
  //cloud
  //Rect(-200, 1000, -200, radians(90), 0, 0, 400, 400, 2, color(0), color(255));
  
  //println((round(width/2)) +"]["+ displayWidth +"]["+ WindowSetY +"]["+ mouseY);
  
  WorldT.Draw();
  
  if (keyPressed)
    KeyResults();
    
  ////we check to see if the mouses pos change then run updater
  //if (mouseX != pmouseX || mouseY != pmouseY)
  //  UpdateMosuePos();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void UpdateMosuePos() {
  if (MouseMovement == 0 && (mouseY != round(height/2) || mouseX != round(width/2))) 
  {
    AngleXZ += (width/2 - mouseX) * MouseLookingSpeed;
    if (mouseY > round(height/2) && AngleY >= MinAngleMovementY) 
    {
      AngleY += -abs((round(height/2) - mouseY) * MouseLookingSpeed);
      Rect(0, 0, 0, width, height/2, 0, 0, 0, 1, color(200), color(200));
      
    } else if (mouseY < round(height/2) && AngleY <= MaxAngleMovementY) 
    {
      AngleY += abs((round(height/2) -mouseY) * MouseLookingSpeed);
      Rect(0, height/2, 0, width, height/2, 0, 0, 0, 1, color(100), color(100));
      
    } 
    robot.mouseMove(WindowSetX, WindowSetY);
    
  }
  
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
      noCursor();
      
    }
    
  }
  
  //End
  if (keyCode == 3)
    exit();
  
  println("key: " + key + ", keyCode: " + keyCode);
  
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
