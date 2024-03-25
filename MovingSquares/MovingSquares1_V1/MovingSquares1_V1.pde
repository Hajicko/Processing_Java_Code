PVector sqPos, sqSz;
color sqInsideCol[], sqEdgeCol;
final float sqMoveSpeed = 0.1;

boolean mouseAct;


void settings()
{
  size(400, 400);
  
}

void setup() 
{
   sqPos = new PVector(0, 0);
   sqSz  = new PVector(100, 100);
   sqInsideCol = new color[2];
   sqInsideCol[0] = color(240);
   sqInsideCol[1] = color(220);
   sqEdgeCol   = color(10);
   mouseAct = false;
   
}

void draw() 
{
  /// Reset the Windows background from the past loop.
  background(200);
  /// Call the update square function to update the square in this loop and render it.
  UpdateSq();
}

/// This function updates the square like it's position and render.
void UpdateSq()
{
  /// I-0 Check to see if the mouse is inside the square.
  if (MouseInsideSq() )
  {
    /// Render the square to the window.
    RenderSq(1);
    
    /// Check to see if the mouse is being pressed, if so then the mouse is inside already and is being pressed so set mouse activated to true.
    if (mousePressed)
      mouseAct = true;
    
  } /// I-0
  /// E-0 Else then the mouse isn't in the square so run this function.
  else
  {
    /// Check to see if the mouse activated boolean is true, if so then update the square position because the mouse has been locked on the square.
    if (mouseAct)
      NewSqPos();
      
    /// Check if the mouse isn't being pressed, if so then set mouse activated to false.
    if (mouseAct && !mousePressed)
      mouseAct = false;
    
    RenderSq(0);
      
  } /// E-0
  
}

//int FindOutOfBoundsDir()
//{
//    int returnVal = -1;
//    
//         if (mouseY < sqPos.y)
//        returnVal = 0;
//    else if (mouseX > sqPos.x +sqSz.x)
//        returnVal = 1;
//    else if (mouseY > sqPos.y +sqSz.y)
//        returnVal = 2;
//    else if (mouseX < sqPos.x)
//        returnVal = 3;
//    
//    return returnVal;
//}

/// This function finds the new square position and updates it releative to the mouses new position.
void NewSqPos()
{
    //PVector sqPosCen = new PVector(sqPos.x +sqSz.x /2, sqPos.y +sqSz.y /2);
    
//    sqPos = ;

  /// I-0 Check to see if the mouse has moved since the last update, and if so then update the squares position.
  if (mouseX != pmouseX || mouseY != pmouseY)
  {
    /// I-1 UP from Square center
    if (mouseY < sqPos.y)
    {
        sqPos.y += (mouseY -sqPos.y) *sqMoveSpeed;
        
    }
    /// I-1 RIGHT from Square center
    if (mouseX > sqPos.x +sqSz.x)
    {
        sqPos.x += (mouseX -(sqPos.x +sqSz.x) ) *sqMoveSpeed;
        
    }
        
    /// I-1 DOWN from Square center
    if (mouseY > sqPos.y +sqSz.y)
    {
        sqPos.y += (mouseY -(sqPos.y +sqSz.y) ) *sqMoveSpeed;
        
    }
        
    /// I-1 LEFT from Square center
    if (mouseX < sqPos.x)
    {
        sqPos.x += (mouseX -sqPos.x) *sqMoveSpeed;
        
    }
    
  }/// I-0  
  
}

/// This function finds out if the mouse is inside the square.
boolean MouseInsideSq()
{
//  if (mouseX >= sqPos.x && mouseX <= sqPos.x +sqSz.x && mouseY >= sqPos.y && mouseY <= sqPos.y +sqSz.y)
//    return true;
    /// Check to see if one of the mouse's cords are out of bounds of the square. This is faster then the other if statement above.
    if (mouseX < sqPos.x || mouseX > sqPos.x +sqSz.x || mouseY < sqPos.y || mouseY > sqPos.y +sqSz.y)
        return false;
    
    return true;
  
}

/// This function renders the square to the Window, and it has a different fill color depending on what was passed in for it's fill color.
void RenderSq(int inSqInCol)
{
    fill(sqInsideCol[inSqInCol]);
    stroke(sqEdgeCol);
    rect(sqPos.x, sqPos.y, sqSz.x, sqSz.y);
    
}
