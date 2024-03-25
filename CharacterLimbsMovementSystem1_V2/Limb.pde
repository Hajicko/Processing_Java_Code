class Limb
{
  PVector pos, size, offsetSize;
  float   angle;
  
  color   strkCol = color(10);
  
  Limb()
  {
    pos   = new PVector(0, 0);
    size  = new PVector(10, 30);
    angle = 0;
    
    FindOffsetSize();
    
  }
  
  Limb(PVector inPos, PVector inSize, float inAngle)
  {
    pos   = inPos;
    size  = inSize;
    angle = inAngle;
    
    FindOffsetSize();
    
  }
  
  void Render()
  {
    stroke(strkCol);
    strokeWeight(1);
    
    fill(240);
    
    pushMatrix();
      
      translate(pos.x, pos.y);
      rotate(angle );//
      rect(offsetSize.x, offsetSize.y, size.x, size.y -offsetSize.y);
      
    popMatrix();
    
    fill(0);
    textSize(10);
    text(degrees(angle), pos.x, pos.y +40);
    textSize(7);
    text("(" +pos.x +", " +pos.y +")", pos.x, pos.y +20);
    
    stroke(240, 10, 10);
    strokeWeight(5);
    point(pos.x, pos.y);
    
    stroke(10, 10, 240);
    strokeWeight(5);
    point(pos.x +cos(angle +radians(90) ) *(size.y +offsetSize.y), pos.y +sin(angle +radians(90) ) *(size.y +offsetSize.y) );
    
  }
  
  void FindOffsetSize()
  {
    /// If the height of the inputted limb size y is bigger than the size x on the limb then the offset value is size x of the limb
    if (size.y > size.x)
      offsetSize = new PVector(-size.x /2, -size.x /2);
    else
      offsetSize = new PVector(-size.x /2, -size.y /2);
      
    
    
  }
  
  void UpdateAngle(PVector inNewPosPt)
  {
    PVector combinedPos = new PVector(pos.x -inNewPosPt.x, pos.y -inNewPosPt.y);
    
    angle = (atan2(combinedPos.y, combinedPos.x) +radians(90) );
    
    
  }
  
  
}
