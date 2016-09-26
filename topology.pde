int area=40;
float distance;
float rate=.1;
int deltax;
int deltay;
int[][] around=new int[4][2];{
around[0][0]=1;
around[0][1]=0;
around[1][0]=0;
around[1][1]=1;
around[2][0]=-1;
around[2][1]=0;
around[3][0]=0;
around[3][1]=-1;
}
float[][] top=new float[area][area];
float[][] water=new float[area][area];{
for(int i=0;i<area;i++){
  for(int j=0;j<area;j++){
    top[i][j]=50+(i-20)*(i-20)/4-(j-20)*(j-20)/4;//+(j-area/2);
    water[i][j]=25;
  }
}}
void setup(){
  size(400,400);
  strokeWeight(width/area);
}
void draw(){
  int totalwater=0;
  int totaltop=0;
  background(0,0,0);
  for(int i=1;i<area-1;i++){
    for(int j=1;j<area-1;j++){
      //find lowest,find disntance between them, put water in that at *distance rate
      totalwater+=water[i][j];
      totaltop+=top[i][j];
      for(int k=0;k<4;k++){
        if( water[i][j]>0){
          deltax=around[k][0];
          deltay=around[k][1];
          distance=(top[i][j]+water[i][j])-(top[i+deltax][j+deltay]+water[i+deltax][j+deltay]);
          if(distance>0){
            water[i][j]-=distance*rate;
            water[i+deltax][j+deltay]+=distance*rate;
          }
        }
      }
      
      stroke(top[i][j]*2.5,top[i][j]*2.5,top[i][j]*2.5+water[i][j]*2.5);
      //stroke(top[i][j]+water[i][j]*10);
      point(i*width/area,j*width/area);
    }
  }
  text(totalwater,0,20);
  text(totaltop,0,40);
}
