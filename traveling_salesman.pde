int n=26;//number or towns
int[][] towns=new int[n][2];
int[][] path=new int[n][2];

float shortest=1000;
float idist;//distance from town[plength] to town[i]
float jdist;//distance from town[i] to town[j]
float kdist;//distance from town[j] to town[k]
float tdist=0;//total distance of the path
int plength=0;//how many towns are already on the path
int best;//the current best next town

void setup(){
  noLoop();
  size(400,400);
  stroke(0);
  fill(0);
  strokeWeight(3);
  for(int i=0;i<n;i++){
    for(int j=0;j<2;j++){
      towns[i][j]=round(random(1,400));
    }
  }
  path[0][0]=1;
  path[0][1]=1;
 // plength++;
  towns[0][0]=1;
  towns[0][1]=1;
}


void draw(){
  background(255);
  
  for(int i=0;i<n;i++){
    point(towns[i][0],towns[i][1]);
    text(i,towns[i][0],towns[i][1]+10);
  }
  for(int i=0;i<plength-1;i++){
    line(path[i][1],path[i][1],path[i+1][0],path[i+1][1]);
  }
  text("total distance: "+tdist,10,10);
  text("towns mapped: "+plength,10,30);
  for(int i=0;i<n;i++){
    if(path[i][0]==0){
      idist=dist(towns[plength][0],towns[plength][1],towns[i][0],towns[i][1]);//0 to i
    }
    for(int j=0;j<n;j++){
      if(path[j][0]==0){  
        jdist=dist(towns[i][0],towns[i][1],towns[j][0],towns[j][1]);//i to j
      }
      for(int k=0;k<n;k++){
        if(path[k][0]==0){
          kdist=dist(towns[j][0],towns[j][1],towns[k][0],towns[k][1]);//j to k
        }
        if(idist+jdist+kdist<shortest){
           shortest=idist+jdist+kdist;
           best=i;
        }
      }
    }
  }
  
  
  path[plength][0]=towns[best][0];
  path[plength][1]=towns[best][1];
  plength+=1;
  tdist+=shortest;
  text(plength,100,100);
  text(shortest,120,100);
  shortest=10000;
  
  
}
void mouseClicked(){

  redraw();
}