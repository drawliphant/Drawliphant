
class letter{//holds all the data and functions you can perform on a letter
  char me;//this letter's name
  char[] spawns;//the trees it will spawn
  float angle;//holds angle the branch will come out with
  float lenth;//the lenth of this branch
  letter(char name, char[] sp,float angl,float len){//constructor
    me=name;
    spawns=sp;
    angle=angl;
    lenth=len;
  }
  PVector branch (PVector start,int level){//draw a branch using x,y,angle. returns new x,y,angle
    PVector end=new PVector();
    end.x=start.x+cos(start.z)*lenth*level/10;
    end.y=start.y+sin(start.z)*lenth*level/10;
    end.z=start.z+angle;
    strokeWeight(pow(1.3,level));
    line(start.x,start.y,end.x,end.y);
    return end;
  }

  void tree(float x,float y,float angle,int level,ArrayList<letter> alphabet){//recursive tree builder
    
    if(level>0){
      PVector goes=new PVector(0,0,0);
      PVector from=new PVector(x,y,angle);
      goes=branch(from,level);
      for(int i=0;i<spawns.length;i++){
        for(int j=0;j<alphabet.size();j++){
          if(alphabet.get(j).me==spawns[i]){
            letter hi=alphabet.get(i);
            text(hi.me,x,y);
            hi.tree(goes.x,goes.y,goes.z,level-1,alphabet);
          }
        }
      }
    }else{
      //fill(0,255,0);
      //ellipse(x,y,10,10);
    }
  }
}
boolean spawn=true;
void mousePressed(){
  redraw();
  
}
void setup(){
  size(1920,1080);
  noLoop();
  fill(0,255,0);
}



void draw(){
  background(255);
  ArrayList<letter> alphabet=new ArrayList();{//define your alphabet
    char[] spawns1={'n','m'};
    alphabet.add(new letter('l',spawns1,random(0,.7),random(50,200)));
    char[] spawns2={'l','o'};
    alphabet.add(new letter('m',spawns2,random(-.7,.7),random(50,200)));
    char[] spawns4={'n','l'};
    alphabet.add(new letter('o',spawns4,random(-.7,0),random(50,200)));
    char[] spawns3={'m','o'};
    alphabet.add(new letter('n',spawns3,random(0,.7),random(50,200)));
  }
  letter l=alphabet.get(0);//start with this letter
  l.tree(width/2,height,-PI/2,13,alphabet);//make your tree and set its root value
}