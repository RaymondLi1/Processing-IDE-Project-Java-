abstract class FallingObject implements Display
{
  float x;
  float y;
  float fallSpeed;  //Movement along y-axis
  int turn = 1;
  boolean show = true;  //Display or not
  
  FallingObject(float xpos, float ypos, float speed)
  {
    x = xpos;
    y = ypos;
    fallSpeed = speed;
  }
  
    void move()
  {
    y += fallSpeed;  //Move down y-axis
    if (y > height)  //If drop has reached the bottom of the screen
    {
      y = -10;              //Start from top again with random x-position
      x = random(0, width);
    }
  }
  abstract void display();
}
