Floater ship = new SpaceShip();
Star stars[] = new Star[200];
int initialAst = 15;
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
ArrayList <Bullet> bullets = new ArrayList <Bullet>();
boolean accelerate = false;
boolean decelerate = false;
boolean rotateClockwise = false;
boolean rotateCounterClockwise = false;
boolean hyperspace = false;

public void setup() 
{
  size(500, 500);
  background(0);
  smooth();
  for(int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
  for(int k = 0; k < initialAst; k++)
  {
    asteroids.add(k, new Asteroid());
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i < stars.length; i++)
  {   
    stars[i].show();
  }
  for(int k = asteroids.size() - 1; k >= 0; k--)
  {
    asteroids.get(k).show();
    asteroids.get(k).move();
    if(dist(ship.getX(), ship.getY(), asteroids.get(k).getX(), asteroids.get(k).getY()) < 20)
      asteroids.remove(k);
  }
  if(bullets.size() > 0)
  {
    for(int j = bullets.size()-1; j >= 0; j--)
    {
      bullets.get(j).show();
      bullets.get(j).move();
      for(int a = 0; a < asteroids.size(); a++)
      {
        if(dist(asteroids.get(a).getX(), asteroids.get(a).getY(), bullets.get(j).getX(), bullets.get(j).getY()) < 20)
        {
          asteroids.remove(a);
          bullets.remove(j);
          break;
        }
      }
    }
  }
  ship.show();
  if (accelerate == true)
  {
    ship.accelerate(0.50);
    int rX1, rY1, rX2, rY2, rX3, rY3;
    float dRadians = (float)(ship.getPointDirection()*(Math.PI/180));
    translate((float)ship.getX(), (float)ship.getY());
    rotate(dRadians);
    rX1 = -15;
    rY1 = 0;
    rX2 = -10;
    rY2 = -5;
    rX3 = -10;
    rY3 = 5;
    int myRocketColor = color(255, 171, 0);
    fill(myRocketColor);
    stroke(myRocketColor);
    triangle(rX1, rY1, rX2, rY2, rX3, rY3);
    rotate(-dRadians);
    translate((float)(-ship.getX()), (float)(-ship.getY()));
  }
  else if (decelerate == true)
  {
    ship.accelerate(-0.50);
  }
  else if (rotateClockwise == true)
  {
    ship.myRotate(10);
  }
  else if (rotateCounterClockwise == true)
  {
    ship.myRotate(-10);
  }
  else if(hyperspace == true)
  {
    fill(0, 0, 0);
    noStroke();
    ellipse(ship.getX(), ship.getY(), 35, 35);
    ship.setX((int)(Math.random()*500));
    ship.setY((int)(Math.random()*500));
    ship.setDirectionX(0);
    ship.setDirectionY(0);
  }
  ship.move();
}
public void keyPressed()
{
  if (key == 'w') {accelerate = true;}
  else if (key == 's') {decelerate = true;}
  else if (key == 'd') {rotateClockwise = true;}
  else if (key == 'a') {rotateCounterClockwise = true;}
  else if (key == 'v') {hyperspace = true;}
  else if (key == ' ') {bullets.add(new Bullet());}
}
public void keyReleased()
{
  if (key == 'w') {accelerate = false;}
  else if (key == 's') {decelerate = false;}
  else if (key == 'd') {rotateClockwise = false;}
  else if (key == 'a') {rotateCounterClockwise = false;}
  else if (key == 'v') {hyperspace = false;}
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
  public void show()
  {  
    super.show(); //inheirited  
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

class Asteroid extends Floater
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
  private int rotationSpeed;
  
  public Asteroid()
  {
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -12;
    yCorners[0] = -20;
    xCorners[1] = 8;
    yCorners[1] = -16;
    xCorners[2] = 20;
    yCorners[2] = 0;
    xCorners[3] = 8;
    yCorners[3] = 16;
    xCorners[4] = -12;
    yCorners[4] = 20;
    xCorners[5] = -24;
    yCorners[5] = 0;
    myColor = color(212, 171, 106);
    myCenterX = (int)(Math.random()*500);
    myCenterY = (int)(Math.random()*500);
    myDirectionX = (Math.random()*2)-1;
    myDirectionY = (Math.random()*2)-1;
    myPointDirection = 0;
    rotationSpeed = (int)(Math.random()*9)-4;
  }
  public void move()
  {
    while (myDirectionX == 0 || myDirectionY == 0)
    {
      myDirectionX = (Math.random()*2)-1;
      myDirectionY = (Math.random()*2)-1;
    }
    super.myRotate(rotationSpeed);
    super.move();
  }
}

class Bullet extends Floater
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

  public Bullet()
  {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5*Math.sin(dRadians) + ship.getDirectionY();
    myColor = color(255, 255, 153);
  }
  public void show()
  {
    fill(myColor);
    stroke(myColor);
    ellipse((int)myCenterX, (int)myCenterY, 10, 10);
  }
  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
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
  public void myRotate (int nDegreesOfRotation)   
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

