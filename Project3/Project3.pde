import java.util.*;

PImage bgImg;  //background image

int score = 0;    //Score for game
int timer;        //Time played

int trailNum = 20;        //Number of circles trailing cursor (tank)
int dropNum = 70;         //Number of drop animations
int theta = 0;            //For rotating tank cannon
int turnRate = 4;         //Turn rate of the cannon
int startMeteors = 5;     //Starting amount of meteors
int meteorsDestroyed = 0; //Number of meteors hit
int maxBullets = 30;      //Maximum bullets tank can fire (Projectile class)
int currentBullet = 0;    //Index for bullets array

int[] cursorX = new int[trailNum];  //Store data from cursor X position
int[] cursorY = new int[trailNum];  //Store data from cursor Y position
int indexPosition = 0;              //Index for displaying trail in cursorX[] and cursorY[]
boolean trailDisplay = true;        //Show trail

Drop[] drops = new Drop[dropNum];                    //Array for drops falling on screen
Projectile[] bullets = new Projectile[maxBullets];   //Array for amount of bullets (projectiles)
Tank tank;                                           //Allocate tank object
ArrayList<Meteor> meteors = new ArrayList();         //Array List for total amount of meteors

Soldier Kenny;                                       //Soldiers created
Soldier Kevin;
Soldier Corey;


void setup()
{
  //Configure size, background and speed
  size(500, 700);
  frameRate(35);
  bgImg = loadImage("ssmu__background_city_at_night_by_ssmu-d340gmb.gif");
  timer = int(millis()/1000);
  
  //Create drop objects within the array
  for (int i = 0; i < drops.length; i++) 
  {
    float dropXPos = random(0, width);
    float dropYPos = random(0, 400);
    float dropSpeed = random(5, 15);
    drops[i] = new Drop(dropXPos, dropYPos, dropSpeed);
  }
  
  //Create the starting amount of meteor objects for the game (meteors Array List)
  for (int i = 0; i < startMeteors; i++)
    meteors.add(new Meteor(random(0, width), 0, random(3, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5), random(-5, 5)));  
  
  //Create bullet objects for the bullets array
  for (int i = 0; i < maxBullets; i++)
    bullets[i] = new Projectile();
  
  //Create tank
  tank = new Tank();
  
  //Create soldiers
  Kenny = new Soldier(200, 600, "Kenny");
  Kevin = new Soldier(250, 600, "Kevin");
  Corey = new Soldier(300, 600, "Corey");  
}

void draw()
{
  background(0);
  image(bgImg, 0, 0, width, height);
  
  //Animate drops
  for (int i = 0; i < drops.length; i++)
  {
    drops[i].move();
    drops[i].display();
  }
  
  if (Kenny.alive || Kevin.alive || Corey.alive)
  {
    //Keep track of elapsed time
    timer = int(millis()/1000); 
      
    //Animate Soldiers
    Kenny.go();
    Kevin.go();
    Corey.go();
    
    //Store cursor information for trailling effect
    cursorX[indexPosition] = mouseX;
    cursorY[indexPosition] = mouseY;
    // Cycle between 0 and the number of elements
    indexPosition = (indexPosition + 1) % trailNum;
    //Animate the trail
    showTrail(trailDisplay);
    
    //Animate meteors
    for (int i=0; i < meteors.size(); i++)
    {
      meteors.get(i).go();
    }
    
    //Animate tank
    tank.display();
    
    //Animate bullets
    for (int i = 0; i < maxBullets; i++)
    {
      bullets[i].move();
      bullets[i].display();
    }
  }
  
  else
  {
    pushMatrix();
    translate(width / 2, height / 2);
    fill(255);
    textSize(64);
    text("You Lose", -150, 0);
    textSize(32);
    text("Final Score:  " + score, -150, 100);
    text("Time:  " + timer + " seconds", -150, 150);
    popMatrix();
  }
  
  pushMatrix();
  translate(185, 30);
  fill(255);
  textSize(24);
  text("Score:  " + score, 0, 0);
  textSize(12);
  text("Time:  " + timer, 0, 20);
  popMatrix();
  
  pushMatrix();
  translate(50, 650);
  fill(255);
  if (!Kenny.alive)
    fill(224, 0, 0);
  textSize(28);
  text("Kenny", 0, 0);
  
  fill(255);
  if (!Kevin.alive)
    fill(224, 0, 0);
  text("Kevin", 150, 0);

  fill(255);
  if (!Corey.alive)
    fill(224, 0, 0);
  text("Corey", 300, 0);
  popMatrix();
  
  pushMatrix();
  translate(10, 50);
  fill(255);
  textSize(15);
  text("Controls:", 0, 0);
  text("Left Mouse", 0, 30);
  text("A , D", 0, 50);
  popMatrix();
}

  //For displaying the trail effect
  void showTrail(boolean show)
  {
    boolean showTrail = show;
    if (showTrail)
    {
      for (int i = 0; i < trailNum; i++) 
      {
        // Set the array position to read
        int pos = (indexPosition + i) % trailNum;
        float radius = (trailNum+4*i) / 2.0;
        noStroke();
        fill(#B78943, 10);
        ellipse(cursorX[pos], cursorY[pos], radius+30, radius+30);  //Animate circles to follow cursor
        fill(#B75C43, 75);
        ellipse(cursorX[pos], cursorY[pos], radius+10, radius+10);
        fill(255, 100, 100, 150);
        ellipse(cursorX[pos], cursorY[pos], radius-10, radius-10);
      }
  }
}
