public final int windowSetup = 1;

DotZones dorZone1;
DotZones DZ2;

int   activeLvl;
color bacCol;

PVector sliderPos, sliderSz, sliderBarPos, sliderBarSz;
float   sliderMin = 50, sliderMax = 200, sliderBarPer = 0.25;

void settings()
{
  //if (windowSetup == 0)
  //  size(800, 800);
  //else
    fullScreen(P2D);
    //orientation(PORTRAIT);
    
  //surface.setLocation(100, 100);
  
}

void setup()
{  
  orientation(PORTRAIT);
  
  //if (windowSetup == 0)
  //  surface.setLocation(0, (displayHeight /2) -(height /2) );
    
  //surface.setTitle("DotZoneTowardsMove2_V1");
  
  activeLvl = -1;
  bacCol = color(245);
  
  sliderMax = (width < height) ? width /3 : height /3;
  
  sliderPos    = new PVector(width /4, 50);
  sliderSz     = new PVector(width /2, 100);
  sliderBarPos = new PVector(sliderPos.x +map(sliderBarPer, 0, 1, 0, sliderSz.x), sliderPos.y -25);
  sliderBarSz  = new PVector(50, sliderSz.y +25 *2);
  
  dorZone1 = new DotZones();
  //DZ1 = new DotZones(new PVector( (width /4), (height /2) ) );
  //DZ2 = new DotZones(new PVector( (width /4) *3, (height /2) ));
  
}

void draw()
{
  background(bacCol);
  
  dorZone1.Render();
  
  Slider();
  
  /// This function call will update all variables positions in the class
    if (dorZone1.updateClass && (pmouseX != mouseX || pmouseY != mouseY) )
      dorZone1.UpdatePos();
  
  //DZ2.Render();
  
}

void keyReleased()
{
  if (keyCode == ' ')
    dorZone1.FlipUpdateStatus();
    
  //if (keyCode == '')
  //  exit();
  
}

void Slider()
{
  stroke(10);
  strokeWeight(10);
  fill(245);
  rect(sliderPos.x, sliderPos.y, sliderSz.x, sliderSz.y);
  
  if ( (activeLvl == -1 && mousePressed) &&
  (mouseX < sliderPos.x || mouseX > sliderPos.x +sliderSz.x || 
                         mouseY < sliderPos.y || mouseY > sliderPos.y +sliderSz.y) )
  {
    activeLvl = 0;
    bacCol = color(245, 200, 200);
    
  } else if (!mousePressed && activeLvl == 0)
  {
    activeLvl = -1;
    bacCol = color(245);
  }
  
  if (!mousePressed && activeLvl == 1)
  {
    activeLvl = -1;
    bacCol = color(245);
  }
  else if ( ( activeLvl == 1 || (mousePressed && mouseX >= sliderPos.x && mouseX <= sliderPos.x +sliderSz.x && 
                            mouseY >= sliderPos.y && mouseY <= sliderPos.y +sliderSz.y) ) )
  {
    if (mouseX < sliderPos.x)
      sliderBarPer = 0;
    else if (mouseX > sliderPos.x +sliderSz.x)
      sliderBarPer = 1;
    else
      sliderBarPer = map(mouseX, sliderPos.x, sliderPos.x +sliderSz.x, 0, 1);
    
    sliderBarPos.x = (sliderPos.x +map(sliderBarPer, 0, 1, 0, sliderSz.x) -(sliderBarSz.x /2) );
    
    /// Set the limb to the new radius size that was set
    dorZone1.SetRadius(round(map(sliderBarPer, 0, 1, sliderMin, sliderMax) ) );
    
    activeLvl = 1;
    bacCol = color(200, 245, 200);
    
  }
  
    
  rect(sliderBarPos.x, sliderBarPos.y, sliderBarSz.x, sliderBarSz.y);
  
  fill(10);
  textSize(20);
  text(dorZone1.circleRadius, sliderPos.x +sliderSz.x /2 -textWidth( Integer.toString(dorZone1.circleRadius) ) /2, sliderPos.y +sliderSz.y +50);
  
}



float RoundToPlace(float inFloat, int inAmntOfPlaces)
{
  return ( round(inFloat *pow(10.0, inAmntOfPlaces) ) /pow(10.0, inAmntOfPlaces) );
}
