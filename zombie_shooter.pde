boolean hit(float x, float y, float x1, float y1, float x2, float y2) {

  float A = x - x1;
  float B = y - y1;
  float C = x2 - x1;
  float D = y2 - y1;
  boolean ret;
  float dot = A * C + B * D;
  float len_sq = C * C + D * D;
  float param = -1;
  if (len_sq != 0) //in case of 0 length line
    param = dot / len_sq;

  float xx, yy;

  if (param < 0) {
    xx = x1;
    yy = y1;
  } else if (param > 1) {
    xx = x2;
    yy = y2;
  } else {
    xx = x1 + param * C;
    yy = y1 + param * D;
  }

  ret=dist(x, y, xx, yy)<13;
  return ret;
}
void zombie(){//auto places a zombie with 100 health at a random wall at a random point on that wall
  float[] xyh=new float[3];{
    xyh[2]=100;
  }
  boolean one=random(1)<.5;
  boolean two=random(1)<.5;
  if(one&&two){
    xyh[0]=random(0,400);
    xyh[1]=0;
  }
  if(!one&&two){
    xyh[0]=random(0,width);
    xyh[1]=height;
  }
  if(!one&&!two){
    xyh[0]=width;
    xyh[1]=random(0,height);
  }
  if(one&&!two){
    xyh[0]=0;
    xyh[1]=random(0,height);
  }
  zombies.add(xyh);
}
void zombie(float x, float y, int health){//un used overload to manually place zombie at an x and y with health
  float[] xyh=new float[3];
  xyh[0]=x;
  xyh[1]=y;
  xyh[2]=health;
  zombies.add(xyh);
}

void bullet(float x, float y, int mouseX, int mouseY, ArrayList<float[]>zombies) {//everything that is run when firing
  float angle=atan2(mouseY-y, mouseX-x);//find the angle theyre shooting at
  float range=dist(0, 0, width, height);//shoot just far enough to go from corner to opostie corner
  float x2=x+range*cos(angle);//end point of bullet, where it lands
  float y2=y+range*sin(angle);
  
  line(x, y, x2, y2);//draw the bullet


  for (int i=0; i<zombies.size(); i++) {//run through each zombie and test if hit etc
    xyh=zombies.get(i);//put array list at i in the array
    if(hit(xyh[0],xyh[1],x,y,x2,y2)){//text if the zombie was hit by the bullet
      xyh[2]-=50;//zombie takes damage
      if(xyh[2]<=0){zombies.remove(i);}//if zombie is out of health it dies
    }
  }
};

void mousePressed() {
  bullet(playerX, playerY, mouseX, mouseY, zombies);//shoot and test if it hits etc
}
void keyPressed() {//sets bool to true if the key is pressed
  if (key=='w') keys[0]=true;
  if (key=='a') keys[1]=true;
  if (key=='s') keys[2]=true;
  if (key=='d') keys[3]=true;
  if(key==' '){//spawn a zombie at a random wall when you press space
    zombie(200,200,100);
  }
}
void keyReleased() {//if a key is released then set its bool to false
  if (key=='w') keys[0]=false;
  if (key=='a') keys[1]=false;
  if (key=='s') keys[2]=false;
  if (key=='d') keys[3]=false;
}
 
float playerX=width/2;
float playerY=height/2;//put player x and y in middle of screen
boolean[] keys=new boolean[4];//used to hold key inputs
int playerHealth=100;//start health of player
int playerSpeed=2;//player speed multiplier
int lives=3;//player lives

ArrayList<float[]> zombies=new ArrayList<float[]>();//holds the zombies, array holds x,y,health
float[] xyh=new float[3];//used to take and add arrays to zombie arraylist

float zombieAngle;//used to make zombie walk toward player



void setup() {
  size(400, 400);//screen size, should be scalable with height and width gloabals
}

void draw() {
  background(255);//draw a white back

  if (keys[0]) playerY-=playerSpeed;
  if (keys[1]) playerX-=playerSpeed;
  if (keys[2]) playerY+=playerSpeed;
  if (keys[3]) playerX+=playerSpeed;//make controls take affect

  fill(500-playerHealth*4, 0, playerHealth*4);//player health shown by blue to red
  ellipse(playerX, playerY, 25, 25);//draw player
  
  fill(0, 0, 255);//lives draw blue
  for (int i=0; i<lives; i++) {
    ellipse(i*15+15, 25, 10, 10);//draw lives circles
  }
  
  for (int i=0; i<zombies.size();i++){//run for every zombie
    float[] xyh=zombies.get(i);//acces the array list at i
    zombieAngle=atan2(playerY-xyh[1],playerX-xyh[0]);//find the angle between guy and zombie
    fill(500-xyh[2]*4,xyh[2]*4 ,0);//color zombie by health, green full, red dead
    ellipse(xyh[0],xyh[1],25,25);//draw zombie
    xyh[0]+=cos(zombieAngle);
    xyh[1]+=sin(zombieAngle);//move toward player by angle
    
    if(dist(xyh[0],xyh[1],playerX,playerY)<25)playerHealth--;//if you get to close the any zombie loose health
  }

  if (playerHealth<=0) {//death code
    lives--;//one less life
    playerHealth=100;//reset player
    playerX=width/2;
    playerY=height/2;//put the player in the center of the screen
    background(255, 0, 0);
  }
  if (lives<0) {//game over code
    text("GAME OVER", 200, 200);
  }
}
