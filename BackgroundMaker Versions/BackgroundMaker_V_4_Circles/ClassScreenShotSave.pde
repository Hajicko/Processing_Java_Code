class ClassScreenShotSave {
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  boolean RunnedSetup = false;
  int ScreenShotNumPos;
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
  
  ClassScreenShotSave(String PicSaveLocationS, String PictureFormatS, String SaveIconLocationS, float SaveIconPosXS, float SaveIconPosYS, float SaveIconPosSizeS, 
  float SaveIconDeletionSpeedS) {
    PicSaveLocation = PicSaveLocationS;
    PictureFormat = PictureFormatS;
    SaveIconLocation = SaveIconLocationS;
    SaveIconPosX = SaveIconPosXS;
    SaveIconPosY = SaveIconPosYS;
    SaveIconSize = SaveIconPosSizeS;
    SaveIconDeletionSpeed = SaveIconDeletionSpeedS;
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Setup() {
    ScreenShotNumPos = new File(sketchPath(SaveIconLocation)).list().length;
    SaveIcon = loadImage(SaveIconLocation);
    saveFrame(PicSaveLocation + ScreenShotNumPos + PictureFormat);
    CameraSound = new Sound(0);
    CameraSound.play();
      
    RunnedSetup = true;
    
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void Draw() {
    
    if (RunnedSetup == false) {
      Setup();
     
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
