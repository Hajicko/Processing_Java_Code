
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XYZDraw(float PosX, float PosY, float PosZ) {
  Box(PosX, PosY, PosZ, 10, 2, color(0), color(255));
  //Z
  Line(PosX, PosY, PosZ, PosX, PosY, PosZ + CameraLookingBallRadius, 2, color(0));
  Box(PosX, PosY, PosZ + CameraLookingBallRadius, 5, 2, color(0), color(0, 0, 255));
  //Y
  Line(PosX, PosY, PosZ, PosX, PosY + CameraLookingBallRadius, PosZ, 2, color(0));
  Box(PosX, PosY + CameraLookingBallRadius, PosZ, 5, 2, color(0), color(0, 255, 0));
  //X
  Line(PosX, PosY, PosZ, PosX + CameraLookingBallRadius, PosY, PosZ, 2, color(0));
  Box(PosX + CameraLookingBallRadius, PosY, PosZ, 5, 2, color(0), color(255, 0, 0));
  
}
