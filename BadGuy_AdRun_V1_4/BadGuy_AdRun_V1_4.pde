/*

Things to add, the ability for the bad guys to clump together on the screen. As they clump together and add up they get different abilities. 

The aim of the game is to run away from the these bad guys or get rid of them through super powers. If the player escapes the bad guy clumps, it will slowly desolve over time. Until the pile is only a single bad guy, causing them to split apart on an interval. 

*/


//BadGuy BG = new BadGuy();
ArrayList<BadGuy> BadGuysArrayList;
OverScreen OS = new OverScreen();
Player P = new Player();

float PlayX;
float PlayY;
float PlayD;

int ModeDraw;
int NumPoint;
int[] HighScoreSave;
String[] AllTimeHighscore;
int ScoreState;
float[] ScoreTimer;

int PlayTimer;
int activeTimerDiff;
int BoostBarLength = 50;
float BoostBar;
int DirectionChangeChance = 5;
int DirectionMoveChance = 8;
boolean StartNow;
int SpawnCountDown;
int timeStamp;
int timeIncrement;

void setup() {
  //size(600, 600);
  fullScreen();
  
  P.Setup();
  
  HighScoreSave    = new int[1];
  AllTimeHighscore = new String[1];
  ScoreTimer       = new float[1];
  
  BadGuysArrayList = new ArrayList<BadGuy>();
  
  AllTimeHighscore = loadStrings("data/AllTimeHighscore.txt");
  HighScoreSave[0] = int(AllTimeHighscore[0]);
  PlayX = 50;
  PlayY = height/2;
  PlayD = 25;
  NumPoint = 50;
  ScoreState = 0;
  ScoreTimer[0] = 0;
  PlayTimer = 0;
  BoostBar = BoostBarLength;
  StartNow = false;
  ModeDraw = 0;
  SpawnCountDown = 15;
  activeTimerDiff = 0;
  timeIncrement = 0;

}

void draw() {
  
  if (ModeDraw == 0) {
    
    background(200);
    //noCursor();
    
    OS.Draw();
    
    // This is the warning circle, letting the player know that an enemy is about to spawn. 
    if (activeTimerDiff >= 10) {
      EllipseFunction(width/2 - 300, height/2 - 300, 600, 600, 5, color(255, 0, 0), color(255, 0, 0, 122.5));
      TextFunction("Danger Spawn Zone", width/2, height/2, 33, color(255), 1);
    } else {
      EllipseFunction(width/2 - 300, height/2 - 300, 600, 600, 5, color(255, 0, 0), color(255, 0, 0, 0));
      TextFunction("Danger Spawn Zone", width/2, height/2, 33, color(255, 0, 0), 1);
    }
    
    if (PlayTimer != 0) {
      TextFunction("Time till Spawn", width/2, height/2 + 50, 33, color(0), 1);
      TextFunction(str(SpawnCountDown -activeTimerDiff), width/2, height/2 + 100, 33, color(0), 1);
    }
    
    // Draw the player character. 
    P.Draw();
    
    // Draw all the enemy players to the screen. 
    for (int i = 0; i < BadGuysArrayList.size(); i++) { 
      BadGuy BadGuySingle = (BadGuy) BadGuysArrayList.get(i);
      BadGuySingle.Draw();
    }//for
    
    if (StartNow == true) {
      BadGuysArrayList.add(new BadGuy(width/2, height/2, 30, 600, round(random(0, DirectionMoveChance)), random(0.05, 0.15)));
      StartNow = false;//!StartNow;
    }//if
  
    
    activeTimerDiff = getMillisMappedToSec() -PlayTimer;
    //println("\t" +"activeTimerDiff: " +activeTimerDiff);
    if (activeTimerDiff >= SpawnCountDown) {
      //println("\t" +"Before PlayTimer: " +PlayTimer);
      PlayTimer = getMillisMappedToSec();
      //println("\t" +"After PlayTimer: " +PlayTimer);
      activeTimerDiff = 0;
      StartNow = true;//!StartNow;
    }
    
    //println(getMillisMappedToSec());
    //println(millis());

  } else if (ModeDraw == 1) {
    
    String TH = "Highscore: ";
    String NTH = "New Highscore: ";
    background(0);
    TextFunction("Game Over", width/2, 200, 33, color(219, 4, 4), 1);
    textSize(33);
    if (ScoreState == 0) {
      TextFunction(TH, width/2 - textWidth(TH + HighScoreSave[0])/2, 300, 33, color(255), 1);
      TextFunction(str(HighScoreSave[0]), width/2 + textWidth(TH)/2, 300, 33, color(240, 196, 51), 1);
      TextFunction("Your Score is: ", width/2 - textWidth("Your Score is: " + round(ScoreTimer[0]))/2, 350, 33, color(255), 1);
      TextFunction(str(round(ScoreTimer[0])), width/2 + textWidth("Your Score is: ")/2, 350, 33, color(240, 196, 51), 1);
    } else if (ScoreState == 1) {
      TextFunction(NTH + round(ScoreTimer[0]), width/2, 300, 33, color(240, 196, 51), 1);
    }
    TextFunction("Press R to restart", width/2, 400, 33, color(255), 1);

  }
  
}

void keyPressed() {
  P.KeyPressed();
}

void keyReleased() {
  
  P.KeyReleased();
  
  if (key == 'r' || key == 'R') {
    setup();
    draw();
    background(255);
    
  }
  
}
