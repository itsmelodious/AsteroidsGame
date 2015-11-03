Floater ship = new SpaceShip();
Star stars[] = new Star[200];
boolean accelerate = false;
boolean decelerate = false;
boolean rotateClockwise = false;
boolean rotateCounterClockwise = false;
boolean hyperspace = false;
public void setup() 
{
  background(0);
  size(500, 500);
  for(int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i < stars.length; i++)
  {
    stars[i].show();
  }
  ship.show();
  ship.move();
  if (accelerate == true)
  {
    ship.accelerate(0.50);
  }
  else if (decelerate == true)
  {
    ship.accelerate(-0.50);
  }
  else if (rotateClockwise == true)
  {
    ship.rotate(10);
  }
  else if (rotateCounterClockwise == true)
  {
    ship.rotate(-10);
  }
  else if(hyperspace == true)
  {
    ship.setX((int)(Math.random()*500));
    ship.setY((int)(Math.random()*500));
    ship.setDirectionX(0);
    ship.setDirectionY(0);
  }
}
public void keyPressed()
{
  if (key == 'w') {accelerate = true;}
  else if (key == 's') {decelerate = true;}
  else if (key == 'd') {rotateClockwise = true;}
  else if (key == 'a') {rotateCounterClockwise = true;}
  else if (key == ' ') {hyperspace = true;}
}
public void keyReleased()
{
  if (key == 'w') {accelerate = false;}
  else if (key == 's') {decelerate = false;}
  else if (key == 'd') {rotateClockwise = false;}
  else if (key == 'a') {rotateCounterClockwise = false;}
  else if (key == ' ') {hyperspace = false;}
}
class SpaceShip extends Floater  
{   
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double  getPointDirection() {return myPointDirection;}

  public SpaceShip()
  {
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
    myColor = color(192, 69, 69);
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void hyperFade()
  {
    
    ellipse(ship.getX()+5, ship.getY()+5, 35, 35);
  }
}
class Star
{
  private int myStarColor;
  private double myStarX, myStarY, myStarSize;
  public Star()
  {
    myStarColor = color(255, 255, 255);
    myStarX = Math.random()*500;
    myStarY = Math.random()*500;
    myStarSize = Math.random()*5;
  }
  public void show()
  {
    fill(myStarColor);
    stroke(myStarColor);
    ellipse((int)myStarX, (int)myStarY, (int)myStarSize, (int)myStarSize);
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

