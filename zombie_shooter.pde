boolean hit(float x, float y, float x1, float y1, float x2, float y2) {
//tests if the bullet line intersects with zombie
//its all witchcraft
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

  if (param < 0) {//if the zombie is begind player measure from player
    xx = x1;
    yy = y1;
  } else if (param > 1) {//if zombie is past bullet distance then measure from where it lands
    xx = x2;
    yy = y2;
  } else {//otherwise measure distance from closest point on line
    xx = x1 + param * C;
    yy = y1 + param * D;
  }

  ret=dist(x, y, xx, yy)<13;//test if line is close enough to zombie to hit
  return ret;//returns boolean if it hit the zombie
}
void zombie(){//auto places a zombie with 100 health at a random wall at a random point on that wall
  float[] xyh=new float[4];{//used to get x,y,health,speed of zombies
    xyh[2]=100;//health at 100%
    xyh[3]=0;
  }
  boolean one=random(1)<.5;//gets random bool
  boolean two=random(1)<.5;//random bool 2
  if(one&&two){//25% chance of spawning at top
    xyh[0]=random(0,400);
    xyh[1]=-20;
  }
  if(!one&&two){//spawn at bottom
    xyh[0]=random(0,width);
    xyh[1]=height+20;
  }
  if(!one&&!two){//spawn at right
    xyh[0]=width+20;
    xyh[1]=random(0,height);
  }
  if(one&&!two){//spawn at left
    xyh[0]=-20;
    xyh[1]=random(0,height);
  }
  zombies.add(xyh);//put the new zombie values into arrayList
}
void zombie(float x, float y, int health){//un used overload to manually place zombie at an x and y with health
  float[] xyh=new float[4];
  xyh[0]=x;
  xyh[1]=y;
  xyh[2]=health;
  xyh[3]=0;
  zombies.add(xyh);
}

void bullet(float x, float y, int mouseX, int mouseY, ArrayList<float[]>zombies) {//everything that is run when firing
  float angle=atan2(mouseY-y, mouseX-x);//find the angle theyre shooting at
  float range=dist(0, 0, width, height);//shoot just far enough to go from corner to opostie corner
  float x2=x+range*cos(angle);//end point of bullet, where it lands
  float y2=y+range*sin(angle);
  float gunEndX=x+cos(angle)*30;//playerX+cos(gunAngle)*30,playerY+sin(gunAngle)*30
  float gunEndY=y+sin(angle)*30;
  line(x+cos(angle)*30, y+sin(angle)*30, x2, y2);//draw the bullet
  strokeWeight(6);
  stroke(255,255,0);
  float rangle=random(-PI/8,PI/8);
  line(gunEndX,gunEndY,gunEndX+cos(angle+rangle)*20,gunEndY+sin(angle+rangle)*20);
  rangle=random(-PI/8,PI/8);
  line(gunEndX,gunEndY,gunEndX+cos(angle+rangle)*20,gunEndY+sin(angle+rangle)*20);
  rangle=random(-PI/8,PI/8);
  line(gunEndX,gunEndY,gunEndX+cos(angle+rangle)*20,gunEndY+sin(angle+rangle)*20);
  strokeWeight(3);
  stroke(0);
  for (int i=0; i<zombies.size(); i++) {//run through each zombie and test if hit etc
    xyh=zombies.get(i);//put array list at i in the array
    if(hit(xyh[0],xyh[1],x,y,x2,y2)){//text if the zombie was hit by the bullet
      xyh[2]-=49;//zombie takes damage
      xyh[3]=-3;//zombie get knocked back
      if(xyh[2]<=0){
        zombies.remove(i);
        points++;
        zombie();
        if (points>highScore){
          highScore=points;
        }  
        
      }//if zombie is out of health it dies
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
    zombie();
  }
}
void keyReleased() {//if a key is released then set its bool to false
  if (key=='w') keys[0]=false;
  if (key=='a') keys[1]=false;
  if (key=='s') keys[2]=false;
  if (key=='d') keys[3]=false;
}
 

boolean[] keys=new boolean[4];//used to hold key inputs
int playerHealth=100;//start health of player
int playerSpeed=2;//player speed multiplier
int lives=3;//player lives
int points=0;
int highScore=0;
int frames=0;
ArrayList<float[]> zombies=new ArrayList<float[]>();//holds the zombies, array holds x,y,health
float[] xyh=new float[4];//used to take and add arrays to zombie arraylist

float zA;//used to make zombie walk toward player
float gunAngle;

//PImage img;
void setup() {
  size(400, 400);//screen size, should be scalable with height and width gloabals
  zombie();
  strokeWeight(3);
  //img = loadImage("back.jpg");
}
float playerX=200;
float playerY=200;//put player x and y in middle of screen

void draw() {
  background(255);//draw a white back
  //image(img,0,0,width/2,height/2);
  //image(img,width/2,0,width/2,height/2);
  //image(img,0,height/2,width/2,height/2);
  //image(img,width/2,height/2,width/2,height/2);
  if (keys[0]) playerY-=playerSpeed;
  if (keys[1]) playerX-=playerSpeed;
  if (keys[2]) playerY+=playerSpeed;
  if (keys[3]) playerX+=playerSpeed;//make controls take affect
  
  frames++;
  if(frames%200==0){
    zombie();
  }

  fill(500-playerHealth*5, 0, playerHealth*5);//player health shown by blue to red
  ellipse(playerX, playerY, 25, 25);//draw player
  gunAngle=atan2(mouseY-playerY,mouseX-playerX);
  strokeWeight(6);
  line(playerX+cos(gunAngle)*15,playerY+sin(gunAngle)*15,playerX+cos(gunAngle)*30,playerY+sin(gunAngle)*30);
  strokeWeight(3);
  fill(0, 0, 255);//lives draw blue
  for (int i=0; i<lives; i++) {
    ellipse(i*15+15, 40, 10, 10);//draw lives circles
  }
  fill(0);
  text("points: "+points,8,15);
  text("High Score: "+highScore,7,30);
  
  for (int i=0; i<zombies.size();i++){//run for every zombie
    float[] xyh=zombies.get(i);//acces the array list at i
    zA=atan2(playerY-xyh[1],playerX-xyh[0]);//find the angle between guy and zombie
    fill(500-xyh[2]*4,xyh[2]*4 ,0);//color zombie by health, green full, red dead
    ellipse(xyh[0],xyh[1],25,25);//draw zombie
    //draw zombie arms
    line(xyh[0]+cos(zA+PI/4)*13,xyh[1]+sin(zA+PI/4)*13,xyh[0]+cos(zA+PI/8)*25,xyh[1]+sin(zA+PI/8)*25);
    line(xyh[0]+cos(zA-PI/4)*13,xyh[1]+sin(zA-PI/4)*13,xyh[0]+cos(zA-PI/8)*25,xyh[1]+sin(zA-PI/8)*25);
    
    xyh[0]+=cos(zA)*xyh[3];
    xyh[1]+=sin(zA)*xyh[3];//move toward player by angle
    if(xyh[3]<1)xyh[3]+=.2;
    if(dist(xyh[0],xyh[1],playerX,playerY)<25)playerHealth--;//if you get to close the any zombie loose health
  }

  if (playerHealth<=0) {//death code
    lives--;//one less life
    playerHealth=100;//reset player
    playerX=width/2;
    playerY=height/2;//put the player in the center of the screen
    background(255, 0, 0);
  }
  if(lives<0) {//game over code
    delay(1000);//wait a second to make you realize you is kill and you loose
    
    points=0;//reset points, frames and lives
    frames=0;
    lives=3;
    int zombienum=zombies.size();//get the length of the zombie arraylist
    for(int i=zombienum-1; i>0;i--){//remove all zombies
      zombies.remove(i);
    }
    zombies.remove(0);
    zombie();//spawn a new zombie to start the game again
  }
}
