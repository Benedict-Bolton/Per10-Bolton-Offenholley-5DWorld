float x,y,z;

String userInput;
String[] savedInput;
int countInp;


void setup() {
  
    savedInput = new String[4];
    countInp = 0;
    /*size(640,360,P3D);
    background(0);
    lights();
    
    pushMatrix();
    translate(130, height/2, 0);
    rotateY(1.25);
    rotateX(-0.4);
    noStroke();
    box(100);
    popMatrix(); 
    
    pushMatrix();
    translate(500, height*0.35, -200);
    noFill();
    stroke(255);
    sphere(280);
    popMatrix();*/
    size(640, 360, P3D);
    background(0);
    
    translate(width/2, height/2, 0);
    stroke(255);
    rotateX(PI/2);
    rotateZ(-PI/6);
    noFill();
    
    beginShape();
    vertex(-100, -100, -100);
    vertex( 100, -100, -100);
    vertex(   0,    0,  100);
    
    vertex( 100, -100, -100);
    vertex( 100,  100, -100);
    vertex(   0,    0,  100);
    
    vertex( 100, 100, -100);
    vertex(-100, 100, -100);
    vertex(   0,   0,  100);
    
    vertex(-100,  100, -100);
    vertex(-100, -100, -100);
    vertex(   0,    0,  100);
    endShape();
}

void draw() {

}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    savedInput[countInp] = userInput;
    userInput = "";
    if (countInp < savedInput.length - 1) {
      countInp++;
    }
    else {
      countInp = 0;
    }
  }
  else if (key == BACKSPACE) {
    userInput = userInput.substring(0, length-1);
  }
  else {
    userInput +=key;
  }
}

