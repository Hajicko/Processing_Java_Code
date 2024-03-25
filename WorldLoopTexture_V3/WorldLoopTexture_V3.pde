/*
  The idea behind this program was to make a map that loops, so as the player can't tell they are in the same space or at a boundary. 
  
  This is useful as the player won't tell where the world borders are. 
*/

color BackgroundCol = color(200);

float TileSize = 30;
float WorldMapCenterX = 0;
float WorldMapCenterY = 0;
color[][] MapCols;
PImage Map;
int AmountX = 0;
int AmountY = 0;

int PlayerPosX = 0;
int PlayerPosY = 0;
float Percentage = 0.1;
int PlayerViewRangeX = 50;
int PlayerViewRangeY = 50;
color PlayerCol = color(67, 90, 200);

boolean[] Keys = new boolean[192];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  //size(500, 500);
  fullScreen(P2D);
  TileSize = (width/PlayerViewRangeX +height/PlayerViewRangeY)/2;
  
  Map = loadImage("data/Assets/Map-5.png");
  AmountX = Map.width;
  AmountY = Map.height;
  PlayerViewRangeX = round(AmountX*Percentage);
  PlayerViewRangeY = round(AmountY*Percentage);
  PlayerPosX = (RoundOE(AmountX)-1);
  PlayerPosY = (RoundOE(AmountY)-1);
  WorldMapCenterX = (width/2);
  WorldMapCenterY = (height/2);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  background(BackgroundCol);
  
  WorldDraw();
  
  if (keyPressed)
    KeyResults();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  Keys[keyCode] = true;
  KeyResults();
  
  //println("Key: " + key + ", KeyCode: " + keyCode);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  Keys[keyCode] = false;
  
}
