abstract class Character extends GameObject
{
  float x;
  float y;
  String name;
  
  Character(float xpos, float ypos, String charName)
  {
    x = xpos;
    y = ypos;
    name = charName;
  }
}
