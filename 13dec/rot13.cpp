#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;
char rot13(char a){
    char b;
    if (a > 64 && a < 91){//uppercase
        if (a <= 76){
            b = a + 13;
        }
        else{
            b = a - 13;
        }
        return b;
    }
    else if(a>96&&a<123){//lower case
        if (a < 108){
            b = a + 13;
        }
        else{
            b = a - 13;
        }
    }
    else{//not a letter
        return a;
    }
}
int main(void){
    ifstream fin;
    ofstream fout;
    fin.open("secretMessage.txt");
    fout.open("decodedMessage.txt");
    char a;
    
    while (!fin.eof()){
        fin.get(a);
        
        fout << rot13(a);
    }
    return 0;
}
