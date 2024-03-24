class Terrain {
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean RunnedSetup = false;
  
  float[] TerPos = {-1000, 0, -1000};
  float[][] TerH;
  float Width = 2000;
  float Height = 2000;
  int Res = 10;
  float SpcX;
  float SpcZ;
  int NoiseSeed = 33;
  float NoiseScale = 0.02;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  Terrain() {
    
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Setup() {
    MakeTerrain();
    
    RunnedSetup = true;
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    if (!RunnedSetup)
      Setup();
      
    //Triangle(0, 30, 0, 0, 0, 30, 50, radians(90), radians(0), radians(0), 1, color(0), color(255, 0, 255));
    RenderTerrain();
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void MakeTerrain() {
    SpcX = Width/(Res +.0);
    SpcZ = Height/(Res +.0);
    TerH = new float[Res][Res];
    
    noiseSeed(NoiseSeed);
    noiseDetail(10, 0.02);
    for (int Lp1 = 0; Lp1 < Res; Lp1++) {
      for (int Lp2 = 0; Lp2 < Res; Lp2++) {
        //println(map(noise((Lp2 *SpcZ) *NoiseScale, (Lp1 *SpcX) *NoiseScale), 0, 1, 0, 255));
        TerH[Lp2][Lp1] = map(noise((Lp2 *SpcZ) *NoiseScale, (Lp1 *SpcX) *NoiseScale), 0, 1, 0, 255);
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void RenderTerrain() {
     for (int Lp1 = 0; Lp1 < Res; Lp1++) {
      for (int Lp2 = 0; Lp2 < Res; Lp2++) {
        Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(90), 0, 0, SpcZ, SpcX, 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));//color(Lp1 *(255.0/Res), 0, 0), color(TerH[Lp2][Lp1]));
        
        if (Lp1 == 0)
          Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(180), 0, 0, SpcZ, TerH[Lp2][Lp1], 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
        
        else {
          Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(180), 0, 0, SpcZ, (TerH[Lp2][Lp1] -TerH[Lp2][Lp1 -1]), 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
          if (Lp1 == Res -1)
            Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX +SpcX, radians(180), 0, 0, SpcZ, TerH[Lp2][Lp1], 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
        
        }
        
        if (Lp2 == 0)
          Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(180), radians(90), 0, SpcZ, TerH[Lp2][Lp1], 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
        
        else {
          Rect(TerPos[0] +Lp2 *SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(180), radians(90), 0, SpcZ, (TerH[Lp2][Lp1] -TerH[Lp2 -1][Lp1]), 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
          if (Lp2 == Res -1)
            Rect(TerPos[0] +Lp2 *SpcZ +SpcZ, TerPos[1] +TerH[Lp2][Lp1], TerPos[2] +Lp1 *SpcX, radians(180), radians(90), 0, SpcZ, TerH[Lp2][Lp1], 2, color(TerH[Lp2][Lp1]), color(TerH[Lp2][Lp1]));
        
          
        }
        
      }
      
    }
    
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
