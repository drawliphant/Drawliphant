
//int oldmouseX=mouseX;
//int oldmouseY=mouseY;
//String tlines[];
//BufferedReader tpot;
String[] octo;
String[] tlines;
//mesh octogon;
void setup(){
  //tpot=createReader("teapot.txt");
  
  size(700,700,P2D);
  octo=loadStrings("octo.obj");
  print(octo[0]);
  tlines=loadStrings("teapot.obj");
  
}


void draw(){
  //mesh teapot=new mesh(0,0,10,tlines);
  mesh octogon=new mesh(sin(float(frameCount)/31),sin(float(frameCount)/35),sin(float(frameCount)/20)*5+2,tlines);
  //println(tlines.length);
  background(0);
  translate(width/2,height/2);
  //teapot.rotatex(cos(float(frameCount)/11)/2-0.1);
  //teapot.trans(cos(float(frameCount)/20),cos(float(frameCount+5)/13),cos(float(frameCount+5)/15));
  //teapot.rotatey(sin(float(frameCount)/7)/2+0.1);
  //teapot.draws();
  octogon.rotatex(float(frameCount)/15);
  octogon.rotatey(float(frameCount)/20);
  octogon.draws();
  
}