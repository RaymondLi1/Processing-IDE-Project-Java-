void keyPressed()
{
  switch(key)
  {
     case 'a':
       theta = theta - turnRate ;  //Turn cannon left
       break;
    
     case 'd':
       theta = theta + turnRate;  //Turn cannon right
       break;
     
     case 'k':
       meteors.add(new Meteor(random(0, width), 0, random(5, 9), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5)));  //Add meteors
       break;
       
  }
}
