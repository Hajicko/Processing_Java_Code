class textBox
{
  PVector pos, sz, margin;
  int strokeSz;
  
  float textSz, textOffset;
  String text;
  
  // type's: 0-normal, 1-transperent background
  int type;
  // different textBox states: -1-don't render, 0-normal, 1-mouse hovered over, 2-mouse clicked on
  int state;
  int stateTime;
  boolean pressed;
  
  // all colors: 0-fill normal, 1-fill hover, 2-fill clicked on, 3-strokeColor, 4-textColor
  color[] cols;
  color[] defaultCols = {color(250), color(240), color(230), color(10), color(10)};
  
  textBox(String text, PVector pos, PVector margin, float textSz)
  {
    this.text = text;
    this.pos = pos;
    this.margin = margin;
    this.textSz = textSz;
    
    /// Default setting if not set.
    textOffset = 0;
    this.type = 0;
    this.cols = defaultCols;
    
    Setup();
  }
  
  textBox(String text, PVector pos, PVector margin, float textSz, int type, color[] cols, float textOffset)
  {
    this.text = text;
    this.pos = pos;
    this.margin = margin;
    this.textSz = textSz;
    this.textOffset = textOffset;
    this.type = type;
    this.cols = cols;
    
    Setup();
  }
  
  void Setup()
  {
    state = 0;
    stateTime = 0;
    pressed = false;
    strokeSz = 1;
    
    textSize(textSz);
    sz = new PVector(textWidth(text) +margin.x *2, textSz +margin.y *2);
  }
  
  void Run()
  {
    if (state > -1)
    {
      DrawTextBox();
      MouseInside();
      
      if (state == 2 && millis() -stateTime >= buttonDuration)
      {
        state = 0;
        stateTime = 0;
        if (!pressed)
          pressed = true;
      }

    }
    
  }
  
  void DrawTextBox()
  {
      switch(type)
      {
        case 1:
          noFill();
          stroke(cols[3]);
          strokeWeight(strokeSz);
          rect(pos.x -sz.x /2, pos.y -sz.y /2, sz.x, sz.y);
          fill(cols[4]);
          textSize(textSz);
          textAlign(CENTER, CENTER);
          text(text, pos.x, pos.y +textOffset);
          break;
        default:
          fill(cols[state]);
          stroke(cols[3]);
          strokeWeight(strokeSz);
          rect(pos.x -sz.x /2, pos.y -sz.y /2, sz.x, sz.y);
          fill(cols[4]);
          textSize(textSz);
          textAlign(CENTER, CENTER);
          text(text, pos.x, pos.y +textOffset);
          break;
        
      }
  }
  
  public int MouseInside()
  {
    if (mouseX > pos.x -sz.x /2 && mouseX < pos.x +sz.x /2 && mouseY > pos.y -sz.y /2 && mouseY < pos.y +sz.y /2)
    {
      if (mousePressed)
      {
          state = 2;
          stateTime = millis();
      }
      else if (state != 2)
        state = 1;
    }
    else if (state == 1)
      state = 0;
    
    return state;
  }
  
  public void Reset()
  {
    state = 0;
    stateTime = 0;
    pressed = false;
  }
  
}
