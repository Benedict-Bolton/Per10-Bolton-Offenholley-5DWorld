import g4p_controls.*;

float x,y,z;

String userInput;
String[] savedInput;
int countInp;


void setup() {
    
    userInput = "";
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
    //stroke(255);
    //rotateX(PI/2);
    //rotateZ(-PI/6);
    //noFill();
    //fill(204, 102, 0);
    
    Prism testy = new Prism (204, 102, 0, PI/2, 0, 0, 255, 255, 255);
    testy.add(-100, -100, -100);
    testy.add( 100, -100, -100);
    testy.add(   0,    0,  100);
    
    testy.add( 100, -100, -100);
    testy.add( 100,  100, -100);
    testy.add(   0,    0,  100);
    
    testy.add( 100, 100, -100);
    testy.add(-100, 100, -100);
    testy.add(   0,   0,  100);
    
    testy.add(-100,  100, -100);
    testy.add(-100, -100, -100);
    testy.add(   0,    0,  100); 
    //testy.add(-100, -100, -100);        //ooh look at all the pretty test lines!
    //testy.add(  100, 0, -100);
    //testy.add(-100, -100, -100);
    //testy.add(  0, 100, -100);
    //testy.add(-100, -100, -100);
    //testy.add(  0, 0, -100);
    //testy.add(-100, -100, -100);
    testy.makePrism();
    //rect(0, 0, 100, 100);
    pushMatrix();
    rotateZ(PI/3);
    rotateX(PI/6);
    box(50);
    popMatrix(); //so the fill is not cooperating at the moment for filling custom shapes....may Mr.K please have an answer...
    GWindow shaInp = new GWindow(this, "shapeChoice", 0, 0, 100, 100, false, "P2D");
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
    userInput = userInput.substring(0, userInput.length() - 1);
  }
  else {
    userInput +=key;
  }
}

