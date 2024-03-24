
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
