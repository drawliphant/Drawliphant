
void setup(){
  size(1920,1080);
}

void draw(){
  
}

class Node{
  
  float[] w;
  
  Node(int inputs){//constructor parameters: number of inputs
    w=new float[inputs];
    float h;
    for(int i=0;i<inputs;i++){
      while(abs(w[i]=randomGaussian()/2)>=1){}//while the gaussian is outside +-1 retry
    }
  }
  Node(float[] weights){
    w=weights;
    
  }
  Node(){
    
  }
  
  float run(float[] inputs){//gets an output from the node
    float out=0;
    int l=inputs.length;
    for(int i=0;i<l;i++){
      out+=inputs[i]*w[i];
    }
    return sigmoid(out);
  }
  Node breed(Node mate,float dominance){
    float[] others=mate.getWeights();
    float[] child=new float[others.length];
    for(int i=0;i<w.length;i++){
      float ave=w[i]*dominance+others[i]*(1-dominance);
      child[i]=ave+random((-1+abs(ave))/8,(1-abs(ave))/8);
    }
    return new Node(child);
  }
  
  float[] getWeights(){
    return w;
  }
  private float sigmoid(float in){
    in/=2;
    return in/(1+abs(in));
  }
}

class Layer{
  Node[] nodes;
  int count;
  Layer(int nodeCount,int inputs){
    count=nodeCount;
    nodes=new Node[nodeCount];
    for(int i=0;i<nodeCount;i++){
      nodes[i]=new Node(inputs);
    }
  }
  Layer(){
    
  }
  float[] run(float[] inputs){
    float[] out=new float[count];
    for(int i=0;i<count;i++){
      out[i]=nodes[i].run(inputs);
    }
    return out;
  }
  
  
}
class Network{
  Layer[] layers;
  Network(int inputs, int lay, int high, int outputs){
    layers=new Layer[lay+1];
    layers[lay]=new Layer(high,inputs);
    for(int i=1;i<lay;i++){
      layers[i]=new Layer(outputs,high);
    }
    layers[lay]=new Layer(outputs,high);
  }
}