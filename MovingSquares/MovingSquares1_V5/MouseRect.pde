class MouseRect extends Rectangle
{
  MouseRect ()
  {
    
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------
  
  /// This function updates the square like it's position and render.
  void Update()
  {
    /// I-0 Check to see if the mouse is inside the square.
    if (MouseInsideSq() )
    {
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
      
    } /// E-0
    
  }
///--------------------------------------------------------------------------------------------------------------------------------
  
  /// This function updates the square like it's position and render.
  void Render()
  {
    /// I-0 Check to see if the mouse is inside the square.
    if (MouseInsideSq() )
    {
      /// Render the square to the window.
      super.Render(1);
      
    } /// I-0
    /// E-0 Else then the mouse isn't in the square so run this function.
    else
    {
      super.Render(0);
        
    } /// E-0
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------

  /// This function finds out if the mouse is inside the square.
  boolean MouseInsideSq()
  {
  //  if (mouseX >= pos.x && mouseX <= pos.x +sz.x && mouseY >= pos.y && mouseY <= pos.y +sz.y)
  //    return true;
      /// Check to see if one of the mouse's cords are out of bounds of the square. This is faster then the other if statement above.
      if (mouseX < pos.x || mouseX > pos.x +sz.x || mouseY < pos.y || mouseY > pos.y +sz.y)
          return false;
      
      return true;
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------

  /// This function finds the new square position and updates it releative to the mouses new position.
  void NewSqPos()
  {
      //PVector posCen = new PVector(pos.x +sz.x /2, pos.y +sz.y /2);
      
  //    pos = ;
  
    /// I-0 Check to see if the mouse has moved since the last update, and if so then update the squares position.
    if (mouseX != pmouseX || mouseY != pmouseY)
    {
      /// I-1 UP from Square center
      if (mouseY < pos.y)
      {
        if (pos.y +(mouseY -pos.y) *sqMoveSpeed > 0)
          pos.y += (mouseY -pos.y) *sqMoveSpeed;
        else
          pos.y = 0;
          
      }
      /// I-1 RIGHT from Square center
      if (mouseX > pos.x +sz.x)
      {
        if (pos.x +(mouseX -(pos.x +sz.x) ) *sqMoveSpeed < width -sz.x)
          pos.x += (mouseX -(pos.x +sz.x) ) *sqMoveSpeed;
        else
          pos.x = width -sz.x;
          
      }
          
      /// I-1 DOWN from Square center
      if (mouseY > pos.y +sz.y)
      {
        if (pos.y +(mouseY -(pos.y +sz.y) ) *sqMoveSpeed < height -sz.y)
          pos.y += (mouseY -(pos.y +sz.y) ) *sqMoveSpeed;
        else
          pos.y = height -sz.y;
          
      }
          
      /// I-1 LEFT from Square center
      if (mouseX < pos.x)
      {
        if (pos.x +(mouseX -pos.x) *sqMoveSpeed > 0)
          pos.x += (mouseX -pos.x) *sqMoveSpeed;
        else
          pos.x = 0;
          
      }
      
    }/// I-0  
    
  }
  
}
