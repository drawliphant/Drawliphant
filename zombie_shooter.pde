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
void zombie(){
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
void zombie(float x, float y, int health){
  float[] xyh=new float[3];
  xyh[0]=x;
  xyh[1]=y;
  xyh[2]=health;
  zombies.add(xyh);
}

void bullet(float x, float y, int mouseX, int mouseY, float[][]zombies) {
  float angle=atan2(mouseY-y, mouseX-x);
  float range=dist(0, 0, width, height);
  float x2=x+range*cos(angle);
  float y2=y+range*sin(angle);
  line(x, y, x2, y2);


  for (int i=0; i<zombies.length; i++) {
    if(hit(zombies[i][0],zombies[i][1],x,y,x2,y2)){
      zombies[i][2]-=50;
    }
  }
};

void mousePressed() {
  bullet(playerX, playerY, mouseX, mouseY, zombies);
}
void keyPressed() {
  if (key=='w') keys[0]=true;
  if (key=='a') keys[1]=true;
  if (key=='s') keys[2]=true;
  if (key=='d') keys[3]=true;
  if(key==' '){
    zombie();
  }
}
void keyReleased() {
  if (key=='w') keys[0]=false;
  if (key=='a') keys[1]=false;
  if (key=='s') keys[2]=false;
  if (key=='d') keys[3]=false;
}

float playerX=width/2;
float playerY=height/2;
boolean[] keys=new boolean[4];
int playerHealth=100;
int playerSpeed=2;
int lives=3;

ArrayList<float[]> zombies=new ArrayList<float[]>();
//ArrayList<String[]> outerArr = new ArrayList<String[]>(); 
float zombieAngle;



void setup() {
  size(400, 400);
}

void draw() {
  background(255);

  if (keys[0]) playerY-=playerSpeed;
  if (keys[1]) playerX-=playerSpeed;
  if (keys[2]) playerY+=playerSpeed;
  if (keys[3]) playerX+=playerSpeed;

  fill(500-playerHealth*4, 0, playerHealth*4);
  ellipse(playerX, playerY, 25, 25);
  
  fill(0, 0, 255);
  for (int i=0; i<lives; i++) {
    ellipse(i*15+15, 25, 10, 10);
  }
  
  for (int i=0; i<zombies.size();i++){
    zombies.get(i[0]);
    zombieAngle=atan2(playerY-zombies.get[i][1],playerX-zombies[i][0]);
    fill(500-zombies[i][2]*4,zombies[i][2]*4 ,0);
    ellipse(zombies[i][0],zombies[i][1],25,25);
    zombies[i][0]+=cos(zombieAngle);
    zombies[i][1]+=sin(zombieAngle);
    //if(zombie gets too close) playerHealth--;
  }

  if (playerHealth<=0) {
    lives--;
    playerHealth=100;
    playerX=width/2;
    playerY=height/2;
    background(255, 0, 0);
  }
  if (lives<0) {
    text("GAME OVER", 200, 200);
  }
}
