class OverScreen {
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    
    RectFunction(width/2 - (BoostBarLength * 10)/2, 10, BoostBarLength * 10, 33, 5, color(0), 200);
    RectFunction(width/2 - (BoostBarLength * 10)/2, 10, BoostBar * 10, 33, 5, color(0), color(255, 0, 0));
    textSize(33);
    RectFunction(10, 15, textWidth("Your Score Is: " + round(ScoreTimer[0])) + 30, 100, 5, color(0, 100), color(255, 100));
    TextFunction("Your Score Is: " + round(ScoreTimer[0]), 10, 0, 33, color(0, 100), 2);
    TextFunction("HighScore: ", 10, 35, 33, color(0, 100), 2);
    fill(240, 196, 51);
    textSize(33);
    TextFunction(str(round(HighScoreSave[0])), 10 + textWidth("HighScore: "), 35, 33, color(240, 208, 46), 2);
    fill(0, 100);
    
    if (BoostBar < BoostBarLength && P.Keys[0] == false) {
      BoostBar += 0.1;
    }
    
    if (PlayTimer == 0) {
      TextFunction("Time till you play", width/2, (height/2)/1.6, 33, color(0, 100), 1);
      TextFunction(str(SpawnCountDown -activeTimerDiff), width/2, height/2 - 100, 33, color(0), 1);
      //PlayTimer -= 1;
    }
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}//end of OverScreen
