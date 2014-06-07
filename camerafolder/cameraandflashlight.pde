 
int concentration = 600;
boolean FL;
boolean held;
char kp;
int forward;
int right;
int zvar;
void setup() 
{
  //size(200, 200, P3D);
  size(640, 360, P3D);
  noStroke();
  fill(204);
  sphereDetail(60);
}

void draw() 
{
  background(1); 
  
  
  
  // Turns flashlight on and off
  if (keyPressed && !held) {
    held=true;
    if (key == 'f' || key == 'F') {
      FL=!FL; 
      kp='f';
      
    }
    if (key == 'w' || key == 'W') {
      kp='w';
      
    }
    if (key == 'a' || key == 'A') {
      kp='a';
      
    }
    if (key == 's' || key == 'S') {
      kp='s';
      
    }
    if (key == 'd' || key == 'D') {
      kp='d';
      
    }
    if (key == 'z' || key == 'Z') {
      kp='z';
      
    }
    if (key == 'x' || key == 'X') {
      kp='x';
      
    }
  }
  if (!keyPressed){
     held=false;
  }
  if (held){
    if (kp=='w'){
      //do forward stuff. will work with other commands once
      //we figure out grid stuff
      forward+=10;
      
    }
    if (kp=='a'){
      //do left stuff. will work with other commands once
      //we figure out grid stuff
      right+=10;
    }
    if (kp=='s'){
      //do backward stuff. will work with other commands once
      //we figure out grid stuff
      forward-=10;
    }
    if (kp=='d'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      right-=10;
    }
    if (kp=='z'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      zvar-=10;
    }
    if (kp=='x'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      zvar+=10;
    }
  }

  //Because processing can't detect two keys at once.
  if (FL){
    
    spotLight(102, 153, 204, mouseX, mouseY, 600, 0, 0, -1, PI/2, 50);
  }
  camera((width/2)-right, (height/2)-zvar, ((height/2) / tan(PI/6))-forward, mouseX-right, mouseY-zvar, 0-forward, 0, 1, 0);
  translate(width/2, height/2, 0); 
  //Light tester to avoid glitch:
  //spotLight(102, 153, 204, 1, 1, 600, 0, 0, -1, PI/2, 500);
  ambientLight(128, 128, 500);
  box(200);
}


