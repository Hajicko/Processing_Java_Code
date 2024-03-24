class ClassScreenShotSave {
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean RunnedSetup = false;
  int[] ScreenShotNumPos = new int [1];
  boolean Delete = false;
  String PicSaveLocation;
  String TxtSaveLocation;
  String PictureFormat;
  //SaveIcon Stuff
  PImage SaveIcon;
  String SaveIconLocation;
  float SaveIconPosX;
  float SaveIconPosY;
  float SaveIconSize;
  float SaveIconDeletionSpeed;
  int SaveIconHealthLife = 255;
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  ClassScreenShotSave(String PicSaveLocationS, String PictureFormatS, String TxtSaveLocationS, String SaveIconLocationS, float SaveIconPosXS, float SaveIconPosYS, float SaveIconPosSizeS, 
  float SaveIconDeletionSpeedS) {
    PicSaveLocation = PicSaveLocationS;
    PictureFormat = PictureFormatS;
    TxtSaveLocation = TxtSaveLocationS;
    SaveIconLocation = SaveIconLocationS;
    SaveIconPosX = SaveIconPosXS;
    SaveIconPosY = SaveIconPosYS;
    SaveIconSize = SaveIconPosSizeS;
    SaveIconDeletionSpeed = SaveIconDeletionSpeedS;
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    
    if (RunnedSetup == false) {
      ScreenShotNumPos = int(loadStrings(TxtSaveLocation));
      SaveIcon = loadImage(SaveIconLocation);
      ScreenShotNumPos[0]++;
      saveStrings(TxtSaveLocation, str(ScreenShotNumPos));
      saveFrame(PicSaveLocation + ScreenShotNumPos[0] + PictureFormat);
      RunnedSetup = true;
      CameraSound = new Sound(0);
      CameraSound.play();
    }
    
    tint(255, SaveIconHealthLife);
    image(SaveIcon, SaveIconPosX, SaveIconPosY, SaveIconSize, SaveIconSize);
    noTint();
    SaveIconMovement();
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void SaveIconMovement() {
    
    if (SaveIconHealthLife > 0) {
      SaveIconHealthLife += SaveIconDeletionSpeed;
    }
    if (SaveIconHealthLife < 0) {
      SaveIconHealthLife = 0;
    }
    if (SaveIconHealthLife == 0) {
      Delete = true;
    }
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
}
