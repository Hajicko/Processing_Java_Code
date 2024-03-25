import java.awt.AWTException;
import java.awt.Robot;

Robot robot;

float CubeWidth = 50;
color BackgroundCol = color(0, 0, 255);
float[] CameraPos = {0, 200, 0};
float[] CameraRotations = {0, -1, 0};
float CameraLookingBallRadius = 200;
float AngleXZ = 0;
float AngleY = 0;
float MinAngleMovementY = -80;
float MaxAngleMovementY = 80;
float MouseLookingSpeed = 0.3;
float KeyLookingSpeed = 1;

float[][] BoxPositions = {
{100              , CubeWidth/2, 100}, 
{100 + CubeWidth  , CubeWidth/2, 100}, 
{100 + CubeWidth*2, CubeWidth/2, 100}, 
{100 + CubeWidth*2, CubeWidth/2, 100 + CubeWidth}, 
{100 + CubeWidth*2, CubeWidth/2, 100 + CubeWidth*2}, 
{100 + CubeWidth  , CubeWidth/2, 100 + CubeWidth*2}, 
{100              , CubeWidth/2, 100 + CubeWidth*2},
{100              , CubeWidth/2, 100 + CubeWidth},
{100              , CubeWidth/2 + CubeWidth, 100 + CubeWidth}
};

boolean[] Keys = new boolean[223];
boolean KeyPressed = false;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  fullScreen(P3D);
  //size(1000, 1000, P3D);
  
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  background(BackgroundCol);

  //float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  //perspective(PI/4.0, 1, cameraZ/300.0, cameraZ*300.0);

  camera(CameraPos[0], CameraPos[1], CameraPos[2], CameraPos[0] + CameraLookingBallRadius * cos(radians(AngleXZ)) * cos(radians(AngleY)), CameraPos[1] + CameraLookingBallRadius * sin(radians(AngleY)), 
  CameraPos[2] + CameraLookingBallRadius * sin(radians(AngleXZ)) * cos(radians(AngleY)), CameraRotations[0], CameraRotations[1], CameraRotations[2]); 
  
  XYZDraw(0, 0, 0);
  
  //ground
  Rect(-1000, 0, -1000, radians(90), 0, 0, 2000, 2000, 2, color(0), color(0, 255, 0));
  //cloud
  Rect(-200, 1000, -200, radians(90), 0, 0, 400, 400, 2, color(0), color(255));
  
  for (int b = 0; b < BoxPositions.length; b++) {
    Box(BoxPositions[b][0], BoxPositions[b][1], BoxPositions[b][2], CubeWidth, 2, color(0), color(255, 0, 0));
  
  }
  
  //
  //Rect(CameraPos[0] + 200, 0, 0, 0, radians(90), 0, 100, 100, 2, color(0), color(0, 255, 0));// dist(CameraPos[0], CameraPos[2], LookingPos[0], LookingPos[2])
  //Text(str(Value), CameraPos[0] + (sin((CameraPos[2] - LookingPos[2])/(CameraPos[0] - LookingPos[0])) * 100), 0, 
  //CameraPos[2] + (cos((CameraPos[2] - LookingPos[2])/(CameraPos[0] - LookingPos[0])) * 100), 
  //radians(180), atan((CameraPos[2] - LookingPos[2])/(CameraPos[0] - LookingPos[0])) + radians(90), radians(0), 33, 2, color(0), color(0, 0, 0));

  //Rect(CameraPos[0] + CameraLookingBallRadius * cos(AngleXZ) - 50, 10, CameraPos[2] + CameraLookingBallRadius * sin(AngleXZ) - 50, 
  //radians(180), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + AngleXZ + radians(270), radians(180), 100, 100, 2, color(200), color(255, 200, 200));
  
  //Rect(CameraPos[0] + CameraLookingBallRadius * cos(AngleXZ), CameraPos[1], CameraPos[2] + CameraLookingBallRadius * sin(AngleXZ), 
  //radians(180), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + AngleXZ + radians(270), radians(180), 100, 100, 2, color(200), color(255, 200, 200));
  
  //textSize(33);
  //Rect(-100, 0, -100, radians(180), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + radians(270), radians(180), textWidth(str(Value)), 50, 2, color(0), color(255, 255, 255));// dist(CameraPos[0], CameraPos[2], LookingPos[0], LookingPos[2])
  //Text(str(Value), 0, 100, 0, radians(180), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + radians(90), radians(0), 33, 2, color(0), color(0, 0, 0));
  
  if (KeyPressed) {
    KeyResults();
    
  }
  
  Line(0, 1, 0, CameraPos[0], CameraPos[1], CameraPos[2], 3, color(0));
  
  //Rect(CameraPos[0], -100, CameraPos[2], radians(270), radians(180), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + radians(315), 1000, 1000, 2, color(0), color(255));
  
  //Arc(CameraPos[0], 1, CameraPos[2], radians(90), radians(0), atan2((CameraPos[2] - LookingPos[2]), (CameraPos[0] - LookingPos[0])) + radians(180 - 47.5), 1000, 1000, radians(95), 2, color(0), color(255));
  
  //Box(0, CameraPos[1], 0, 10, 2, color(0), color(0, 255, 255));
  
  //Sphere(0, CameraPos[1], 0, 10, 2, color(0), color(0, 255, 255));
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseMoved() {
  if (mouseX != pmouseX) {
    //RIGHT
    if (mouseX > pmouseX) {
      AngleXZ -= (mouseX - pmouseX) * MouseLookingSpeed;
      
    }
      
    //LEFT
    if (mouseX < pmouseX) {
      AngleXZ -= (mouseX - pmouseX) * MouseLookingSpeed;
      
    }
    
  }
  if (mouseY != pmouseY) {
    //Mouse Moving UP
    if (mouseY > pmouseY && MinAngleMovementY < AngleY -(mouseY - pmouseY) * MouseLookingSpeed) {
      AngleY += -(mouseY - pmouseY) * MouseLookingSpeed;
      
    } else if (mouseY > pmouseY) {
      AngleY = MinAngleMovementY;
      
    }
      
    //Mouse Moving DOWN
    if (mouseY < pmouseY && MaxAngleMovementY > AngleY -(mouseY - pmouseY) * MouseLookingSpeed) {
      AngleY += -(mouseY - pmouseY) * MouseLookingSpeed;
      
    } else if (mouseY < pmouseY) {
      AngleY = MaxAngleMovementY;
      
    }
    
  }
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  Keys[keyCode] = true;
  KeyPressed = true;
  
  KeyResults();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  Keys[keyCode] = false;
  KeyPressed = false;
  
  KeyResults();
  
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
    //AngleY -= ArrowKeysMovementSpeed;
    
  }
  //LEFT
  if (Keys[37]) {
    AngleXZ += KeyLookingSpeed;
    String[] SData = {str(round(AngleXZ))};
    saveStrings("data/ScreenData.txt", SData);
    println(SData[0]);
    
  }
  //DOWN
  if (Keys[40]) {
    //UP
    if (MinAngleMovementY < AngleY - KeyLookingSpeed) {
      AngleY -= KeyLookingSpeed;
      
    } else {
      AngleY = MinAngleMovementY;
      
    }
    //AngleY += ArrowKeysMovementSpeed;
    
  }
  //RIGHT
  if (Keys[39]) {
    AngleXZ -= KeyLookingSpeed;
    String[] SData = {str(round(AngleXZ))};
    saveStrings("data/ScreenData.txt", SData);
    println(SData[0]);
    
  }
  
  float WASDMovementSpeed = 2;
  //W
  if (Keys[87]) {
    CameraPos[2] += (sin(radians(AngleXZ))) * WASDMovementSpeed;
    CameraPos[0] += (cos(radians(AngleXZ))) * WASDMovementSpeed;
    
  }
  ////A
  //if (Keys[65]) {
  //  CameraPos[2] -= (sin(AngleXZ + 90)) * WASDMovementSpeed;
  //  CameraPos[0] -= (cos(AngleXZ + 90)) * WASDMovementSpeed;
    
  //}
  //S
  if (Keys[83]) {
    CameraPos[2] -= (sin(radians(AngleXZ))) * WASDMovementSpeed;
    CameraPos[0] -= (cos(radians(AngleXZ))) * WASDMovementSpeed;
    
  }
  ////D
  //if (Keys[68]) {
  //  CameraPos[2] += (sin(AngleXZ - 90)) * WASDMovementSpeed;
  //  CameraPos[0] += (cos(AngleXZ - 90)) * WASDMovementSpeed;
    
  //}
  
  //SPACE
  if (Keys[32]) {
    CameraPos[1] += 10;
    println(CameraPos[1]);
    
  }
  
}
