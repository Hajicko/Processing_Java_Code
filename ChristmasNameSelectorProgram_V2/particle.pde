

class particle
{
  PVector pos, sz;
  
  float direction, speed, time, duration;
  
  int stage;
  
  particle(PVector pos, PVector sz, float direction, float speed, float time, float duration) 
  {
    this.pos = pos;
    this.sz = sz;
    this.direction = direction;
    this.speed = speed;
    this.time = time;
    this.duration = duration;
    
    Setup();
  }
  
  
  void Setup()
  {
    stage = 0;
    
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
    pos.x +=  cos(direction) * speed *9.8;// +() *9.8
    pos.y += -sin(direction) * speed *9.8;
    
    speed *= 0.925; //sqrt(2 *(sz.y + sz.y /2) *speed);
  }
  
  void Draw()
  {
    fill(230, 255 -(255 /duration) *(millis() -time));
    stroke(210, 255 -(255 /duration) *(millis() -time));
    strokeWeight(3);
    
    circle(pos.x, pos.y, (sz.x + sz.y) /2);
  }
  
}
