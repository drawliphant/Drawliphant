class Vert{
  float x,y,z=0;
  Vert(float x1,float y1,float z1){
    x=x1;
    y=y1;
    z=z1;
  }
}
class Face{
  int[] face;
  Face(int[] f){
    face=f;
  }
}
class mesh{
  String line;
  int zoom=20;
  ArrayList<Vert> v=new ArrayList();
  ArrayList<Face> f=new ArrayList();
  
  mesh(float tx,float ty,float tz,String[] lines){
    
    Vert center=new Vert(0,0,0);
    v.add(center);
    //int p=lines.length;
    for(int h=0;h<lines.length;h++){
      //try{
      line=lines[h];
      //} catch(IOException e){
      //  println("BOO!");
      //  break;
      //}  
        if (line==null){
          break;
        }else {
          String[] words=line.split(" ");
          if(words[0].equals("v")){
            float x=Float.parseFloat(words[1]);
            //print(x+' ');
            float y=Float.parseFloat(words[2]);
            //print(y+' ');
            float z=Float.parseFloat(words[3]);
            //print(z);
            //println();
            Vert vertex=new Vert(x,y,z);
            v.add(vertex);
          }
          else if(words[0].equals("f")){
            int[] face=new int[words.length-1];
            for(int i=1;i<words.length;i++){
              face[i-1]=Integer.parseInt(words[i]);
              //print(face[i-1]);
            }
            //println();
            Face shape =new Face(face);
            f.add(shape);
          }else{
            //println("i read a comment");
          }
        }
    }
    //try{
    //reader.close();
    //}catch(IOException e){
      //println("memory leak: file failed to close");
    //}
    trans(tx,ty,tz);
  }
  void rotatex(float t){
    
    for(int i=0;i<v.size();i++){
      Vert old=new Vert(v.get(i).x-v.get(0).x,v.get(i).y,v.get(i).z-v.get(0).z);
      Vert n=new Vert(old.x*cos(t)+old.z*sin(t)+v.get(0).x,old.y,-old.x*sin(t)+old.z*cos(t)+v.get(0).z);
      v.set(i,n);
    }
    
  }
  void rotatey(float t){
    
    for(int i=0;i<v.size();i++){
      Vert old=new Vert(v.get(i).x,v.get(i).y-v.get(0).y,v.get(i).z-v.get(0).z);
      Vert n=new Vert(old.x,old.y*cos(t)+old.z*sin(t)+v.get(0).y,-old.y*sin(t)+old.z*cos(t)+v.get(0).z);
      v.set(i,n);
    }
    
  }
  void trans(float x, float y,float z){
    for(int i=0;i<v.size();i++){
      Vert hold=new Vert(v.get(i).x+x,v.get(i).y+y,v.get(i).z+z);
      v.set(i,hold);
    }
    
  }
  void draws(){
    stroke(255);
    for(int i=0;i<f.size();i++){
      int vpf=f.get(i).face.length;
      for(int j=0;j<vpf-1;j++){
        float cz=v.get(f.get(i).face[j]).z/zoom;
        float x1=v.get(f.get(i).face[j]).x/cz;
        float y1=v.get(f.get(i).face[j]).y/cz;
        float x2;
        float y2;
        if(j<vpf){
          float nz=v.get(f.get(i).face[j+1]).z/zoom;
          x2=v.get(f.get(i).face[j+1]).x/nz;
          y2=v.get(f.get(i).face[j+1]).y/nz;
        }else{
          float nz=v.get(f.get(i).face[0]-1).z/zoom;
          x2=v.get(f.get(i).face[0]).x/nz;
          y2=v.get(f.get(i).face[0]).y/nz;
        }
        if(cz>0.1&&cz>0.1){
          line(x1*zoom,-y1*zoom,x2*zoom,-y2*zoom);
        }
      }
    }
  }
}