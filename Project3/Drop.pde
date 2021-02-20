class Drop extends FallingObject
{
  
  Drop(float xpos, float ypos, float speed)
  {
    super(xpos, ypos, speed);
  }
  
  void display()
  {
    stroke(#B75C43);  //Color of drops
    strokeWeight(random(1, 5));  //Constantly change size of drops
    line(super.x, super.y, super.x, super.y-10);  //Coordinates
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
}
