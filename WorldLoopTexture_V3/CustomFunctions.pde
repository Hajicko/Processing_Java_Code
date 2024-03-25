
int RoundOE(int Number) {
  int ReturningNumber = 0;
  
  if ((Number-1)/2 == Number/2) {
    ReturningNumber = round(Number/2.0);
    
  } else {
    ReturningNumber = Number/2;
    
  }
  
  return ReturningNumber;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PlayerDraw() {
  Ellipse(width/2, height/2, TileSize, TileSize, 1, PlayerCol, PlayerCol, 1);
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void WorldDraw() {  
  float RectPosX = 0;
  float RectPosY = 0;
  int MapTexColX = 0;
  int MapTexColY = 0;
  for (int X = -PlayerViewRangeX; X < PlayerViewRangeX+1; X++) {
    RectPosX = (WorldMapCenterX - TileSize/2) + X * TileSize;
    MapTexColX = 0;
    
    if (PlayerPosX+X >= 0 && PlayerPosX+X <= AmountX-1) {//Inside
      MapTexColX = PlayerPosX+X;
      
    } else if (PlayerPosX+X > AmountX-1) {//Over the right
      if (X == 0) {
        MapTexColX = ((AmountX-1)+1 - (PlayerPosX));
        PlayerPosX = (AmountX-1)+1 - (PlayerPosX);
        
      } else {
        MapTexColX = ((PlayerPosX+X) - (AmountX));
        
      }
      
    } else if (PlayerPosX+X < 0) {// over the left
      MapTexColX = (AmountX-1) + (PlayerPosX+X) + 1;
      if (PlayerPosX+X == PlayerPosX) 
        PlayerPosX = (AmountX-1) + (PlayerPosX+X) + 1;
      
    } else {//Error
      MapTexColX = -1;
      
    }
    
    for (int Y = -PlayerViewRangeY; Y < PlayerViewRangeY+1; Y++) {
      RectPosY = (WorldMapCenterY - TileSize/2) + Y * TileSize;
      MapTexColY = 0;
      
      if (PlayerPosY+Y >= 0 && PlayerPosY+Y <= AmountY-1) {//Inside
        MapTexColY = PlayerPosY+Y;
        
      } else if (PlayerPosY+Y > AmountY-1) {//Over the right
        if (Y == 0) {
          MapTexColY = ((AmountY-1)+1 - (PlayerPosY));
          PlayerPosY = (AmountY-1)+1 - (PlayerPosY);
          
        } else {
          MapTexColY = ((PlayerPosY+Y) - (AmountY));
          
        }
        
      } else if (PlayerPosY+Y < 0) {// over the left
        MapTexColY = (AmountY-1) + (PlayerPosY+Y) + 1;
        if (PlayerPosY+Y == PlayerPosY) 
          PlayerPosY = (AmountY-1) + (PlayerPosY+Y) + 1;
        
      } else {//Error
        MapTexColY = -1;
        
      }
      
      Rect(RectPosX, RectPosY, TileSize, TileSize, 1, Map.get(MapTexColX, MapTexColY), Map.get(MapTexColX, MapTexColY));
      
    }
    
  }
  
  PlayerDraw();
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void KeyResults() {
  //W
  if (Keys[87]) {
    PlayerPosY -= 1;
    //Keys[87] = false;
  
  }
  
  //A
  if (Keys[65]) {
    PlayerPosX -= 1;
    //Keys[65] = false;
  
  }
  
  //S
  if (Keys[83]) {
    PlayerPosY += 1;
    //Keys[83] = false;
  
  }
  
  //D
  if (Keys[68]) {
    PlayerPosX += 1;
    //Keys[68] = false;
  
  }
  
}
