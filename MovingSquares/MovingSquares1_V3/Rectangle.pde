/// C-0
class Rectangle
{
  PVector pos, sz;
  color sqInsideCol[], sqEdgeCol;
  final float sqMoveSpeed = 0.2;
  
  boolean mouseAct;
  
  Rectangle()
  {
    pos = new PVector(0, 0);
    sz  = new PVector(100, 100);
    sqInsideCol = new color[2];
    sqInsideCol[0] = color(240);
    sqInsideCol[1] = color(220);
    sqEdgeCol   = color(10);
    mouseAct = false;
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------

  //void NewSqPos() = null;
  
///--------------------------------------------------------------------------------------------------------------------------------

  /// This function renders the square to the Window, and it has a different fill color depending on what was passed in for it's fill color.
  void Render(int inSqInCol)
  {
      fill(sqInsideCol[inSqInCol]);
      stroke(sqEdgeCol);
      rect(pos.x, pos.y, sz.x, sz.y);
      
  }
  
  
} /// C-0
