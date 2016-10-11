void setup(){
  size(1920,1080);
}
  int max=50;
  int iteration;
  double c_re;
  double c_im;
  double x;
  double y;
  double x_new;

void draw(){
  colorMode(HSB,100);
  for (int row = 0; row < height; row++) {
    for (int col = 0; col < width; col++) {
        c_re= (col - width/2.0)*4.0/width;
        c_im = (row - height/2.0)*4.0/width;
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
          stroke(iteration*2,50,50);
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