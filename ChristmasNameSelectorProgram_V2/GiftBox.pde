

class GiftBox 
{
  PVector startingPos, sz;
  String message;
  
  int stage;
  
  float rotationShake, startShakeAngle, currentShakeAngle, addAngle, shakeTime;
  int rotationShakeDir;
  
  PShape[] giftBoxPShape;
  PVector[] giftBoxPShapePos;
  PVector[] giftBoxPShapeSz;
  boolean giftBoxGrown;
  
  ArrayList<rocket> rocketArrList;
  float fireworkTimeTracker;
  
  GiftBox(PVector startingPos, PVector sz, String message)
  {
    this.startingPos = startingPos;
    this.sz = sz;
    this.message = message;
    
    Setup();
  }
 
  void Setup()
  {
    stage = -1;
    rotationShake = 0;
    rotationShakeDir = 1;
    startShakeAngle = radians(10);
    currentShakeAngle = startShakeAngle;
    addAngle = -radians(2);
    shakeTime = 0;
    
    giftBoxPShape = new PShape[2];
    giftBoxPShapePos = new PVector[2];
    giftBoxPShapeSz = new PVector[2];
    String[] pShapeFileLoc = {"TopOfGiftBox_V2", "BottomOfGiftBox_V2"};
    for (int lp0 = 0; lp0 < 2; lp0++)
    {
      giftBoxPShape[lp0] = loadShape(dataPath(pShapeFileLoc[lp0] +".svg"));//
      giftBoxPShapeSz[lp0] = new PVector(giftBoxPShape[lp0].width *sz.x, giftBoxPShape[lp0].height *sz.y);
      giftBoxPShapePos[lp0] = new PVector(startingPos.x, startingPos.y);
    }
    
    /// Add the rocket arraylist.
    rocketArrList = new ArrayList<rocket>();
    fireworkTimeTracker = 0;
      
  }
 
  void Run()
  {
    
    
    for (int lp0 = 0; lp0 < rocketArrList.size(); lp0++)
    {
      rocket r1 = rocketArrList.get(lp0);
      r1.run();
      
      if (r1.stage == 2)
        rocketArrList.remove(r1);
    }
    
    if (stage == -1)
      GiftBoxShapes();
    if (stage == 0)
    {
      GiftBoxShapes();
      Shake();
    }
    else if (stage == 1)
    {      
      shape(giftBoxPShape[1], giftBoxPShapePos[1].x -(giftBoxPShapeSz[1].x) /2, giftBoxPShapePos[1].y -(giftBoxPShapeSz[1].y) /2, giftBoxPShapeSz[1].x, giftBoxPShapeSz[1].y);
      fill(0);
      textFont(customFont);
      textSize(((sz.y + sz.x) /2) *50);
      textAlign(CENTER);
      text(message, startingPos.x -giftBoxPShapeSz[1].x /2, startingPos.y -giftBoxPShapeSz[1].y /2, giftBoxPShapeSz[1].x, giftBoxPShapeSz[1].y);
      shape(giftBoxPShape[0], giftBoxPShapePos[0].x -(giftBoxPShapeSz[0].x) /2, giftBoxPShapePos[0].y -giftBoxPShapeSz[0].y, giftBoxPShapeSz[0].x, giftBoxPShapeSz[0].y);
      
      if (startingPos.y -giftBoxPShapePos[0].y <= 600)
      {
        giftBoxPShapePos[0].y += -10;
        giftBoxPShapePos[1].y +=  10;
      }
      else
      {
        fireworkTimeTracker = millis();
        stage++;
      }
      
    }
    else if (stage == 2)
    {
      if (millis() -fireworkTimeTracker > 2 *1000)
      {
        for (int lp0 = 0; lp0 < 1 +round(random(0, 1)); lp0++)
        {
          float rocketAngle = radians(90) +radians(random(-45, 45)), rocketSpeed = 0, rocketDist = 50 +random(150, height -150);
          int rocketDuration = 0;
          PVector rocketStartPoint = new PVector(width /2, height -100);
          
          rocketDuration = round(random(0.6, 1.4)) * 1000;
          //rocketDist = (dist(rocketStartPoint.x, rocketStartPoint.y, rocketStartPoint.x + cos(rocketAngle) * rocketDuration, rocketStartPoint.x + sin(rocketAngle) * rocketDuration));
          rocketSpeed = (rocketDist +0.0) /(rocketDuration);
          rocketArrList.add(new rocket(rocketStartPoint, new PVector(15, 30), rocketAngle, rocketSpeed, millis(), rocketDuration, 4 *1000));
          
        }
        fireworkTimeTracker = millis();
        
      }
      
      fill(0);
      textFont(customFont);
      textSize(((sz.y + sz.x) /2) *50);
      textAlign(CENTER);
      text(message, startingPos.x -giftBoxPShapeSz[1].x /2, startingPos.y -giftBoxPShapeSz[1].y /2, giftBoxPShapeSz[1].x, giftBoxPShapeSz[1].y);
      //text("Merry, Chrismas! Love Joy.", (giftBoxPShapeSz[1].x) /2, startingPos.y, startingPos.x, startingPos.y);
      
    }
    
  }
  
  void GiftBoxShapes()
  {
      if (mouseX > startingPos.x -(giftBoxPShape[0].width *sz.x) /2 && mouseX < startingPos.x +(giftBoxPShape[0].width *sz.x) /2 &&
          mouseY > startingPos.y -(giftBoxPShape[0].height *sz.y) && mouseY < startingPos.y +(giftBoxPShape[1].height *sz.y) /2)
      {
        if (mousePressed && stage == -1)
        {
          stage = 0;
          
          shakeTime = millis();
          
          SE.PlaySound(4, 3500);
          //SE.CueSound(3);
        }
        if (!giftBoxGrown)
        {
          
          giftBoxPShapeSz[0].x = giftBoxPShape[0].width *(sz.x +0.1);
          giftBoxPShapeSz[0].y = giftBoxPShape[0].height *(sz.y +0.1);
          giftBoxPShapeSz[1].x = giftBoxPShape[1].width *(sz.x +0.1);
          giftBoxPShapeSz[1].y = giftBoxPShape[1].height *(sz.y +0.1);
          giftBoxGrown = true;
        }
        
        
      }
     else if (giftBoxGrown &&
              !(mouseX > startingPos.x -(giftBoxPShape[0].width *sz.x) /2 && mouseX < startingPos.x +(giftBoxPShape[0].width *sz.x) /2 &&
                mouseY > startingPos.y -(giftBoxPShape[0].height *sz.y) && mouseY < startingPos.y +(giftBoxPShape[1].height *sz.y) /2))
      {
        giftBoxPShapeSz[0].x = giftBoxPShape[0].width *sz.x;
        giftBoxPShapeSz[0].y = giftBoxPShape[0].height *sz.y;
        giftBoxPShapeSz[1].x = giftBoxPShape[1].width *sz.x;
        giftBoxPShapeSz[1].y = giftBoxPShape[1].height *sz.y;
        giftBoxGrown = false;
        
        //if (mousePressed && stage == -1)
        //{
        //  stage = 0;
          
        //  shakeTime = millis();
          
        //  SE.PlaySound(4, 3500);
        //  //SE.CueSound(3);
        //}
      }
        
        
    pushMatrix();
      translate(startingPos.x, startingPos.y);
      rotate(rotationShake);
      shape(giftBoxPShape[1], 0 -(giftBoxPShapeSz[1].x) /2, -(giftBoxPShapeSz[1].y) /2, giftBoxPShapeSz[1].x, giftBoxPShapeSz[1].y);
      shape(giftBoxPShape[0], 0 -(giftBoxPShapeSz[0].x) /2, -giftBoxPShapeSz[0].y, giftBoxPShapeSz[0].x, giftBoxPShapeSz[0].y);
    popMatrix();
  }
 
  void Shake()
  {
    if (rotationShakeDir == 1 && millis() -shakeTime < SE.allSounds.get(4).duration() *1000)
    {
      if (rotationShake >= currentShakeAngle)
      {
        rotationShakeDir = -1;
        
        if (currentShakeAngle > 0)
          currentShakeAngle += addAngle;
      }
        
      rotationShake += radians(1);
    }
    else if (rotationShakeDir == -1)
    {
      if (rotationShake <= -currentShakeAngle)
      {
        rotationShakeDir = 1;
        
      }
        
      rotationShake += addAngle;
    }// radians(1)
    else if (rotationShake != 0)
    {
      rotationShake = 0;
      stage++;
      
      for (int lp0 = 0; lp0 < 5; lp0++)
      {
        float rocketAngle = radians(90) +radians(random(-45, 45)), rocketSpeed = 0, rocketDist = 50 +random(50, height -150);
        int rocketDuration = 0;
        PVector rocketStartPoint = new PVector(width /2, height -100);
        
        rocketDuration = round(random(0.6, 1.4)) * 1000;
        //rocketDist = (dist(rocketStartPoint.x, rocketStartPoint.y, rocketStartPoint.x + cos(rocketAngle) * rocketDuration, rocketStartPoint.x + sin(rocketAngle) * rocketDuration));
        rocketSpeed = (rocketDist +0.0) /(rocketDuration);
        rocketArrList.add(new rocket(rocketStartPoint, new PVector(15, 30), rocketAngle, rocketSpeed, millis(), rocketDuration, 4 *1000));
        
      }
      
    }
      
      
  }
  
  
  
  
}
