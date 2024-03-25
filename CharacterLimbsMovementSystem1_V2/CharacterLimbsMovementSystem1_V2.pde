Arm upperArm;

Limb testLimb1;

final public int WINDOW_RUN_TYPE = 0;

void settings()
{
  if (WINDOW_RUN_TYPE == 0 || WINDOW_RUN_TYPE == 1)
    size(500, 500);
  else if (WINDOW_RUN_TYPE == 2)
    fullScreen();
  
}

void setup()
{
  if (WINDOW_RUN_TYPE == 0)
    surface.setLocation(0, displayHeight /2 -height /2);
  else if (WINDOW_RUN_TYPE == 1)
    surface.setLocation(displayWidth -width, displayHeight /2 -height /2);
  
  upperArm = new Arm();
  
  testLimb1 = new Limb(new PVector(width /2, height /2), new PVector(10, 30), 0);
  
}

void draw()
{
  background(200);
  
  upperArm.Render();
  
  //testLimb1.Render();
  
  //testLimb1.UpdateAngle(new PVector(mouseX, mouseY) );
  
}
