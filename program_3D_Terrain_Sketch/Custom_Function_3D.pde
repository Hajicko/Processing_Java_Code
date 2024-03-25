
int[][] GenRR0(int W, int H, int SetIncr, int Dir) 
{
  int[][] IntMap = new int[W][H];
  int IncrmentNum = SetIncr;
  int[] LpsSz = new int[2];
  if (Dir == 0)
  {
    LpsSz[0] = W;
    LpsSz[1] = H;
  } else
  {
    LpsSz[0] = H;
    LpsSz[1] = W;
  }
      for (int LPx1 = 0; LPx1 < LpsSz[0]; LPx1++)
        for (int LPy1 = 0; LPy1 < LpsSz[1]; LPy1++)
        {
          int AddN = int(random(-5, 5));
          if (IncrmentNum +AddN > 0 && IncrmentNum +AddN < 255)
            IncrmentNum += AddN;
          IntMap[LPx1][LPy1] = IncrmentNum;
        }

  return IntMap;
}

PImage GenRR1(int W, int H, int SetIncr, int Dir) 
{
  PImage Img = createImage(W, H, SetIncr);
  int IncrmentNum = SetIncr;
  int[] LpsSz = new int[2];
  if (Dir == 0)
  {
    LpsSz[0] = W;
    LpsSz[1] = H;
  } else
  {
    LpsSz[0] = H;
    LpsSz[1] = W;
  }
      for (int LPx1 = 0; LPx1 < LpsSz[0]; LPx1++)
        for (int LPy1 = 0; LPy1 < LpsSz[1]; LPy1++)
        {
          int AddN = int(random(-5, 5));
          if (IncrmentNum +AddN > 0 && IncrmentNum +AddN < 255)
            IncrmentNum += AddN;
          Img.set(LPx1, LPy1, color(IncrmentNum));
        }

  return Img;
}

float fbm(PVector v, int octaves){

      float frequency = 0.6;
      float persistence = 0.6;
      float lacunarity = 2.0;
      float sum = 0.0;
      float noise = 0.0;
      float pers = 1.0;
      v = v.mult(frequency);

      for (int i = 0; i<octaves; i++)
      {
         noise = noise(v.x, v.y, v.z);
         sum += noise * pers;
         v = v.mult(lacunarity);
         pers *= persistence;
    }
    return  sum;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XYZDraw(float PosX, float PosY, float PosZ, float Radius, int StkW, float BxSz, int Type) {
  Box(PosX, PosY, PosZ, BxSz, StkW, color(0), color(255));
  //Z
      Line(PosX, PosY, PosZ, PosX, PosY, PosZ + Radius, StkW, color(0, 0, 255));
      Box(PosX, PosY, PosZ + Radius, BxSz, StkW, color(0), color(0, 0, 255));
  //Y
      Line(PosX, PosY, PosZ, PosX, PosY + Radius, PosZ, StkW, color(0, 255, 0));
      Box(PosX, PosY + CameraLookingBallRadius, PosZ, BxSz, StkW, color(0), color(0, 255, 0));
  //X
      Line(PosX, PosY, PosZ, PosX + Radius, PosY, PosZ, StkW, color(255, 0, 0));
      Box(PosX + Radius, PosY, PosZ, BxSz, StkW, color(0), color(255, 0, 0));
  
  if (Type == 1) {
    //Z
        Triangle(PosX, Radius, 0, PosZ, 0, Radius, PosY, radians(0), radians(-90), radians(0), StkW, color(0), color(0, 0, 255));
    
    //Y
        Triangle(PosX, Radius, 0, PosZ, 0, Radius, PosY, radians(90), radians(0), radians(0), StkW, color(0), color(0, 255, 0));
    
    //X
      Triangle(PosX, Radius, 0, PosZ, 0, Radius, PosY, radians(0), radians(0), radians(0), StkW, color(0), color(255, 0, 0));
    
  }
  
}

    boolean InsideBox(float PX1, float PY1, float PX2, float PY2) {
      boolean Inside = false;
      
      if (mouseX > PX1 && mouseX < PX2 && mouseY > PY1 && mouseY < PY2) {
        Inside = true;
        
      }
      
      return Inside;
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color MCBoxCol(float PX1, float PY1, float PX2, float PY2, color C1, color C2, color C3) {
      color Color = C1;
      
      if (mouseX > PX1 && mouseX < PX1 + PX2 && mouseY > PY1 && mouseY < PY1 + PY2) {
        if (mousePressed)
          Color = C3;
          
        else 
          Color = C2;
        
      }
      
      return Color;
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int MCBoxInt(float PX1, float PY1, float PX2, float PY2) {
      int Num = 0;
      
      if (mouseX >= PX1 && mouseX <= PX1 + PX2 && mouseY >= PY1 && mouseY <= PY1 + PY2) {
        if (mousePressed)
          Num = 2;
          
        else 
          Num = 1;
        
      }
      
      return Num;
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void RectB(float RecPosX, float RecPosY, float RecWidth, float RecHeight, float RecStrokeWeight, color RecColStroke, color RCF1, color RCF2, color RCF3) {
      
      strokeWeight(RecStrokeWeight);
      stroke(RecColStroke);
      fill(MCBoxCol(RecPosX, RecPosY, RecWidth, RecHeight, RCF1, RCF2, RCF3));
      rect(RecPosX, RecPosY, RecWidth, RecHeight);
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void RectH(float RecPosX, float RecPosY, float RecWidth, float RecHeight, float RecStrokeWeight, color RecColStroke, color RCF1, color RCF2, color RCF3, int MHV) {
      
      strokeWeight(RecStrokeWeight);
      stroke(RecColStroke);
      if (MHV < 2)
        fill(MCBoxCol(RecPosX, RecPosY, RecWidth, RecHeight, RCF1, RCF2, RCF3));
        
      else 
        fill(RCF1);
      rect(RecPosX, RecPosY, RecWidth, RecHeight);
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int FilesInFolder(String Location) {
      int Num = 0;
      Num = new File(Location).list().length;
      
      return Num;
    
    }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color[] ColsBlender(color[] InputCols, int PointBtw) {
      color[] ReturnCols = new color[0];
      for (int i1 = 0; i1 < InputCols.length -1; i1++) {
        for (int i2 = 0; i2 < PointBtw +1; i2++) {
          ReturnCols = append(ReturnCols, lerpColor(InputCols[i1], InputCols[i1 +1], i2*(1/(PointBtw +1 +0.0))));
          
        }
        
      }
      ReturnCols = append(ReturnCols, InputCols[InputCols.length -1]);
      
      return ReturnCols;
      
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color[][] ColorHueSatSel(int HSW, int HSH, color InputCol1, color InputCol2, color InputCol3, color InputCol4) {
      color[][] ReturnCols = new color[HSW +2][HSH +2];
      color[][] TSetCols = new color[2][HSH +2];
      color[][] ColorSets = {
        {InputCol1, InputCol4},
        {InputCol2, InputCol3}
      };
      
      TSetCols[0] = ColsBlender(ColorSets[0], HSW);
      TSetCols[1] = ColsBlender(ColorSets[1], HSW);
      for (int Lp1 = 0; Lp1 < HSW +2; Lp1++) {
        color[] TemCols = {TSetCols[0][Lp1], TSetCols[1][Lp1]};
        ReturnCols[Lp1] = ColsBlender(TemCols, HSH);
        
      }
      
      return ReturnCols;
      
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    PImage ColArrayToPImage2D(int Width, int Height, color[][] ColArray) {
      PImage Image = createImage(Width, Height, ARGB);
      Image.loadPixels();
      int ImageSliceX = 1;
      int X = 0;
      int Y = 0;
      for (int Pix = 0; Pix < Image.pixels.length; Pix++) {
        if (Pix == ImageSliceX * Width && (ImageSliceX +1) * Width <= Image.pixels.length)
          ImageSliceX += 1;
        
        X = ((ImageSliceX -1) * -Width) + Pix;
        Y = ImageSliceX -1;
        
        Image.pixels[Pix] = ColArray[Y][X]; 
      }
      Image.updatePixels();
      
      return Image;
    
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color RemsCol(color InputCol) {
      return color(((255 -int(red(InputCol)))), ((255 -int(green(InputCol)))), ((255 -int(blue(InputCol)))));
      
    }
    

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color InverseCol(color InputCol) {
      float[] ColVals = {red(InputCol), green(InputCol), blue(InputCol)};
      for (int ChkLp1 = 0; ChkLp1 < ColVals.length; ChkLp1++)
        if (ColVals[ChkLp1] <= 125) 
          ColVals[ChkLp1] = 0;
        else 
          ColVals[ChkLp1] = 255;
      
      return color(ColVals[0], ColVals[1], ColVals[2]);
      
    }
    

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    color DkLtCol(color InputCol) {
      float[] ColVals = {red(InputCol), green(InputCol), blue(InputCol)};
      for (int ChkLp1 = 0; ChkLp1 < ColVals.length; ChkLp1++)
        if (ColVals[ChkLp1] <= 125) 
          ColVals[ChkLp1] = 0;
        else 
          ColVals[ChkLp1] = 255;
      
      if (ColVals[0] == 0 && ColVals[1] == 0 && ColVals[2] == 0)
        InputCol = color(255);
      else
        InputCol = color(0);
      
      return InputCol;//color(ColVals[0], ColVals[1], ColVals[2]);
      
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    color ComCols(color MCol, color[] ComCols) 
    {
      int SelCol = 0;
      
      for (int SCLp1 = 0; SCLp1 < ComCols.length; SCLp1++) 
        if (dist(red(ComCols[SCLp1]), green(ComCols[SCLp1]), blue(ComCols[SCLp1]), red((MCol)), green((MCol)), blue((MCol))) < 
            dist(red(ComCols[SelCol]), green(ComCols[SelCol]), blue(ComCols[SelCol]), red((MCol)), green((MCol)), blue((MCol))))
          SelCol = SCLp1;
      
      return ComCols[SelCol];
      
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    public float ColourDistance(color c1, color c2)
    {
        float rmean = (red(c1) +red(c2))/2;
        int r = int(red(c1) -red(c2));
        int g = int(green(c1) -green(c2));
        int b = int(blue(c1) -blue(c2));
        float weightR = 2 +rmean/256;
        float weightG = 4.0;
        float weightB = 2 +(255-rmean)/256;
        return sqrt(weightR *r *r +weightG *g *g +weightB *b *b);
    } 
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
  int ColSecFdI(color MCol, int Type)
  {
    int ColDst = int(red(MCol));
    int[] MRGBVals = {int(red(MCol)), int(green(MCol)), int(blue(MCol))};
    int Sec = 0;
    
    if (MRGBVals[1] < ColDst)
    {
      ColDst = MRGBVals[1];
      
    }
    else if (MRGBVals[2] < ColDst) 
    {
      ColDst = MRGBVals[2];
      
    }
      
    for (int Coli = 0; Coli < 3; Coli++)
      MRGBVals[Coli] -= ColDst;
      
    if (Type == 0)
    {
      //red && green
      if (MRGBVals[0] > 0 && MRGBVals[1] > 0)
        Sec = 0;
        
      //blue && green
      else if (MRGBVals[1] > 0 && MRGBVals[2] > 0)
        Sec = 1;
        
      //blue && red
      else if (MRGBVals[2] > 0 && MRGBVals[0] > 0)
        Sec = 2;
        
      //red
      else if (MRGBVals[0] > 0)
        Sec = 0;
      //green
      else if (MRGBVals[1] > 0)
        Sec = 1;
      //blue
      else if (MRGBVals[2] > 0)
        Sec = 2;
        
    } else 
    {
      //red && green
      if (MRGBVals[0] > 0 && MRGBVals[1] > 0)
        Sec = 1;
        
      //blue && green
      else if (MRGBVals[1] > 0 && MRGBVals[2] > 0)
        Sec = 3;
        
      //blue && red
      else if (MRGBVals[2] > 0 && MRGBVals[0] > 0)
        Sec = 5;
        
      //red
      else if (MRGBVals[0] > 0)
        Sec = 0;
      //green
      else if (MRGBVals[1] > 0)
        Sec = 2;
      //blue
      else if (MRGBVals[2] > 0)
        Sec = 4;
        
    }
    
    return Sec;
    
  }
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  color ColSecFdCol(color MCol)
  {
    int ColDst = int(red(MCol));
    int[] MRGBVals = {int(red(MCol)), int(green(MCol)), int(blue(MCol))};
    
    if (MRGBVals[1] < ColDst)
    {
      ColDst = MRGBVals[1];
      
    }
    else if (MRGBVals[2] < ColDst) 
    {
      ColDst = MRGBVals[2];
      
    }
      
    for (int Coli = 0; Coli < 3; Coli++)
      MRGBVals[Coli] -= ColDst;
    
    return color(MRGBVals[0], MRGBVals[1], MRGBVals[2]);
    
  }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int ComColsI(color MCol, color[] ComCols, int Type) 
    {
      int SelCol = 0;
      
      if (Type == 0)
        for (int SCLp1 = 0; SCLp1 < ComCols.length; SCLp1++) 
          if (ColSecFdI(MCol, 0) == ColSecFdI(ComCols[SCLp1], 0) && ColourDistance(ComCols[SCLp1], (MCol)) < ColourDistance(ComCols[SelCol], (MCol)))
            SelCol = SCLp1;
            
      else if (Type == 1)
        for (int SCLp2 = 0; SCLp2 < ComCols.length; SCLp2++) 
        if (dist(hue(ComCols[SCLp2]), saturation(ComCols[SCLp2]), brightness(ComCols[SCLp2]), hue((MCol)), saturation((MCol)), brightness((MCol))) <
            dist(hue(ComCols[SelCol]), saturation(ComCols[SelCol]), brightness(ComCols[SelCol]), hue((MCol)), saturation((MCol)), brightness((MCol))))
          SelCol = SCLp2;
          
      if (Type == 2)
        for (int SCLp3 = 0; SCLp3 < ComCols.length; SCLp3++) 
        if (dist(red(ComCols[SCLp3]), green(ComCols[SCLp3]), blue(ComCols[SCLp3]), red((MCol)), green((MCol)), blue((MCol))) < 
            dist(red(ComCols[SelCol]), green(ComCols[SelCol]), blue(ComCols[SelCol]), red((MCol)), green((MCol)), blue((MCol))))//ColSecFdCol
          SelCol = SCLp3;
          
      else if (Type == 3)
        for (int SCLp4 = 0; SCLp4 < ComCols.length; SCLp4++) 
        if (dist(red(ComCols[SCLp4]), green(ComCols[SCLp4]), blue(ComCols[SCLp4]), red(ColSecFdCol(MCol)), green(ColSecFdCol(MCol)), blue(ColSecFdCol(MCol))) < 
            dist(red(ComCols[SelCol]), green(ComCols[SelCol]), blue(ComCols[SelCol]), red(ColSecFdCol(MCol)), green(ColSecFdCol(MCol)), blue(ColSecFdCol(MCol))))
          SelCol = SCLp4;
      
      else if (Type == 4)
        for (int SCLp5 = 0; SCLp5 < ComCols.length; SCLp5++) 
        if (ColourDistance(ComCols[SCLp5], (MCol)) < ColourDistance(ComCols[SelCol], (MCol)))
          SelCol = SCLp4;
      
      return SelCol;
      
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    String[] MixRoler(String[] People, String[] Roles)
    {
      String[] ReturnData = new String[0];
      int[] RRNums = new int[People.length];
      boolean Finished = false;
      for (int Lp1 = 0; Lp1 < People.length; Lp1++)
      {
        RRNums[Lp1] = round(random(-.5, Roles.length -.5));
        
      }
      while (!Finished) 
      {
        Finished = true;
        for (int Lp2 = 0; Lp2 < People.length; Lp2++)
          for (int Lp3 = 0; Lp3 < People.length; Lp3++)
            if (RRNums[Lp2] == RRNums[Lp3] && Lp2 != Lp3)
            {
              RRNums[Lp2] = round(random(-.5, Roles.length -.5));
              Finished = false;
              
            }
      }
      
      for (int MRLp1 = 0; MRLp1 < People.length; MRLp1++)
      {
        ReturnData = append(ReturnData, Roles[RRNums[MRLp1]]);
      }
      
      return ReturnData;
      
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean PointInViewAngle(float TargetX, float TargetY, float ArcCenterX, float ArcCenterY, float ArcRadiansDir, float coneAngle) {
  // Vector of direction where the arc is facing
  PVector ArcPos = new PVector(cos(ArcRadiansDir), sin(ArcRadiansDir));
  // Vector of direction where in which the Target is
  PVector TargetRadiansDir = new PVector(TargetX -ArcCenterX, TargetY - ArcCenterY);
  // Need to normalize the vector
  TargetRadiansDir.normalize();
  // Calculate the cisine of the angle between ArcPos
  // and TargetRadiansDir vector
  float deltaAngle = ArcPos.dot(TargetRadiansDir);
  // Compare this with the cosine of half FOV
  return (deltaAngle >= cos(coneAngle / 2));
}
