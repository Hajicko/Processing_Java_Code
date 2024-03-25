String CheckIfText(String Text, String ReplaceText, int ModeType) {
  if (ModeType == 1) {
    if (Text.equals("") && second() % 2 == 0)
      return ReplaceText;
    else 
      return Text;
      
  } else {
    if (Text.equals(""))
      return ReplaceText;
    else 
      return Text;
      
  }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void SetWindowPosition() {
  WindowsPos[0] = 0;
  WindowsPos[1] = 0;
  WindowsPos[2] = 50;
  WindowsPos[3] = height;
  
  WindowsPos[4] = WindowsPos[0] + WindowsPos[2];
  WindowsPos[5] = 50;
  WindowsPos[6] = 0.4;
  WindowsPos[7] = height - 50;
  
  WindowsPos[8] = WindowsPos[4] + width * WindowsPos[6];
  WindowsPos[9] = 50;
  WindowsPos[10] = 1 - (WindowsPos[6] + (WindowsPos[2]/( width+0.0)));
  WindowsPos[11] = height - 50;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void ResetWindowPosition() {
  WindowsPos[3] = height;
  
  WindowsPos[4] = WindowsPos[0] + WindowsPos[2];
  WindowsPos[7] = height;
  
  WindowsPos[8] = (WindowsPos[0] + WindowsPos[2] + width * WindowsPos[6]);
  WindowsPos[10] = 1 - (WindowsPos[6] + (WindowsPos[2]/( width+0.0)));
  WindowsPos[11] = height;
  
}
