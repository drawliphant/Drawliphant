void setup(){
  size(1000,1000);
}
  int max=1000;
  int iteration;
  double c_re;
  double c_im;
  double x;
  double y;
  double x_new;
  float x1=-1.5;
  float y1=-2;
  float x2=1.5;
  float y2=1;
  float x3;
  float y3;
void mousePressed(){
  x3=x1+(x2-x1)*mouseX/width;
  y3=y1+(y2-y1)*mouseY/height;
  //redraw();
}
void mouseReleased(){
  x2=x1+(x2-x1)*mouseX/width;
  y2=y1+(y2-y1)*mouseY/height;
  y1=y3;
  x1=x3;
  y2=y1+(x2-x1);
  
  redraw();
}
void draw(){
  background(0);
  colorMode(HSB,200);
  float w=(x2-x1)/width;
  float h=(y2-y1)/height;
  int why=0;
  
  for (float row = y1; row < y2; row+=h) {
    why++;
    int ex=0;
    for (float col = x1; col < x2; col+=w) {
      ex++;
        c_re=row;
        c_im =col;
        x = 0;
        y = 0;
        iteration = 0;
        while (x*x+y*y <= 4 && iteration < max) {
            x_new = x*x - y*y + c_re;
            y = 2*x*y + c_im;
            x = x_new;
            iteration++;
        }
        if (iteration < max){
          stroke(iteration%200,200,200);
          //print(iteration);
          point(ex, why);
        }
        else{
          stroke(0,0,0);
          point(ex, why);
        }
    }
}
  noLoop();
}
