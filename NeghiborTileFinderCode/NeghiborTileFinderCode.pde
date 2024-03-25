int TerrainBoxSize = 5; 
int ChunkSize = 16;
int AmountOfChunkRows;
int AmountOfChunkColmns;
int AmountOfRows;
int AmountOfColmns;
int AmountOfBoxTerrain;
int AmountOfBoxTerrainChunk;
boolean NotFilled;

float[][] BoxTerrainCordsX;
float[][] BoxTerrainCordsY;
int[][] BoxTerrainId;
float MoveX, MoveY, Zoom;
boolean[] keys;

//color[] Colors = {
//  color(0  , 0  , 0  ),
//  color(255, 255, 255),
//  color(0  , 0  , 255),
//  color(0  , 255, 0  ),
//  color(255, 0  , 0  ),
//  color(round(random(255)), round(random(255))  , round(random(255))  ),
//  color(round(random(255)), round(random(255))  , round(random(255))  )
//};
color[] FillColors = new color[10];
color[] StrokeColors = new color[10];
int AmountOfFillColors;
int AmountOfStrokeColors;
final int[] VectorsForNeigboursX = {
//behind  forward    
  0, 1, 1, 1, 0, -1, -1, -1, 0
}; 
final int[] VectorsForNeigboursY = {
//behind  forward    
  -1, -1, 0, 1, 1, 1, 0, -1, 0
}; 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  
  fullScreen();
  
  FillColors[0] = color(0, 0, 0);
  for (int FColR = 1; FColR < FillColors.length; FColR++) {
    FillColors[FColR] = color(round(random(255)), round(random(255)), round(random(255)));
  }
  for (int SColR = 1; SColR < StrokeColors.length; SColR++) {
    StrokeColors[SColR] = color(round(random(255)), round(random(255)), round(random(255)));
  }
  
  AmountOfFillColors = FillColors.length;
  AmountOfFillColors = StrokeColors.length;
  AmountOfChunkRows   = 8;
  AmountOfChunkColmns = 6;
  AmountOfRows   = (AmountOfChunkRows   * ChunkSize);
  AmountOfColmns = (AmountOfChunkColmns * ChunkSize);
  AmountOfBoxTerrain = AmountOfRows * AmountOfColmns;
  AmountOfBoxTerrainChunk = ChunkSize * AmountOfRows * AmountOfColmns;
  MoveX = 31;
  MoveY = 18;
  Zoom = 0.9599996;
  NotFilled = false;
  
  keys = new boolean[122];
  BoxTerrainCordsX = new float[AmountOfRows][AmountOfColmns];
  BoxTerrainCordsY = new float[AmountOfRows][AmountOfColmns];
  BoxTerrainId = new int[AmountOfRows][AmountOfColmns];
  
  for (int Rows = 0; Rows < AmountOfRows; Rows++) {
    for (int Colmns = 0; Colmns < AmountOfColmns; Colmns++) {
      BoxTerrainId[Rows][Colmns] = 0;
    }
  }
  
  TerrainBoxCordsGenerator();
  TerrainBoxColorGenerator(BoxTerrainId);
  TerrainBoxColorFillGenerator(BoxTerrainId, AmountOfRows, AmountOfColmns);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
    
  background(200);

  KeyDraw();
  
    pushMatrix();
      translate(MoveX, MoveY);
      scale(Zoom);
      for (int Rows = 0; Rows < AmountOfRows; Rows++) {
        for (int Colmns = 0; Colmns < AmountOfColmns; Colmns++) {
            fill(FillColors[BoxTerrainId[Rows][Colmns]]);
            stroke(FillColors[BoxTerrainId[Rows][Colmns]]);
            if ((BoxTerrainCordsX[Rows][Colmns] + TerrainBoxSize) * Zoom + MoveX > 0 && (BoxTerrainCordsX[Rows][Colmns] - TerrainBoxSize) * Zoom + MoveX < width && (BoxTerrainCordsY[Rows][Colmns] + TerrainBoxSize) * Zoom + MoveY > 0 && (BoxTerrainCordsY[Rows][Colmns] - TerrainBoxSize) * Zoom + MoveY < height) {
              rect(BoxTerrainCordsX[Rows][Colmns], BoxTerrainCordsY[Rows][Colmns], TerrainBoxSize, TerrainBoxSize);
            }
        }
      }
      popMatrix();
      
    if (NotFilled == true) {
      NotFilled = false;
      TerrainBoxColorFillGenerator(BoxTerrainId, AmountOfRows, AmountOfColmns);
    }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  
  if (keyCode == ESC) {
    exit();
  }
  keys[key] = true;
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  
  keys[key] = false;
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void TerrainBoxColorGenerator(int[][] Id) {

  int AmountOfChunkColors = round(random(AmountOfFillColors, 10));
  for (int GroupsCol = 0; GroupsCol < AmountOfChunkColors; GroupsCol++) {
    
    int GroupOfLandsCol = round(random(1, AmountOfFillColors - 1));
    int GroupTilePosX = round(random(AmountOfRows));
    int GroupTilePosY = round(random(AmountOfColmns));
    int NextTilePosX;
    int NextTilePosY;
    int Direction = round(random(8));
    
    //for (int TL = 0; TL < 1; TL++) {
      Direction = round(random(8));
      
      NextTilePosX = GroupTilePosX + VectorsForNeigboursX[Direction];
      NextTilePosY = GroupTilePosY + VectorsForNeigboursY[Direction];
      if (NextTilePosX >= 0 && NextTilePosX < AmountOfRows && NextTilePosY >= 0 && NextTilePosY < AmountOfColmns && (Id[NextTilePosX][NextTilePosY] == 0 || Id[NextTilePosX][NextTilePosY] == GroupOfLandsCol)) {
        Id[NextTilePosX][NextTilePosY] = GroupOfLandsCol;
        GroupTilePosX = NextTilePosX;
        GroupTilePosY = NextTilePosY;
      }
    //}
  }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void TerrainBoxColorFillGenerator(int[][] Id, int RowLength, int ColmnLength) {
  
  int TileTracker = 0;
  int Direction;
  int NeighborTileX;
  int NeighborTileY;
  
    for (int R = 0; R < RowLength; R++) {
      for (int C = 0; C < ColmnLength; C++) {
        if (Id[R][C] == 0) {
          
          NotFilled = true;
          
          Direction = round(random(8));//round(random(8));
          NeighborTileX = R + VectorsForNeigboursX[Direction];
          NeighborTileY = C + VectorsForNeigboursY[Direction];
          if (NeighborTileX >= 0 && NeighborTileX < RowLength && NeighborTileY >= 0 && NeighborTileY < ColmnLength && Id[NeighborTileX][NeighborTileY] != 0) {
            Id[R][C] = Id[R + VectorsForNeigboursX[Direction]][C + VectorsForNeigboursY[Direction]];
          } else {
            TileTracker += 1;
            println(TileTracker + ": Didn't Change");
          }
          
        }
      }
    }
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void TerrainBoxCordsGenerator() {

  for (int R = 0; R < AmountOfRows; R++) {
    for (int C = 0; C < AmountOfColmns; C++) {
      BoxTerrainCordsX[R][C] = 0 + R * TerrainBoxSize;
      BoxTerrainCordsY[R][C] = 0 + C * TerrainBoxSize;
    }
  }

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void KeyDraw() {

  int Speed = 10;
  if (keys['w'] == true) {
    MoveY += Speed;
  } 
  if (keys['a'] == true) {
    MoveX += Speed;
  } 
  if (keys['s'] == true) {
    MoveY -= Speed;
  } 
  if (keys['d'] == true) {
    MoveX -= Speed;
  } 
  if (keys['i'] == true) {
    Zoom += 0.02;
  }
  if (keys['o'] == true) {
    Zoom -= 0.02;
  }
  if (keys['n'] == true) {
    setup();
  }

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
