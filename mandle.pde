void setup(){
  size(800,500);
}
  int max=100;
  int iteration;
  double c_re;
  double c_im;
  double x;
  double y;
  double x_new;
  float zoom=4;
  float xshift=2;
  float yshift=2;
void mousePressed(){
  zoom/=2;
  xshift/=2-zoom*mouseX/width;
  yshift/=2-zoom*mouseY/height;
  redraw();
}
void draw(){
  background(0);
  colorMode(HSB,100);
  for (int row = 0; row < height; row++) {
    for (int col = 0; col < width; col++) {
        c_re= (col - width/xshift)*zoom/width;
        c_im = (row - height/yshift)*zoom/width;
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
          stroke(iteration*10%100,50,50);
          point(col, row);
        }
        else{
          stroke(0,0,0);
          point(col, row);
        }
    }
}
  noLoop();
}