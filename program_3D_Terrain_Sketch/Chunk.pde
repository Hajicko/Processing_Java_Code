class Chunk {
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  float ChunkX;
  float ChunkY;
  float ChunkZ;
  float ChunkW;
  float ChunkH;
  float ChunkL;
  color ChunkCol;
  PImage ChunkImg;
  
  boolean RunnedSetup = false;
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  Chunk (float ChkX, float ChkY, float ChkZ, float ChkW, float ChkH, float ChkL, color ChkCol) 
  {
    ChunkX = ChkX;
    ChunkY = ChkY;
    ChunkZ = ChkZ;
    ChunkW = ChkW;
    ChunkH = ChkH;
    ChunkL = ChkL;
    ChunkCol = ChkCol;
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Setup() 
  {
    
    ChunkImg = createImage(1, 1, ARGB);
    ChunkImg.set(1, 1, ChunkCol);
    
    RunnedSetup = true;
  }//end of Setup

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void Draw() 
  {
    if (!RunnedSetup)
      Setup();
    
    RenderChunk();
    
  }// end of Draw
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void RenderChunk()
  {
    if (PointInViewAngle(ChunkX +ChunkW/2, ChunkZ +ChunkL/2, (CameraPos[0] + 100 *cos(radians(AngleXZ +180)) *cos(radians(AngleY))), (CameraPos[2] +100 *sin(radians(AngleXZ +180)) *cos(radians(AngleY))), radians(AngleXZ), CameraViewAngle))
      TexturedCube(ChunkX, ChunkY +ChunkH, ChunkZ, ChunkW, ChunkH, ChunkL, null, 1, DkLtCol(ChunkCol), ChunkCol, 1);
    //Rect(ChunkX, ChunkY, ChunkZ, radians(90), radians(0), radians(0), ChunkW, ChunkH, 0, color(0), ChunkCol);
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}//end of Chunk
