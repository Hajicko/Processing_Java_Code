class Sound {
  SoundFile ClickSound;

  Sound(int SoundNumber) {
    ClickSound = new SoundFile(BackgroundMaker.this, "Sounds/Sound" + SoundNumber + ".wav");
  }

  void play() {
    background(255);
    ClickSound.play();
  }

}
