class BadGuy {
  
  float BadGuyRangeX;
  float BadGuyRangeY;
  float BadGuyRangeD;
  float BadGuyX;
  float BadGuyY;
  float BadGuyD;
  float BadGuyPastX, BadGuyPastY;
  float BadGuySpeed;
  int   DirectionMove;
  
  int   chaseCurrTime;
  int   chaseMaxDuration;
  int   chaseCooldownDuration;
  int   chaseCooldownTimeStamp;
  
  public final color[] BadGuyColorStates = { color(0, 255, 0), color(255, 0, 0), color(200, 100, 0) };
  int     BadGuyState;
  
  BadGuy(float BGX, float BGY, float BGD, float BGRD, int DM, float BGS) {
    BadGuyX = BGX;
    BadGuyY = BGY;
    BadGuyD = BGD;
    BadGuyRangeD = BGRD;
    DirectionMove = DM;
    BadGuySpeed = BGS;
    
    Setup();
  }
  
  void Setup() {
    chaseCurrTime = 0;
    chaseMaxDuration = 10000; // 10 seconds
    
    chaseCooldownDuration = chaseMaxDuration /2;
    chaseCooldownTimeStamp = 0;
    
    BadGuyState = 0;
  }
  
  void Draw() {
    
    //if (PlayTimer < 0) {
      
      BadGuyRangeX = BadGuyX;
      BadGuyRangeY = BadGuyY;
      
      float d = dist(BadGuyRangeX, BadGuyRangeY, PlayX, PlayY);
      
      if (d > BadGuyRangeD/2 + PlayD/2 || (chaseCooldownTimeStamp != 0 && millis() < chaseCooldownTimeStamp +chaseCooldownDuration) ) {
        int DirectionChange = round(random(0, DirectionChangeChance));
        int Speed = 8;
        
        if (DirectionChange == 0) {
          DirectionMove = round(random(0, DirectionMoveChance));
        }
        if (DirectionMove == 0 && BadGuyX > 0) {
          BadGuyX -= Speed;
        } else if (DirectionMove == 1 && BadGuyX > 0 && BadGuyY > 0) {
          BadGuyX -= Speed;
          BadGuyY -= Speed;
        } else if (DirectionMove == 2 && BadGuyY > 0) {
          BadGuyY -= Speed;
        } else if (DirectionMove == 3 && BadGuyX < width && BadGuyY > 0) {
          BadGuyX += Speed;
          BadGuyY -= Speed;
        } else if (DirectionMove == 4 && BadGuyX < width) {
          BadGuyX += Speed;
        } else if (DirectionMove == 5 && BadGuyX < width && BadGuyY < height) {
          BadGuyX += Speed;
          BadGuyY += Speed;
        } else if (DirectionMove == 6 && BadGuyY < height) {
          BadGuyY += Speed;
        } else if (DirectionMove == 7 && BadGuyX > 0 && BadGuyY < height) {
          BadGuyX -= Speed;
          BadGuyY += Speed;
        }//else if
        
        // When the bad guy cooldown is done and he is still in the cooldown state of 2, then turn to the active state of 0.
        if (BadGuyState == 2 && (chaseCooldownTimeStamp != 0 && millis() > chaseCooldownTimeStamp +chaseCooldownDuration) )
          BadGuyState = 0;
        
      } else {
          BadGuyPastX = (1-BadGuySpeed) * BadGuyX + BadGuySpeed * PlayX;
          BadGuyPastY = (1-BadGuySpeed) * BadGuyY + BadGuySpeed * PlayY;
          
          // If the player moves within the bad guys visibility range. 
          float DistOfBadGuy = dist(BadGuyX, BadGuyY, PlayX, PlayY);
          if (DistOfBadGuy < PlayD/2 + BadGuyD/2) {
            ModeDraw = 1;
            if (ScoreTimer[0] > HighScoreSave[0]) {
              ScoreState = 1;
              ScoreTimer[0] = int(ScoreTimer[0]);
              saveStrings("data/AllTimeHighscore.txt", str(ScoreTimer));
            }//if
            
          }//if
          
          // chase duration timer is 0 then set the current time to it. 
          if (chaseCurrTime == 0) {
            chaseCurrTime = millis();
            chaseCooldownTimeStamp = 0;
            BadGuyState = 1;
          }
          // Check for when the curr time + the max chase duration is greater than millis
          else if (millis() > chaseCurrTime +chaseMaxDuration ) {
            chaseCurrTime = 0;
            chaseCooldownTimeStamp = millis();
            BadGuyState = 2;
          }
          
          BadGuyX = BadGuyPastX;
          BadGuyY = BadGuyPastY;
      }//else
    //}//if
    
    strokeWeight(2);
    stroke(BadGuyColorStates[BadGuyState]);
    fill(200, 200, 200, 0);
    ellipse(BadGuyRangeX, BadGuyRangeY, BadGuyRangeD, BadGuyRangeD);
    fill(BadGuyColorStates[BadGuyState]);
    ellipse(BadGuyX, BadGuyY, BadGuyD, BadGuyD);
    
  }//end of void Draw
  
}//end of class BadGuy
