
class rocket 
{
  
  PVector startPos, pos, sz;
  
  float direction, speed, time, duration, explosionDuration;
  
  int stage;
  
  ArrayList<particle> particles;
  explosion fireStar;
  
  rocket(PVector startPos, PVector sz, float direction, float speed, float time, float duration, float explosionDuration) 
  {
    this.startPos = startPos;
    this.sz = sz;
    this.direction = direction;
    this.speed = speed;
    this.time = time;
    this.duration = duration;
    this.explosionDuration = explosionDuration;
    
    stage = 0;
    particles = new ArrayList<particle>();
    pos = new PVector(0, 0);
    
    //SE.PlaySound(5);
    
  }
  
  void run() 
  {
    /// Draw all smoke trail particles
    if (particles.size() > 0)
    {
      //for (particle p1 : particles)
      for (int lp0 = 0; lp0 < particles.size(); lp0++)
      {
        particle p1 = particles.get(lp0);
        p1.run(); 
        
        if (p1.stage == 1)
          particles.remove(p1);
      }
      
    }
    
    /// Draw the rocket if it is in the rocket stage.
    if (stage == 0 && millis() -time <= duration)
    {
      move();
      rocketShape();
    }
    /// Draw the explosion if it is in the explosion stage.
    else
    {
      if (stage == 0)
      {
        stage++;
        fireStar = new explosion(new PVector(pos.x, pos.y), new PVector(((sz.x + sz.y) /2) *5, ((sz.x + sz.y) /2) *5), millis(), explosionDuration, 0);
        
        // Create the Input stream
        //SE.CueSound(9, SE.allSounds.get(9).duration() *0.75);// 6 7 +round(random(0, 1))
        SE.PlaySound(7, (SE.allSounds.get(7).duration() *1000) *0.75);
        //SE.nextSound = true;
      }
      fireStar.run();
      
      /// Check to see if the fireStar has ended
      if (fireStar.stage == 1)
        stage++;
      
    }
      
    
  }
  
  void move() 
  {
    //pos.x +=  cos(direction) * speed;
    //pos.y += -sin(direction) * speed;
    pos.x = startPos.x +cos(direction) *(speed *(millis() -time));
    pos.y = startPos.y -sin(direction) *(speed *(millis() -time));
    
    //speed *= 0.925; //sqrt(2 *(sz.y + sz.y /2) *speed);
    
    //println(second() +millis() /1000.0 +": [" +second() +", " +millis() +"]");
    for (int lp0 = 0; lp0 < 2; lp0++)
      particles.add(new particle(new PVector(pos.x +cos(direction +PI) * sz.y, pos.y -sin(direction +PI) * sz.y), new PVector(((sz.x + sz.y) /2) /6 +random(0, 2.5), ((sz.x + sz.y) /2)/3 +random(0, 5)), direction +PI + +random(-PI /8, PI /8), 1, millis(), 1000));
  }
  
  void rocketShape()
  {
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(-direction +PI /2);
      
      fill(200, 50, 50);
      stroke(100, 50, 50);
      strokeWeight(3);
      
      triangle(-sz.x, 0, sz.x, 0, 0, -sz.y * .5);
      rect(-sz.x /2, 0, sz.x, sz.y);
      
      fill(150, 50, 50);
      noStroke();
      triangle(0, 0, sz.x, 0, 0, -sz.y * .5);
      rect(0, 0, sz.x /2, sz.y);
      
      noFill();
      stroke(100, 50, 50);
      strokeWeight(3);
      triangle(-sz.x, 0, sz.x, 0, 0, -sz.y * .5);
      rect(-sz.x /2, 0, sz.x, sz.y);
      
      //stroke(250);
      //strokeWeight(8);
      //line(-sz.x /2 +5 +3, 0 +5 +3, -sz.x /2 +sz.x -5 -3, 0 +sz.y -5 -3);
      //line(-sz.x /2 +5 +3, 30 +5 +3, -sz.x /2 +sz.x *.75 -5 -3, 30 +sz.y *.75 -5 -3);
    popMatrix();
  }
  
  
}
