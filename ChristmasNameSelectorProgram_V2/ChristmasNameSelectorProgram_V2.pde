import processing.sound.*;

main m1;

public SoundEngine SE;
final public int buttonDuration = 200;

public PFont customFont;

boolean MouseClick = false;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup ()
{
  //size(600, 600);
  fullScreen();
  SE = new SoundEngine();
  
  customFont = createFont(dataPath("Fonts/BAUHS93.otf"), 128);
  
  String[] soundAffectFileNames = {
  "mixkit-bonus-earned-in-video-game-2058.wav", "mixkit-unlock-game-notification-253.wav", 
  "mixkit-winning-an-extra-bonus-2060.wav", "pop-39222.wav", "winfantasia-6912.wav", 
  "fireworks/tiny_rocketwav-14647.wav", "fireworks/hq-explosion-6288.wav", 
  "fireworks/mixkit-multiple-fireworks-explosions-1689.wav", "fireworks/mixkit-clear-firework-explosions-2994.wav", 
  "fireworks/firecracker-106974.wav"};
  SE.LoadSoundFiles(dataPath("Sounds"), soundAffectFileNames);
  
  m1 = new main();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw ()
{
  m1.run();
  
  /// Run the main function for the sound engine.
  SE.Run();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mousePressed() 
{
  MouseClick = true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseReleased() 
{
  MouseClick = false;
}
