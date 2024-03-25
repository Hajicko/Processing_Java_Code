class Arm
{
  private int AmntOfLimbs;
  private Limb ArrOfLimbs[];
  
  float pcenCirToMouseAngle;
  
  Arm()
  {    
    Setup();
    
  }
  
  void Setup()
  {
    AmntOfLimbs = 2;
    ArrOfLimbs = new Limb[AmntOfLimbs];
    
    //ArrOfLimbs[0] = new Limb(new PVector(width /2, height /2), new PVector(10, 30), 0);
    
    //ArrOfLimbs[1] = new Limb(new PVector(width /2, height /2), new PVector(5, 70), 0);
    
    PVector posPt1 = new PVector(width /2, height /2);
    PVector posPt2 = new PVector(posPt1.x +300, posPt1.y);
    
    float limbLength = dist(posPt1.x, posPt1.y, posPt2.x, posPt2.y);
    
    float splitSz = limbLength /AmntOfLimbs;
    
    float limbAngle = (atan2(posPt1.x -posPt2.x, posPt1.y -posPt2.y) );
    
    for (int Lp1 = 0; Lp1 < AmntOfLimbs; Lp1++)
    {
      ArrOfLimbs[Lp1] = new Limb(new PVector(posPt1.x +( cos(limbAngle) *splitSz *Lp1), 
                                             posPt1.y +( sin(limbAngle) *splitSz *Lp1) ), 
                                 new PVector(75, splitSz +15), 
                                 limbAngle );
      
    }
    
    pcenCirToMouseAngle = 0;
    
  }
  
  void Render()
  {
    int loopCnt = 0;
    for (Limb arrLimb : ArrOfLimbs)
    {
       arrLimb.Render();
       
       if (loopCnt > 0)
       {
         PVector posPtChk1 = new PVector(0, 0);
         if (loopCnt < AmntOfLimbs -1)
         {
           posPtChk1 = ArrOfLimbs[loopCnt -1].pos;
           
         } else
         {
           posPtChk1 = new PVector(mouseX, mouseY);           
         }
           
          fill(10);
          float cenCirToMouseAngle = (atan2(ArrOfLimbs[loopCnt -1].pos.x -mouseX, ArrOfLimbs[loopCnt -1].pos.y -mouseY) ) +radians(180);
          text(degrees(cenCirToMouseAngle), ArrOfLimbs[loopCnt -1].pos.x, ArrOfLimbs[loopCnt -1].pos.y +(arrLimb.size.y +arrLimb.offsetSize.y) *2 +20);
          
          float aToBRadians = atan2(arrLimb.pos.x -ArrOfLimbs[loopCnt -1].pos.x, arrLimb.pos.y -ArrOfLimbs[loopCnt -1].pos.y);
          aToBRadians = RefactoredAngle(aToBRadians);
          
          text(degrees(aToBRadians), ArrOfLimbs[loopCnt -1].pos.x, ArrOfLimbs[loopCnt -1].pos.y -(arrLimb.size.y +arrLimb.offsetSize.y) *2 -20);
          
           
         float circlePunctureDist = dist(arrLimb.pos.x, arrLimb.pos.y, posPtChk1.x, posPtChk1.y);//arrLimb.size.y +arrLimb.offsetSize.y -0.1;//
         if (circlePunctureDist < arrLimb.size.y +arrLimb.offsetSize.y)
         {
          if (dist(arrLimb.pos.x, arrLimb.pos.y, mouseX, mouseY) < (arrLimb.size.y +arrLimb.offsetSize.y))
          {    
            float punctureAmnt = (arrLimb.size.y +arrLimb.offsetSize.y) -dist(arrLimb.pos.x, arrLimb.pos.y, mouseX, mouseY);
            float arcAngle     = punctureAmnt /(arrLimb.size.y +arrLimb.offsetSize.y);
            
            /// Upper half of the circle
            if (InsideCircleArc(cenCirToMouseAngle, aToBRadians, aToBRadians +radians(180) ) )
            {
              stroke(10, 240, 240);
              strokeWeight(5);
              fill(10, 240, 240, 100);
              //arc(arrLimb.pos.x, arrLimb.pos.y, (arrLimb.size.y +arrLimb.offsetSize.y) *2, (arrLimb.size.y +arrLimb.offsetSize.y) *2, radians(-90) -aToBRadians, radians(90) -aToBRadians, PIE);
          
              fill(10);
              textSize(15);
              text("1", arrLimb.pos.x, arrLimb.pos.y);
              
              arcAngle = -arcAngle;
              
            } /// Bottom half of the circle
            else if (InsideCircleArc(cenCirToMouseAngle, aToBRadians +radians(180), aToBRadians +radians(360) ) )
            {
              stroke(240, 240, 10);
              strokeWeight(5);
              fill(240, 240, 10, 100);
              //arc(arrLimb.pos.x, arrLimb.pos.y, (arrLimb.size.y +arrLimb.offsetSize.y) *2, (arrLimb.size.y +arrLimb.offsetSize.y) *2, radians(90) -aToBRadians, radians(270) -aToBRadians, PIE);
          
              fill(10);
              textSize(15);
              text("2", arrLimb.pos.x, arrLimb.pos.y);
              
            }
            
            arrLimb.pos = new PVector(ArrOfLimbs[loopCnt -1].pos.x +sin(aToBRadians +arcAngle ) *(ArrOfLimbs[loopCnt -1].size.y +ArrOfLimbs[loopCnt -1].offsetSize.y), 
                                 ArrOfLimbs[loopCnt -1].pos.y +cos(aToBRadians +arcAngle ) *(ArrOfLimbs[loopCnt -1].size.y +ArrOfLimbs[loopCnt -1].offsetSize.y) );
            
          }
           
         } 
        else if (circlePunctureDist > arrLimb.size.y +arrLimb.offsetSize.y)
        {
          float radius = ArrOfLimbs[loopCnt -1].size.y +ArrOfLimbs[loopCnt -1].offsetSize.y;
          
          float arcAngle     = dist(ArrOfLimbs[loopCnt -1].pos.x +sin(cenCirToMouseAngle) *radius, 
                                    ArrOfLimbs[loopCnt -1].pos.y +cos(cenCirToMouseAngle) *radius, 
                                    ArrOfLimbs[loopCnt -1].pos.x +sin(aToBRadians) *radius, 
                                    ArrOfLimbs[loopCnt -1].pos.y +cos(aToBRadians) *radius) /radius;//( distance between mouse and circle in angle ) /circleRadius;
          
          arcAngle /= 10;
          
          if (arcAngle > radians(1) )
          {
           if (InsideCircleArc(cenCirToMouseAngle, aToBRadians +radians(180), aToBRadians +radians(360) ) )
            {
              arcAngle = -arcAngle;
                
            }
            
            arrLimb.pos = new PVector(ArrOfLimbs[loopCnt -1].pos.x +sin(aToBRadians +arcAngle ) *radius, 
                                      ArrOfLimbs[loopCnt -1].pos.y +cos(aToBRadians +arcAngle ) *radius ); 
              
          }
         else
            arrLimb.pos = new PVector(ArrOfLimbs[loopCnt -1].pos.x +sin(cenCirToMouseAngle) *radius, 
                                      ArrOfLimbs[loopCnt -1].pos.y +cos(cenCirToMouseAngle) *radius );  
          
        }
         
       }
       
       loopCnt++;
      
    }
    
    ArrOfLimbs[0].UpdateAngle(ArrOfLimbs[1].pos );
    ArrOfLimbs[1].UpdateAngle(new PVector(mouseX, mouseY) );
    
  }
  

  float RefactoredAngle(float inAngle)
  {
      while (inAngle > radians(360) )
      {
        inAngle -= radians(360);
      }
      while (inAngle < radians(0) )
      {
        inAngle = radians(360) +inAngle;
      }
    
    return inAngle;
  }
  
  boolean InsideCircleArc(float inPtingAngle, float inStartArcAngle, float inEndArcAngle)
  {    
    if (inEndArcAngle > radians(360) && inPtingAngle > radians(0) && inPtingAngle < inEndArcAngle -radians(360))
      return true;
    
    if (inPtingAngle > inStartArcAngle && inPtingAngle < inEndArcAngle)
      return true;
    
    return false;
    
  }
  
}
