class Bug {
  int col;
  float x;
  float y;
  float angle;
  float dangle;
}
boolean touching(Bug chamelion1,Bug chamelion2){
  return dist(chamelion1.x,chamelion1.y,chamelion2.x,chamelion2.y)<20;
}
int bugCount=200;
void setup(){
  size(800,800);
  frameRate(120);
}

Bug[] chamelion=new Bug[bugCount];{
  for(int i=0; i<bugCount;i++){
    chamelion[i]=new Bug();
    chamelion[i].col=round(random(-.5,2.5));
    chamelion[i].x=random(40,700);
    chamelion[i].y=random(40,500);
    chamelion[i].angle=random(0,2*PI);
    chamelion[i].dangle=random(-.1,1);
  }
}
color[] bugColor=new color[3];{
  bugColor[0]=#ff0000;
  bugColor[1]=#00ff00;
  bugColor[2]=#0000ff;
}
int[] count={0,0,0};

void draw(){
  fill(255);
  rect(0,0,width,height-bugCount);
  count[0]=0;
  count[1]=0;
  count[2]=0;
  for(int i=0; i<chamelion.length;i++){
    chamelion[i].x+=cos(chamelion[i].angle);
    chamelion[i].y+=sin(chamelion[i].angle);
    chamelion[i].angle+=chamelion[i].dangle;
    chamelion[i].dangle+=random(-.01,.01);
    if(chamelion[i].dangle>0.1||chamelion[i].dangle<-0.1)chamelion[i].dangle=0;
    if(chamelion[i].x>width-10)chamelion[i].angle=PI;
    if(chamelion[i].x<10)chamelion[i].angle=0;
    if(chamelion[i].y<10)chamelion[i].angle=PI/2;
    if(chamelion[i].y>height-10-bugCount)chamelion[i].angle=3*PI/2 ;
    
  }
  
  for(int i=0; i<chamelion.length;i++){
    for(int j=0; j<chamelion.length;j++){
      if(touching(chamelion[i],chamelion[j])){
        if(chamelion[i].col==0 && chamelion[j].col==1){
          chamelion[i].col=0;
          chamelion[j].col=0;
        }
        if(chamelion[i].col==1 && chamelion[j].col==2){
          chamelion[i].col=1;
          chamelion[j].col=1;
        }
        if(chamelion[i].col==2 && chamelion[j].col==0){
          chamelion[i].col=2;
          chamelion[j].col=2;
        }
      }  
    }
    count[chamelion[i].col]++;
    fill(bugColor[chamelion[i].col]);

    ellipse(chamelion[i].x,chamelion[i].y,20,20);
    line(chamelion[i].x,chamelion[i].y,chamelion[i].x+cos(chamelion[i].angle)*10,chamelion[i].y+sin(chamelion[i].angle)*10);

  }
  if(frameCount%width==1){
    fill(255);
    rect(0,height-bugCount,width,bugCount);
  }
  for(int i=0; i<3;i++){
    stroke(bugColor[i]);
    point(frameCount%width,height-count[i]);
  }
  stroke(0);
  textSize(20);
  fill(255);
  if(count[0]==bugCount){
    rect(width/2,height/2-20,150,20);
    fill(255,0,0);
    text("Red Wins!",width/2,height/2);
    noLoop();
  }
  if(count[1]==bugCount){
    rect(width/2,height/2-20,150,20);
    fill(0,255,0);
    text("Green Wins!",width/2,height/2);
    noLoop();
  }
  if(count[2]==bugCount){
    rect(width/2,height/2-20,150,20);
    fill(0,0,255);
    text("Blue Wins!",width/2,height/2);
    noLoop();
  }
}