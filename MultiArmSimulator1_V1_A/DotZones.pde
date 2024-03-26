class DotZones
{
  ///---------------------------------------------------------------------------------------
  /// Variables
  
  public PVector posPt1;
  public PVector posPt2;
  
  public  int circleRadius = round(sliderMax *sliderBarPer);
  private int widthScale = round( (width < height) ? width *0.005 : height  *0.005);
  
  public float aToBRadians, cenCirToMouseAngle, midJtAngleToMouse;
  
  public boolean updateClass = true;
  
  ///---------------------------------------------------------------------------------------
  /// Functions
  
    DotZones()
    {
      posPt1 = new PVector(mouseX, mouseY);//new PVector(width /2, height /2);
      float startingAngle = ( (atan2(posPt1.x -mouseX, posPt1.y -mouseY) ) +radians(180));
      
      float secondCircleRad = startingAngle;//radians(45);
      posPt2 = new PVector(posPt1.x +sin(secondCircleRad) *circleRadius, posPt1.y +cos(secondCircleRad) *circleRadius);
      
      aToBRadians = startingAngle;
      updateClass = true;
      
    }
    
    DotZones(PVector inLimbPos)
    {
      posPt1 = inLimbPos;
      float startingAngle = ( (atan2(posPt1.x -mouseX, posPt1.y -mouseY) ) +radians(180));
      
      float secondCircleRad = startingAngle;//radians(45);
      posPt2 = new PVector(posPt1.x +sin(secondCircleRad) *circleRadius, posPt1.y +cos(secondCircleRad) *circleRadius);
      
      aToBRadians = startingAngle;
      updateClass = true;
      
    }
  
    ///---------------------------------------------------------------------------------------
    
      public void Render()
      {
        ///// This function call will update all variables positions in the class
        //if (updateClass && (pmouseX != mouseX || pmouseY != mouseY) )
        //  UpdatePos();
        
        /// This block of code renders a circle to the screen
          stroke(10);
          strokeWeight(widthScale *20);
          line(posPt1.x, posPt1.y, posPt2.x, posPt2.y);
          stroke(245);
          strokeWeight(widthScale *10);
          line(posPt1.x, posPt1.y, posPt2.x, posPt2.y);
        
        /// This block of code renders a circle to the screen
          stroke(10);
          strokeWeight(widthScale *10);
          line(posPt2.x, posPt2.y, posPt2.x +sin(midJtAngleToMouse) *circleRadius, 
                                   posPt2.y +cos(midJtAngleToMouse) *circleRadius);
         
        /// This block of code draws a circle as a hand
          fill(245);
          stroke(10);
          strokeWeight(widthScale *5);
          circle(posPt2.x +sin(midJtAngleToMouse) *circleRadius, posPt2.y +cos(midJtAngleToMouse) *circleRadius, widthScale *40);
          
      }
    
    ///---------------------------------------------------------------------------------------
    
      private void UpdatePos()
      {
        /// Recalculate the angle between the mouse and the center point
          cenCirToMouseAngle = (atan2(posPt1.x -mouseX, posPt1.y -mouseY) ) +radians(180);
      
        /// Upadte the angle variable that finds the angle between the center point to the mid joint
          aToBRadians = atan2(posPt2.x -posPt1.x, posPt2.y -posPt1.y);
          aToBRadians = RefactoredAngle(aToBRadians);
          
        /// Checks to see if the mouse position angle to the mid joint moved a decent amount before updating 
        if (activeLvl == 0 && dist(cenCirToMouseAngle, 0, aToBRadians, 0) >= radians(0.1) && mousePressed )
        {
          /// Setup an angle that stores the difference between the center point to the mid joint and center point to mouse angle
          float arcAngle = (cenCirToMouseAngle -aToBRadians);
            
          /// Recalculate the angle between the mouse and the mid joint positions
            midJtAngleToMouse = atan2(posPt2.x -mouseX, posPt2.y -mouseY) +radians(180);
            
          /// Check to see if the mouse is inside the circle distance or limb length
          if (dist(posPt2.x, posPt2.y, mouseX, mouseY) < circleRadius)
          { 
            /// This variable stores the amount the mouse moved into the 2nd circle
            float punctureAmnt = circleRadius -dist(posPt2.x, posPt2.y, mouseX, mouseY);
            /// Update the arc angle that moves towards the new mouse position angle. 
            /// This is found by using the reverse of the radian arc finder (radiansInAngle *radius)
            arcAngle = punctureAmnt /circleRadius;//radians(punctureAmnt *circleRadius);
            
            /// Upper half of the circle
            /// Check to see if the mouse angle is inside the upper half of the mid joint circle
            if (InsideCircleArc(cenCirToMouseAngle, aToBRadians, aToBRadians +radians(180) ) )
            {
              /// Reverse the calculated arc angle so the circle moves away correctly
              arcAngle = -arcAngle;
            } 
            
            /// Set the new position of the mid joint circle to the new calculated angle position
            posPt2 = new PVector(posPt1.x +sin(RefactoredAngle(aToBRadians +arcAngle) ) *circleRadius, 
                                 posPt1.y +cos(RefactoredAngle(aToBRadians +arcAngle) ) *circleRadius );
            
          }
          /// Check to see if the mouse position is outside the mid joint circle
          else if (dist(posPt2.x, posPt2.y, mouseX, mouseY) > circleRadius)
          {
            /// Recalculate the angle between the mouse and the mid joint positions
              midJtAngleToMouse = atan2(posPt2.x -mouseX, posPt2.y -mouseY) +radians(180);
              
            /// Create a variable to store the result of the forumal selection below that decides if the correct formual to
            /// calculate the arc angle below. The two formual choices below are the inside and outside formuals.
            /// The inside formual is run if the mouse is inside the two joints circle radius put together, 
            /// this formual is used because the mouse position is inside the circle radius of the mid joint compared to the center point
              int zoneStatus = int(dist(posPt1.x, posPt1.y, mouseX, mouseY) >= circleRadius *2);
              
            /// Upper half of the circle
            /// Check to see if the mouse angle is inside the upper half of the mid joint circle
            if (InsideCircleArc(cenCirToMouseAngle, aToBRadians, aToBRadians +radians(180) ) )
            {
              /// Check to see if the mouse is inside of the center point radius times 2, if it is then use this formual to calculate the arc angle
              if (zoneStatus == 0)
              {
                /// This variable stores the amount the mouse moved into the 2nd circle
                  float punctureAmnt = dist(posPt2.x, posPt2.y, mouseX, mouseY) -circleRadius;
                /// Update the arc angle that moves towards the new mouse position angle. 
                /// This is found by using the reverse of the radian arc finder (radiansInAngle *radius)
                  arcAngle = punctureAmnt /circleRadius;//radians(punctureAmnt *circleRadius);
                  arcAngle = RefactoredAngle(arcAngle);
              }
            } 
            /// Bottom half of the circle
            /// Check to see if the mouse angle is inside the bottom half of the mid joint circle
            else if (InsideCircleArc(cenCirToMouseAngle, aToBRadians +radians(180), aToBRadians +radians(360) ) )
            {
              /// Check to see if the mouse is inside of the center point radius times 2, if it is then use this formual to calculate the arc angle
              if (zoneStatus == 0)
              {
                /// This variable stores the amount the mouse moved into the 2nd circle
                  float punctureAmnt = dist(posPt2.x, posPt2.y, mouseX, mouseY) -circleRadius;
                /// Update the arc angle that moves towards the new mouse position angle. 
                /// This is found by using the reverse of the radian arc finder (radiansInAngle *radius)
                  arcAngle = punctureAmnt /circleRadius;//radians(punctureAmnt *circleRadius);
                  arcAngle = -RefactoredAngle(arcAngle);
              }
              else
                arcAngle = -RefactoredAngle(radians(360) -arcAngle );
                
                //println("[ Sec: " +second() +"]: { ( zoSt: " +zoneStatus +", Deg: " +degrees(arcAngle) +", Rad: " +(arcAngle) +" ), ( ceCiToMoAn: " +cenCirToMouseAngle +", aToBRa: " +aToBRadians +" ) };");
                
            }
            
            /// Set the new position of the mid joint circle to the new calculated angle position
            posPt2 = new PVector(posPt1.x +sin(RefactoredAngle( (aToBRadians +arcAngle) ) ) *circleRadius, 
                                 posPt1.y +cos(RefactoredAngle( (aToBRadians +arcAngle) ) ) *circleRadius );
            
          }
          
        } //If- 1
      
        
        
      }/// End braket of UpdatePos
    
    ///---------------------------------------------------------------------------------------
    
      /// This void function draws a circle with the different angles marked in the circle
      private void AngleCircle(PVector inPos, float inRadius, int inAngleAmnt)
      {
        stroke(10);
        strokeWeight(2);
        fill(240, 240, 240);
        circle(inPos.x, inPos.y, inRadius *2);
        
        /// Only draw the angle lines inside the circle if the inputted angle line amount is larger than 0
        if (inAngleAmnt > 0)
        {
          
          float angleSplitAmnt = radians(360) /(inAngleAmnt +1.0);
          textSize(inRadius /4);
          for (int Lp1 = 0; Lp1 < inAngleAmnt +1; Lp1++)
          {
            stroke(10, 10, 10, 100);
            strokeWeight(3);
            
            line(inPos.x, inPos.y, inPos.x +sin(Lp1 *angleSplitAmnt) *circleRadius, inPos.y +cos(Lp1 *angleSplitAmnt) *circleRadius);
            
            stroke(240, 10, 10);
            strokeWeight(5);
            point(inPos.x +sin(Lp1 *angleSplitAmnt) *circleRadius, inPos.y +cos(Lp1 *angleSplitAmnt) *circleRadius);
              
            fill(10);
            stroke(10);
            text(degrees(round(Lp1 *angleSplitAmnt) ), inPos.x +sin(Lp1 *angleSplitAmnt) *inRadius, inPos.y +cos(Lp1 *angleSplitAmnt) *inRadius);
            
          }
          
        }
        
      }/// End bracket of AngleCircle
    
    ///---------------------------------------------------------------------------------------
    
      float RefactoredAngle(float inAngle)
      {
        /// If the inputted angle is larger than 360 degrees than remove that amount until it is re-corrected
        while (inAngle > radians(360) )
        {
          inAngle -= radians(360);
        }
        /// If the inputted angle is smaller than 0 degrees than add that amount until it is re-corrected
        while (inAngle < radians(0) )
        {
          /// inAngle is going to be negative in degrees
          inAngle = radians(360) +inAngle;
        }
        
        return inAngle;
      }/// End bracket of RefactoredAngle
    
    ///---------------------------------------------------------------------------------------
    
      boolean InsideCircleArc(float inPtingAngle, float inStartArcAngle, float inEndArcAngle)
      {    
        if (inEndArcAngle > radians(360) && inPtingAngle > radians(0) && inPtingAngle < inEndArcAngle -radians(360))
          return true;
        
        //println(degrees(inPtingAngle) +" > " +degrees(inStartArcAngle) +" && " +degrees(inPtingAngle) +" < " +degrees(inEndArcAngle));
        if (inPtingAngle > inStartArcAngle && inPtingAngle < inEndArcAngle)
          return true;
        
        return false;
        
      }/// End bracket of InsideCircleArc
    
    ///---------------------------------------------------------------------------------------
  
      public void FlipUpdateStatus()
      {    
        if (!updateClass)
          updateClass = true;
        else
          updateClass = false;
        
      }/// End bracket of InsideCircleArc
    
    ///---------------------------------------------------------------------------------------
  
      public void SetRadius(int inRadius)
      {    
        posPt2 = new PVector(posPt1.x +sin(aToBRadians) *inRadius, posPt1.y +cos(aToBRadians) *inRadius);
        
        circleRadius = inRadius;
        
      }/// End bracket of SetRadius
    
    ///---------------------------------------------------------------------------------------
};
