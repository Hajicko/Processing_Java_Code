

class explosion
{
  PVector pos, sz;
  
  float time, duration, flastRadius;
  
  int stage, explosionType; 
  
  ArrayList<lightTrail> lightTrails;
  
  color[] lightTrailCols = {color(237, 26, 26), color(26, 72, 237), color(237, 26, 153), color(26, 237, 61), color(237, 198, 26), color(154, 131, 238), color(130, 223, 237), color(234, 193, 206), color(195, 26, 237), color(195, 237, 26)};
  
  explosion(PVector pos, PVector sz, float time, float duration, int explosionType) 
  {
    this.pos = pos;
    this.sz = sz;
    this.time = time;
    this.duration = duration;
    this.explosionType = explosionType;
    
    Setup();
  }
  
  
  void Setup()
  {
    stage = 0;
    flastRadius = sz.x *2;
    
    lightTrails = new ArrayList<lightTrail>();
    
    float direction = 0;
    PVector tempPos, tempSz, arcAngle;
    int changeDir = 0;
    color lightTrailCol = lightTrailCols[round(random(0, lightTrailCols.length -1))];// color(random(200, 255), random(200, 255), random(200, 255));
    for (int lp0 = 0; lp0 < 100; lp0++)
    {
      direction = random(0, 2 *PI);//0 + (PI /2) *lp0;//random(0, PI /2);//
      
      tempPos = new PVector(pos.x, pos.y);
      tempSz  = new PVector(sz.x, sz.y);
      tempSz.x += random(-sz.x, sz.x);
      tempSz.y += random(-sz.y, sz.y);
      arcAngle = new PVector(0, 0);
      
      if (direction >= 0 && direction < PI /2) // Correct
      {
        arcAngle.x = 1.5 *PI;
        arcAngle.y = arcAngle.x;
        
        //if (direction >= 0 && direction < PI /4)
        //{
        //  tempSz.x -= ((sz.x /2) /(PI /2)) *(direction);
        //  tempSz.y += ((sz.y /2) /(PI /2)) *(direction);
        //}
        //else
        //{
        //  tempSz.x += ((sz.x /8) /(PI /2)) *(direction);
        //  tempSz.y -= ((sz.y /8) /(PI /2)) *(direction);
        //}
        
        
        tempPos.y += tempSz.y /2;
        
        changeDir = 1;
      } else if (direction >= PI /2 && direction < PI)
      {
        arcAngle.x = 2 *PI;
        arcAngle.y = 2 *PI;
        
        //tempSz.x -= (sz.x /(PI /2)) *(direction -(PI /2));
        //tempSz.y += (sz.y /(PI /2)) *(direction -(PI /2));
        
        tempPos.x -= tempSz.x /2;
        
        changeDir = -1;
      } else if (direction >= PI && direction < 1.5 *PI) // Correct
      {
        arcAngle.x = -PI /2;
        arcAngle.y = -PI /2;
        
        //tempSz.x -= (sz.x /(PI /2)) *(direction -(PI));
        //tempSz.y += (sz.y /(PI /2)) *(direction -(PI));
        
        tempPos.y += tempSz.y /2;
        
        changeDir = -1;
      } else if (direction >= 1.5 *PI && direction < 2 *PI)
      {
        arcAngle.x = PI;
        arcAngle.y = arcAngle.x;
        
        //tempSz.x -= (sz.x /(PI /2)) *(direction -(1.5 *PI));
        //tempSz.y += (sz.y /(PI /2)) *(direction -(1.5 *PI));
        
        tempPos.x += tempSz.x /2;
        
        changeDir = 1;
      }
      
      ///// Rocket explosion type
      //if (explosionType == 1)
      //  lightTrailCol = color(random(150, 255), random(150, 255), random(150, 255));
      
      lightTrails.add(new lightTrail(tempPos, tempSz, arcAngle, changeDir, millis(), duration, lightTrailCol, lp0));
      
    }
    
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
    
  }
  
  void Draw()
  {
    
    for (int lp0 = 0; lp0 < lightTrails.size(); lp0++)
    {
      lightTrail lT1 = lightTrails.get(lp0);
      lT1.run(); 
      
      if (lT1.stage == 1)
        lightTrails.remove(lT1);
    }
    
    
    
    if (flastRadius > sz.x)
    {
      fill(255);
      noStroke();
      
      circle(pos.x, pos.y, flastRadius);
      
      flastRadius *= 0.8;
    }
  }
  
}
