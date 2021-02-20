class Tank extends GameObject
{
  //The tank will always follow the cursor
  float y1 = -15;  //Positioning tread lines to simulate movement
  float y2 = -5;
  float y3 = 5;
  
  //Start animation
  void display()
  {
    body();
    treads();
    treadsMove();
    head();
  }
  
  void head()
  {
    pushMatrix();
    translate(mouseX, mouseY);
    
    fill(#27D61C);
    noStroke();
    ellipse(0, 0, 20, 20);  //Tank head (biggest circle)
    
    rotate(theta*PI/180);  //Rotate cannon and design
    
    stroke(#27D61C);    //Draw cannon
    strokeWeight(10);
    line(0, 0, 0, -30);
    
    noStroke();  //Small design
    fill(255);
    ellipse(3, -3, 5, 5);
    popMatrix();
  }
  
  void body()
  {
    pushMatrix();
    translate(mouseX, mouseY);  
    fill(#31FF24);
    stroke(50, 50, 50);
    strokeWeight(2);
    rect(0, 0, 32, 32);  //Draw the main body (rectangle)
    popMatrix();
  }
  
  void treads()
  {
    pushMatrix();
    translate(mouseX, mouseY);
    
    pushMatrix();
    translate(-20, 0);
    rectMode(CENTER);
    fill(#B4B4B4);
    stroke(50, 50, 50);
    strokeWeight(2);
    rect(0, 0, 10, 30);   //Draw left treads
    line(-5, y1, 5, y1);  //Draw lines for left treads
    line(-5, y2, 5, y2); 
    line(-5, y3, 5, y3); 
    popMatrix();
    
    pushMatrix();
    translate(20, 0);
    rectMode(CENTER);
    fill(#B4B4B4);
    stroke(50, 50, 50);
    strokeWeight(2);
    rect(0, 0, 10, 30);   //Draw right treads
    line(-5, y1, 5, y1);  //Draw lines for right treads
    line(-5, y2, 5, y2); 
    line(-5, y3, 5, y3); 
    popMatrix();
    
    popMatrix();
    
    treadsMove();
  }
  
  void treadsMove()
  {
    y1--;            //Move the tread lines up to simulate movement
    y2--;
    y3--;
    if (y1 <= -15)  //If tread lines reach the end of the tread, start again from the bottem
      y1 = 15;      //NUMBERS ARE HARD CODED
    if (y2 <= -15)
      y2 = 15;
    if (y3 <= -15)
      y3 = 15;
  }
}
