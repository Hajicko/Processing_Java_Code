class Slider
{
  PVector sliderPos, sliderSz, sliderBarPos, sliderBarSz;
  float   sliderMin = 50, sliderMax = 200, sliderBarPer = 0.25;
  
  Slider()
  {
    
    
  }
  
  void Render()
  {
    stroke(10);
    strokeWeight(10);
    fill(245);
    rect(sliderPos.x, sliderPos.y, sliderSz.x, sliderSz.y);
      
    rect(sliderBarPos.x, sliderBarPos.y, sliderBarSz.x, sliderBarSz.y);
    
    fill(10);
    textSize(20);
    text(dorZone1.circleRadius, sliderPos.x +sliderSz.x /2 -textWidth( Integer.toString(dorZone1.circleRadius) ) /2, sliderPos.y +sliderSz.y +50);
    
  }
  
  void Update()
  {
    for (int tch0 = 0; tch0 < touches.length; tch0++)
      UpdateTouches(new PVector(touches[tch0].x, touches[tch0].y) );
    
  }
  
  void UpdateTouches(PVector inPos)
  {
    
    /// Check to see if the activeLvl is on -1, if it is that means isn't selected
    if ( (activeLvl == -1 && mousePressed) &&
    (inPos.x < sliderPos.x || inPos.x > sliderPos.x +sliderSz.x || 
                           inPos.y < sliderPos.y || inPos.y > sliderPos.y +sliderSz.y) )
    {
      activeLvl = 0;
      bacCol = color(245, 200, 200);
      
    } else if (!mousePressed && activeLvl == 0)
    {
      activeLvl = -1;
      bacCol = color(245);
    }
    
    if ( ( activeLvl == 1 || (mousePressed && inPos.x >= sliderPos.x && inPos.x <= sliderPos.x +sliderSz.x && 
                              inPos.y >= sliderPos.y && inPos.y <= sliderPos.y +sliderSz.y) ) )
    {
      if (inPos.x < sliderPos.x)
        sliderBarPer = 0;
      else if (inPos.x > sliderPos.x +sliderSz.x)
        sliderBarPer = 1;
      else
        sliderBarPer = map(inPos.x, sliderPos.x, sliderPos.x +sliderSz.x, 0, 1);
      
      sliderBarPos.x = (sliderPos.x +map(sliderBarPer, 0, 1, 0, sliderSz.x) -(sliderBarSz.x /2) );
      
      /// Set the limb to the new radius size that was set
      dorZone1.SetRadius(round(map(sliderBarPer, 0, 1, sliderMin, sliderMax) ) );
      
      activeLvl = 1;
      bacCol = color(200, 245, 200);
      
    } else if (!mousePressed && activeLvl == 1)
    {
      activeLvl = -1;
      bacCol = color(245);
    }
    
    
  }
  
}
