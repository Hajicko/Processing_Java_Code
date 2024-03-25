Canvas Canv1;

void settings()
{
  size(400, 400);
  
  //fullScreen();
  
}

void setup() 
{
  surface.setTitle("MovingSquares1 V5");
  surface.setResizable(false);
  surface.setLocation(100, 100);
  
  Canv1 = new Canvas();
   
}

void draw() 
{
  /// Reset the Windows background from the past loop.
  background(200);
  
  Canv1.Update();
  Canv1.Render();
}
