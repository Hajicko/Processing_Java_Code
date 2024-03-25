class Canvas 
{
  /// Variables
    /// This variable must be at least one
    private final int RectCount = 15;
    private final float MinPercent = 0.9;
    private final float MaxPercent = 0.9;
    
    MouseRect MR1;
    BoundRect BRArr[];
  
///--------------------------------------------------------------------------------------------------------------------------
  
  Canvas()
  {
    /// Create a Mouse Rect in memory and call the constructor.
      MR1 = new MouseRect();
      MR1.sz = new PVector(width *0.05, height *0.05);
      //MR1.SetAbvVectors();
    
    /// Create a Bound Rect in memory with the array size
      BRArr = new BoundRect[RectCount];
    
    BRArr[RectCount -1] = new BoundRect();
    BRArr[RectCount -1].sz = new PVector(width, height);
    BRArr[RectCount -1].sqInsideCol[0] = color(250);
    
    /// This for loop calls the constructor function for all the bound rects.
    for (int Lp0 = RectCount -2; Lp0 >= 0; Lp0--)
    {
      BRArr[Lp0] = new BoundRect();
      BRArr[Lp0].sz = new PVector(random(BRArr[Lp0 +1].sz.x *MinPercent, BRArr[Lp0 +1].sz.x *MaxPercent), 
                                  random(BRArr[Lp0 +1].sz.y *MinPercent, BRArr[Lp0 +1].sz.y *MaxPercent) );
      BRArr[Lp0].sqInsideCol[0] = color(Lp0 *(250 /(RectCount -1.0) ) );//color(Lp0 *(250 /(RectCount -1.0) ) );// random(10, 250), random(10, 250), random(10, 250), 100 
      
    }
    BRArr[RectCount -1].SetAbvVectors(BRArr[RectCount -2].pos, BRArr[RectCount -2].sz);
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------
  
  void Update()
  {
    MR1.Update();
    
    for (int Lp0 = 0; Lp0 < RectCount; Lp0++)
    {
      if (Lp0 < RectCount -1)
      {
        /// Lp0 = Mouse for the first thing in array after the mouse
        if (Lp0 == 0)
        {
          if (!CordsInsideSq(MR1.pos, MR1.sz, BRArr[Lp0].pos, BRArr[Lp0].sz) )
          {
            BRArr[Lp0].pos = CalcPos(MR1.pos, MR1.sz, BRArr[Lp0].pos, BRArr[Lp0].sz);
            BRArr[Lp0].SetAbvVectors(MR1.pos, MR1.sz);
            
          }
          
        }/// End of I-0
        /// Regular Rectangles
        else if (!CordsInsideSq(BRArr[Lp0 -1].pos, BRArr[Lp0 -1].sz, BRArr[Lp0].pos, BRArr[Lp0].sz) )
        {
          BRArr[Lp0].pos = CalcPos(BRArr[Lp0 -1].pos, BRArr[Lp0 -1].sz, BRArr[Lp0].pos, BRArr[Lp0].sz);
          BRArr[Lp0].SetAbvVectors(BRArr[Lp0 -1].pos, BRArr[Lp0 -1].sz);
          
        }/// End of EI-0
        
      }/// End of I-0
      
    }/// End of F-0
    
  }/// End of V-0
  
///--------------------------------------------------------------------------------------------------------------------------
  
  void Render()
  {
    /// This for loop calls the render function for all the Bound Rects.
    for (int Lp0 = RectCount -1; Lp0 >= 0; Lp0--)
    {
      BRArr[Lp0].Render();
      
    }
    
    MR1.Render();
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------
    
  PVector CalcPos(PVector inPos1, PVector inSz1, PVector inPos2, PVector inSz2)
  {
    PVector outCalPV = inPos2;//new PVector(0, 0);
    
    /// Left
    if (inPos1.x < inPos2.x)
    {
      if (outCalPV.x -((inPos2.x) -inPos1.x) >= 0)
        outCalPV.x -= ((inPos2.x) -inPos1.x );
      else 
         outCalPV.x = 0;
      
    }
    /// Right
    /// Check if the lvl 1 box is still inside of it in the Right direction.
    else if (inPos1.x +inSz1.x > inPos2.x +inSz2.x)
    {
      if (outCalPV.x +((inPos1.x +inSz1.x) -(inPos2.x +inSz2.x) ) < width -inSz2.x)
        outCalPV.x += ((inPos1.x +inSz1.x) -(inPos2.x +inSz2.x) );//inPos1.x +inSz1.x;
      else 
         outCalPV.x = width -inSz2.x;
      
    }
    
    /// Left
    if (inPos1.y < inPos2.y)
    {
      if (outCalPV.y -((inPos2.y) -inPos1.y) >= 0)
        outCalPV.y -= ((inPos2.y) -inPos1.y );
      else 
         outCalPV.y = 0;
      
    }
    /// Right
    /// Check if the lvl 1 box is still inside of it in the Right direction.
    else if (inPos1.y +inSz1.y > inPos2.y +inSz2.y)
    {
      if (outCalPV.y +((inPos1.y +inSz1.y) -(inPos2.y +inSz2.y) ) < height -inSz2.y)
        outCalPV.y += ((inPos1.y +inSz1.y) -(inPos2.y +inSz2.y) );//inPos1.y +inSz1.y;
      else 
         outCalPV.y = height -inSz2.y;
      
    }
      
    ///// Up
    //if (inPos1.y < inPos2.y)
    //{
    //  if (outCalPV.y +(inPos1.y -(inPos2.y) ) > 0)
    //    outCalPV.y += (inPos1.y -(inPos2.y) );
    //  else 
    //     outCalPV.y = 0;
      
    //}
    ///// Down
    //else if (inPos1.y +inSz1.y > inPos2.y +inSz2.y)
    //{
    //  if (outCalPV.y +(inPos1.y -(inPos2.y +inSz2.y) ) < height -inSz1.y)
    //    outCalPV.y += (inPos1.y -(inPos2.y +inSz2.y) );//inPos1.y +inSz1.y;
    //  else 
    //     outCalPV.y = height -inSz1.y;
      
    //}
      
    
    return outCalPV;
  }
      
///--------------------------------------------------------------------------------------------------------------------------------

  /// This function finds out if the mouse is inside the square.
  boolean CordsInsideSq(PVector inPos1, PVector inSz1, PVector inPos2, PVector inSz2)
  {
  //  if (mouseX >= sqPos.x && mouseX <= sqPos.x +sqSz.x && mouseY >= sqPos.y && mouseY <= sqPos.y +sqSz.y)
  //    return true;
      /// Check to see if one of the mouse's cords are out of bounds of the square. This is faster then the other if statement above.
      if (inPos1.x < inPos2.x || inPos1.x +inSz1.x > inPos2.x +inSz2.x || inPos1.y < inPos2.y || inPos1.y +inSz1.y > inPos2.y +inSz2.y)
          return false;
      
      return true;
    
  }
    
///--------------------------------------------------------------------------------------------------------------------------
  
}
