void mousePressed()
{
  bullets[currentBullet].start(mouseX, mouseY, theta);  //Fire bullets out of cannon
  currentBullet++;  //Each shot fires a new bullet from the array
  if (currentBullet == maxBullets)  //Cycle back to start of array
    currentBullet = 0;
}
