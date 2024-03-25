

class lightTrail
{
  PVector pos, sz, arcAngle;
  
  float time, duration;
  
  int stage, id, changeDir, timeChange; 
  
  color lightCol;
  
  lightTrail(PVector pos, PVector sz, PVector arcAngle, int changeDir, float time, float duration, color lightCol, int id) 
  {
    this.pos = pos;
    this.sz = sz;
    this.arcAngle = arcAngle;
    this.changeDir = changeDir;
    this.time = time;
    this.duration = duration;
    this.lightCol = lightCol;
    this.id = id;
    
    Setup();
  }
  
  
  void Setup()
  {
    stage = 0;
    timeChange = 0;
    
  }
  
  void run() 
  {
    
    if (stage == 0 && millis() -time <= duration)
    {
      move();
      Draw();
    }
    else
      if (stage == 0)
        stage++;
    
  }
  
  void move() 
  {
    //print("[ Min: " + minute() + ", Sec: " + second() + ", Mil: " + millis() + "], ");
    
    //if (millis() -time >= timeChange +2)
    //{
      if (changeDir == -1 && arcAngle.x - arcAngle.y > -PI /2)
        arcAngle.x -= ((PI /2) /(duration /100.0));//-
      else if (arcAngle.y - arcAngle.x < PI /2)
        arcAngle.y += ((PI /2) /(duration /100.0));//+
        
    //  timeChange += 2;
    //}
    
  }
  
  void Draw()
  {
    stroke(lightCol, 255 -(255 /duration) *(millis() -time));
    strokeWeight(3);
    noFill();
    
    arc(pos.x, pos.y, sz.x, sz.y, arcAngle.x, arcAngle.y);
    
    //fill(0);
    //textSize(15);
    //text(id, pos.x, pos.y);
  }
  
}
