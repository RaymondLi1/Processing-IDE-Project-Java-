class Projectile extends GameObject implements Display
{
  
  float yDir;        //Direction along rotated axis
  float x = -1000;   //Start off screen
  float y = -1000;   //Start off screen
  float angle;       //Angle fired
  float speed = 7;   //Bullet speed
  boolean fire = false;  //Boolean variable activated from mouse click
  
  void start(float xpos, float ypos, float startAngle)
  {
    x = xpos;
    y = ypos;
    yDir = 0;                       //Coordinate along rotated axis
    angle = startAngle * PI / 180;  //get rotational angel from the cannon before launch
    fire = true;                    //mouse has been clicked
  }
  
  void move()
  {
    if (fire == true)
    {
      yDir -= speed;  //Move along axis
    }
  }
  
  //Show bullet
  void display()
  {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    stroke(255);
    strokeWeight(4);
    line(0, yDir, 0, yDir - 6); 
    popMatrix();
   
  }
}
