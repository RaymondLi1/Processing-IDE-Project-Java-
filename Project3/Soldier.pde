class Soldier extends Character implements Display
{
  float armPos = 5;    //Positions of the arms along x axis
  float legPos = 2;    //Positions of the legs along x axis
  float eyePos = -3;   //Position of the eyes along x axis (all of these are needed for when character turns)
  int turn = 1;        // (+/-) Character turns around
  float legLength = 7;  //For thigh and forleg
  float armLength = 8;  //For upper and lower arm
  int rotateDir = 1;    //Change limb rotation direction
  int direction = -1;   //Unit of travel along x-axis
  int rotation = 0;     //Degrees of rotation
  int rangeRotation = 30;  //Angle of rotation
  boolean alive = true; //For hitscan and character death
  
  Soldier(float xpos, float ypos, String name)
  {
    super(xpos, ypos, name);  //Character constructer
  }
  
  //All character movements
  void move()
  {
    rotation += rotateDir;     //Rotate limbs
    if (abs( rotation) > rangeRotation)  //Range of rotation
      rotateDir *= -1;  //If rotation reaches end of range, rotate the other way
      
    if (x == 100 || x == 400)  //Range soldiers may walk along x axis
      turn *= -1;  //Turn around if at the end of range
    x -= turn;  //Walk
  }
  
  void display()
  {
    if (alive)
    {
      pushMatrix();
      translate(x, y);  //Place at specified location
      noStroke();
      rectMode(CENTER);    
      //Begin drawing
     
      //Inner Upper Leg
      pushMatrix();
      translate(legPos, 10);
      rotate(rotation*PI/180*turn);    
      fill(125);
      rect(0, legLength/2, 5, legLength);
      translate(0, legLength);
      
      //Inner Lower Leg
      pushMatrix();
      rotate(-abs(rotation*PI/180)*turn);
      rect(0, legLength/2, 5, legLength);
      
      //Inner Shoe or Foot
      fill(100);
      rect(-legLength / 2 * turn, legLength, 8, 5);
      popMatrix();     
      popMatrix();
      
      //Outer Upper Leg
      pushMatrix();
      translate(-legPos, 10);
      rotate(-rotation*PI/180*turn);
      fill(125);
      rect(0, legLength/2, 7, legLength);
      translate(0, legLength);
      
      //Outer Lower Leg
      pushMatrix();
      rotate(-abs(rotation*PI/180)*turn);
      rect(0, legLength/2, 5, legLength);
      
      //Outer Shoe or Foot
      fill(100);
      rect(-legLength / 2 * turn, legLength, 8, 5);
      popMatrix();
      popMatrix();
      
      //Inner Upper Arm
      pushMatrix();
      translate(-armPos, -2);
      rotate(rotation*PI/180);
      fill(#FFD9A7);
      rect(0, armLength/2, 5, armLength);
      
      //Inner Lower Arm
      pushMatrix();
      translate(0, armLength);
      rotate(abs(rotation*PI/180*2)*turn);
      rect(0, armLength/2, 5, armLength);
      popMatrix();
      popMatrix();
      
      //Torso
      pushMatrix();
      fill(#02DB28);
      rect(0, 0, 10, 20);
      popMatrix();
      
      //Head
      pushMatrix();
      translate(0, -10);
      fill(#FFD9A7);
      ellipse(0, 0, 10, 10);  //Head
      fill(1);
      ellipse(turn*eyePos, -0.5, 3, 3);  //Eyes
      fill(#02DB28);
      rect(0, -5, 10, 5);  //Helmet
      popMatrix();
      
      //Outer Upper Arm
      pushMatrix();
      rotate(-rotation*PI/180);
      translate(armPos, -2);
      fill(#FFD9A7);
      rect(0, armLength/2, 5, armLength);
      
      //Outer Lower Arm
      pushMatrix();
      translate(0, armLength);
      rotate(abs(rotation*PI/180*2)*turn);
      rect(0, armLength/2, 5, armLength);
      popMatrix();    
      popMatrix();
      
      popMatrix();
    }
  }
   
  //Detect if any meteors have collided while alive
  void hitScan()
  {
    if (alive)
      for (int i = 0; i < meteors.size(); i++)
        if ( (meteors.get(i).destroyed == false) && (meteors.get(i).x + 15 > x - 10) && (meteors.get(i).x - 15 < x + 10) && (meteors.get(i).y + 15 > y - 10) && (meteors.get(i).y - 15 < y + 10))
        {
          alive = !alive;
        }
  }
  
  //Start animation
  void go()
  {
    move();
    hitScan();
    display();
  }
}
