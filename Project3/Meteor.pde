class Meteor extends FallingObject implements Display
{
  float point1;
  float point2;
  float point3;
  float point4;
  float point5;
  float point6;
  boolean destroyed = false;
  

  float diameter;  //Diameter of explosion
  boolean on = false;  //For showing explosion object on screen
  float smallRipple=12;
  float mediumRipple=50;
  
  
  Meteor(float xpos, float ypos, float speed, float r1, float r2, float r3, float r4, float r5, float r6)
  {
    super(xpos, ypos, speed);
    
    //Vertexes in creating meteor
    point1 = 20 + r1;
    point2 = 13 + r2;
    point3 = 13 + r3;
    point4 = 20 + r4;
    point5 = 13 + r5;
    point6 = 13 + r6;
  }
  
  void display()
  {
     if (destroyed == false)
     {
       //Begin drawing
      pushMatrix();
      translate(x, y);
      rotate( y * PI / 500 * fallSpeed / 10 * turn);  //Rotation rate of meteor
      fill(170, 90, 50, 255);
      stroke(0);
      strokeWeight(2);
      beginShape();
      vertex(0, -point1);        //Draw the meteor
      vertex(point2, -point2);   //Looks similar to a hexagon
      vertex(point3, point3);
      vertex(0, point4);
      vertex(-point5, point5);
      vertex(-point6, -point6);
      endShape(CLOSE);
      popMatrix();
     }
     
     else if (destroyed == true)  //If meteor has been hit by projectile
   {
     grow();                      //THIS PART IS FROM MY RECURSION B ASSIGNMENT
     noFill();                    //INSTEAD OF BLUE WATER RIPPLES, I SLIGHTLY CHANGED
     strokeWeight(1);             //THE SIZES AND COLOR TO MAKE THEM LOOK LIKE EXPLOSIONS
     stroke(255, 255, 255, 100);
     ellipse(x, y, diameter, diameter);  //Draw the explosion
     super.show = false;
     ripple(smallRipple, mediumRipple);
   }
  }
  
  //Detect if any projectiles has hit the meteor
  void hitScan()
  {
    if ( destroyed == false)
      for (int i = 0; i < maxBullets; i++)
      {
        if (( x + 15 > bullets[i].x - (bullets[i].yDir * sin(bullets[i].angle)) && x - 15 < bullets[i].x - (bullets[i].yDir * sin(bullets[i].angle))) && (y + 15 > bullets[i].y + (bullets[i].yDir * cos(bullets[i].angle)) && y - 15 < bullets[i].y + (bullets[i].yDir * cos(bullets[i].angle))))
        {
          destroyed = true;  //Destroy meteor is hit
          meteorsDestroyed++;
          score += 250;
          explode();         //Display explosion (Ripple) animation
          meteors.add(new Meteor(random(0, width), 0, random(5, 9), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5)));  //Add a new meteor for each meteor destroyed
        }
      }
  }
  
  void move()  //Override move function from FallingObject class
  {
    y += fallSpeed;
    if (y > height && show)
    {
      y = -10;
      x = random(0, width);
      turn *= -1;  //Add rotation to meteors
    }
  }
  
  void explode()  //Show explosion
  {
    diameter = 1;  //Starting diameter
    on = true;  //Show droplet
  }
  
  void grow()
  {
    if (on == true)
     {
       diameter += 5;  //Growth rate of explosion
       if (diameter > 400)  //Droplet can not grow beyond a 400 pixel diameter
       {
         on = false;  //No longer show explosion on screen
         diameter = 1;  //Reset explosion dize
       }
     }
  }
  
  void drawRippleInner(float diameter)   //Inner Ripple Effect
  {
    if (diameter < 80)  //Ripple can not exceed a diameter of 80 pixels
    {
      noFill();
      strokeWeight(5);
      stroke(255, random(30, 170), random(30, 170), 100);  //Displays different shades of red
      ellipse(x, y, diameter, diameter);  //Draw Circle for Ripple
      drawRippleInner(diameter + 10);  //Recursion with increasing diameters
    }
  }

  void drawRippleOuter(float diameter)  //Outer Ripple Effect
  {
    if (diameter < 140)  //Ripple can not exceed a diameter of 180 pixels
    {
      noFill();
      strokeWeight(5);
      stroke(255, 255, random(30, 170), 50);  //Displays different shades of yellow
      ellipse(x, y, diameter, diameter);  //Draw Circle for Ripple
      drawRippleOuter(diameter + 10);  //Recursion with increasing diameters
    }
  }
  
  void ripple(float inner, float outer)
  {
    drawRippleInner(inner);   //Show the explosion ripples
    drawRippleOuter(outer);   //Parameters are the minimum diameter for each ripple
  }
  
  void go()  //Start Meteor Animation
  {
    move();
    hitScan();
    display();
  }
}
