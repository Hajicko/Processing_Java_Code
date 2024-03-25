/// C-0
class Rectangle
{
  PVector pos, sz, abvPos, abvSz;
  color sqInsideCol[], sqEdgeCol;
  final float sqMoveSpeed = 0.2;
  
  boolean mouseAct;
  
  Rectangle()
  {
    pos = new PVector(0, 0);
    sz  = new PVector(100, 100);
    abvPos = new PVector(0, 0);
    abvSz  = new PVector(100, 100);
    sqInsideCol = new color[2];
    sqInsideCol[0] = color(240);
    sqInsideCol[1] = color(220);
    sqEdgeCol   = color(10);
    mouseAct = false;
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------

  void SetAbvVectors(PVector inAbvPos, PVector inAbvSz)
  {
    abvPos = inAbvPos;
    abvSz = inAbvSz;
    
  }
  
///--------------------------------------------------------------------------------------------------------------------------------

  /// This function renders the square to the Window, and it has a different fill color depending on what was passed in for it's fill color.
  void Render(int inSqInCol)
  {
      
      if (inSqInCol != -1)
      {
        fill(sqInsideCol[inSqInCol]);
        stroke(sqEdgeCol);
        rect(pos.x, pos.y, sz.x, sz.y);
        
      }
      else
      {
        for (int Lp0 = 0; Lp0 < 4; Lp0++)
        {
          strokeWeight(3);
          //noStroke();
          if (Lp0 == 0 || Lp0 == 3)
          {
            fill(sqInsideCol[0]);//color(160) );//
            stroke(sqInsideCol[0]);//color(240) );//
            
          }
          else
          {
            fill(sqInsideCol[1]);//color(240) );//
            stroke(sqInsideCol[1]);//color(160) );//
            
          }
          
          switch(Lp0)
          {
            case 0:
                quad(pos.x, pos.y, abvPos.x, abvPos.y, abvPos.x +abvSz.x, abvPos.y, pos.x +sz.x, pos.y);
                stroke(sqInsideCol[0]);
                line(pos.x, pos.y, pos.x +sz.x, pos.y);
              break;
            case 1:
                quad(abvPos.x +abvSz.x, abvPos.y, abvPos.x +abvSz.x, abvPos.y +abvSz.y, pos.x +sz.x, pos.y +sz.y, pos.x +sz.x, pos.y);
                stroke(sqInsideCol[0]);
                line(pos.x +sz.x, pos.y, pos.x +sz.x, pos.y +sz.y);
              break;
            case 2:
                quad(abvPos.x, abvPos.y +abvSz.y, pos.x, pos.y +sz.y, pos.x +sz.x, pos.y +sz.y, abvPos.x +abvSz.x, abvPos.y +abvSz.y);
                stroke(sqInsideCol[0]);
                line(pos.x +sz.x, pos.y +sz.y, pos.x, pos.y +sz.y);
              break;
            case 3:
                quad(pos.x, pos.y, pos.x, pos.y +sz.y, abvPos.x, abvPos.y +abvSz.y, abvPos.x, abvPos.y);
                stroke(sqInsideCol[0]);
                line(pos.x, pos.y +sz.y, pos.x, pos.y);
              break;
          }
          
        }
        //noFill();
        //stroke(sqEdgeCol);
        //rect(pos.x, pos.y, sz.x, sz.y);
      
      }
      
  }
  
  
} /// C-0
