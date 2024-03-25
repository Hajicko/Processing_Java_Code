import processing.sound.*;
import java.io.FileNotFoundException;

class SoundEngine
{
  
  public ArrayList<SoundFile> allSounds;
  public int currentSound, soundTime;
  public float soundDuration;
  /// The cuedSounds array can only store up to 10 songs in the que to play.
  public int[] cuedSounds;
  public float[] cuedSoundsDuration;
  /// Tracks if the user wants to skip to the next sound in the sound array.
  public boolean nextSound;
  
  SoundEngine()
  {
    allSounds = new ArrayList<SoundFile>(); // initialize the arrayList
    currentSound = -1;
    soundTime = -1;
    cuedSounds = new int[10];
    cuedSoundsDuration = new float[10];
    for (int lp0 = 0; lp0 < cuedSounds.length; lp0++)
    {
      cuedSounds[lp0] = -1;
      cuedSoundsDuration[lp0] = -1;
    }
    nextSound = false;
  }
  
  public void Run()
  {
    /// Only play the next sound in the cue if the sound is finished playing.
    if (millis() -soundTime > soundDuration || nextSound)
    {
      /// In the case that the first sound in the cuedSound array is -1/nothing, then set all the current sound variables to nothing.
      if (cuedSounds[0] == -1)
      {
        /// Update the global sound variables.
        currentSound = -1;
        soundTime = -1;
        soundDuration = 0;
        
        for (int lp0 = 0; lp0 < allSounds.size(); lp0++)
            if (allSounds.get(lp0).isPlaying())
              allSounds.get(lp0).stop();
      }
      /// Check to see if the first position in the cued sounds array isn't -1/nothing.
      else if (cuedSounds[0] > -1)
        /// Play the first sound in the sound cue array, setting up all the global variables to it.
        PlaySound(cuedSounds[0], cuedSoundsDuration[0]);
        
      /// Check on any sounds in the cue to update
      for (int lp0 = 0; lp0 < cuedSounds.length -1; lp0++)
      {
        cuedSounds[lp0] = cuedSounds[lp0 +1];
        cuedSoundsDuration[lp0] = cuedSoundsDuration[lp0 +1];
        /// Check to see if the next song in the SE.cuedSounds array isn't -1/nothing, if so then break out of the for loop.
        if (cuedSounds[lp0 +1] == -1)
          break;
          
      }
      /// In the case that the last sound cued in the array isn't -1 turn it to -1, this is need because the for loop above doesn't do it.
      if (cuedSounds[cuedSounds.length -1] != -1)
      {
        cuedSounds[cuedSounds.length -1] = -1;
        cuedSoundsDuration[cuedSoundsDuration.length -1] = -1;
      }
      
      /// If the SE.nextSound is true then set it to false
      if (nextSound)
        nextSound = false;
      
    }
  }
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  public int[] LoadSoundFiles(String path, String[] fileList) 
  {
    int[] outErrorCodes = new int[fileList.length];
    for (int lp0 = 0; lp0 < fileList.length; lp0++) 
    {
      /// Create a variable to check if the audio file exists or not.
      File tempFile = new File(path + "/" + fileList[lp0]);
      /// Only add the audio file to the allSounds array if it exists.
      if (tempFile.exists())
      {
        //println("The file '" +fileList[lp0] +"', was found.");
        allSounds.add(new SoundFile(ChristmasNameSelectorProgram_V2.this, path + "/" + fileList[lp0], false));
        outErrorCodes[lp0] = 1;
      }
      else
      {
        //println("The file '" +fileList[lp0] +"', was not found.");
        outErrorCodes[lp0] = -1;
      }
      
    }
    
    return outErrorCodes;
  }
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  public int PlaySound(int audioFileId)
  {
    if (allSounds.size() > 0)
    {
      if (audioFileId < allSounds.size())
      {
          for (int lp0 = 0; lp0 < allSounds.size(); lp0++)
            if (allSounds.get(lp0).isPlaying())
              allSounds.get(lp0).stop();
          
          allSounds.get(audioFileId).play();
          
          /// Update the global sound variables.
          currentSound = audioFileId;
          soundTime = millis();
          soundDuration = allSounds.get(audioFileId).duration() *1000;
          
          return 1;
      }
      /// Error code for the audioFileId not being within the allSounds array
      return -2;
    }
    /// Error code for the case that there isn't any sounds loaded into the array.
    return -1;
  }
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  public int PlaySound(int audioFileId, float inDuration)
  {
    //if (inDuration == null)
    //  inDuration = -1;
    if (allSounds.size() > 0)
    {
      if (audioFileId < allSounds.size())
      {
          for (int lp0 = 0; lp0 < allSounds.size(); lp0++)
            if (allSounds.get(lp0).isPlaying())
              allSounds.get(lp0).stop();
          
          allSounds.get(audioFileId).play();
          
          /// Update the global sound variables.
          currentSound = audioFileId;
          soundTime = millis();
          soundDuration = (inDuration);
          
          return 1;
      }
      /// Error code for the audioFileId not being within the allSounds array
      return -2;
    }
    /// Error code for the case that there isn't any sounds loaded into the array.
    return -1;
  }
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  public int CueSound(int audioFileId)
  {
    if (allSounds.size() > 0)
    {
      if (audioFileId < allSounds.size())
      {
        /// Go through all cuedSounds and check if there is an -1/nothing in the array meaning empty slot to save the sound into to be cued.
        for (int lp0 = 0; lp0 < cuedSounds.length; lp0++)
          if (cuedSounds[lp0] == -1)
          {
            cuedSounds[lp0] = audioFileId;
            cuedSoundsDuration[lp0] = (allSounds.get(cuedSounds[lp0]).duration());
            
            return 1;
          }
            
        /// In the case that no space was found in the cuedSound array then alert the user that the sound that was want to be cued wasn't.
        return -3;
      }
      /// Error code for the audioFileId not being within the allSounds array
      return -2;
    }
    /// Error code for the case that there isn't any sounds loaded into the array.
    return -1;
  }
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  public int CueSound(int audioFileId, float inDuration)
  {
    if (allSounds.size() > 0)
    {
      if (audioFileId < allSounds.size())
      {
        /// Go through all cuedSounds and check if there is an -1/nothing in the array meaning empty slot to save the sound into to be cued.
        for (int lp0 = 0; lp0 < cuedSounds.length; lp0++)
          if (cuedSounds[lp0] == -1)
          {
            cuedSounds[lp0] = audioFileId;
            cuedSoundsDuration[lp0] = (inDuration *1000);
            
            return 1;
          }
            
        /// In the case that no space was found in the cuedSound array then alert the user that the sound that was want to be cued wasn't.
        return -3;
      }
      /// Error code for the audioFileId not being within the allSounds array
      return -2;
    }
    /// Error code for the case that there isn't any sounds loaded into the array.
    return -1;
  }
  
}
