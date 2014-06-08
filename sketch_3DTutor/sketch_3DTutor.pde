import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.io.*;


private ControlP5 cp5;

ControlFrame cf;

float x,y,z;

//int tZ;
float drot;
//base == number of sides of the base
//leng == length of prism
//cCR == circum radius of Prism
int base, cCR, leng;
boolean FL;
boolean held;
char kp;
int forward;
int right;
int zvar;

float cenX;
float cenY;



String userInput;
String[] savedInput;

public int[] ddlPick = new int[2]; //ddlPick[0] == 1 || 0 for make shape or not, ddlPick[1]

int countInp;

int incep;

ArrayList<Polyhedra> shapes;
CollisionData polys;
boolean canMove = true;

//the fill values to be used for all called polyhedra constructors
int[] currFill = new int[3];
//the stroke values to be used for all called polyhedra constructors
int[] currStroke = new int[3];
//the rotation values to be used for all called polyhedra constructors
float rotX, rotY, rotZ;
//the translation values to be used for all called polyhedra constructors (not utilized)
int[] currTrans = new int[3];


static Polyhedra[][] PSHAPECALLS = new Polyhedra[2][4];

void appendToFile(String filename, String text){
  BufferedReader rd = null;
  String line="";
        try {

            // Open the file for reading.

            rd = new BufferedReader(new FileReader(new File(filename)));

             

            // Read all contents of the file.

            String inputLine = null;
      
            while((inputLine = rd.readLine()) != null)

                line+=inputLine;

        }

        catch(IOException ex) {

            System.err.println("An IOException was caught!");

            ex.printStackTrace();

        }

        finally {

            // Close the file.

            try {

                rd.close();

            }

            catch (IOException ex) {

                System.err.println("An IOException was caught!");

                ex.printStackTrace();

            }

        }

    

  Writer writer=null;
  try{
    writer=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filename), "utf-8"));
    writer.write(line+text);
  }catch (IOException ex){

  } finally{
    try{writer.close();} catch (Exception ex){}
  }
}
String readFile(String filename){
  BufferedReader rd = null;
  String line="";
        try {

            // Open the file for reading.

            rd = new BufferedReader(new FileReader(new File(filename)));

             

            // Read all contents of the file.

            String inputLine = null;
      
            while((inputLine = rd.readLine()) != null)

                line+=inputLine;

        }

        catch(IOException ex) {

            System.err.println("An IOException was caught!");

            ex.printStackTrace();

        }

        finally {

            // Close the file.

            try {

                rd.close();

            }

            catch (IOException ex) {

                System.err.println("An IOException was caught!");

                ex.printStackTrace();

            }

        }
        return line;
}
void writeFile(String filename, String text){
  
  Writer writer=null;
  try{
    writer=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filename), "utf-8"));
    writer.write(text);
  }catch (IOException ex){

  } finally{
    try{writer.close();} catch (Exception ex){}
  }
}
void setup() {
    //testing to make sure quicksort works with float 2D arrays
    /*float[][] nerv = { {7.4, 8.2, 9.9901,3.0000}, {3.1200078, 6.78, 1.01, 10.5}, {5.890, 2.10, 63.00}, {3.1200088, 777.777}};
    Sorts.quicksort(nerv);
    for (int r = 0; r < nerv.length; r++) {
      for (int c = 0; c < nerv[r].length; c++) {
        print(nerv[r][c] + ",");
      }
      print("\n");
    }*/
    shapes = new ArrayList<Polyhedra>();
    currFill[0] = -10;
    currStroke[0] = -10;
    ddlPick[0] = -1;
    //tZ = -100;
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
    incep = 0;
    size(640, 360, P3D);
    background(incep);
    frame.setLocation(700, 100);
    
    cp5 = new ControlP5(this);
    
    cf = addControlFrame("Select", 500, 600);
    
    translate(width/2, height/2, 0);
    //stroke(255);
    //rotateX(PI/2);
    //rotateZ(-PI/6);
    //noFill();
    fill(204, 102, 0);
    
    //                      Dimensions   Fill         Stroke         Rotation Translation
    Prism testy = new Prism (6,50,100,   204,102,0,   255,255,255,   0,0,0,   0,0,0);
    
    /*testy.add(-100, -100, -100);
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
    testy.add(   0,    0,  100);*/ 
    //testy.add(-100, -100, -100);        //ooh look at all the pretty test lines!
    //testy.add(  100, 0, -100);
    //testy.add(-100, -100, -100);
    //testy.add(  0, 100, -100);
    //testy.add(-100, -100, -100);
    //testy.add(  0, 0, -100);
    //testy.add(-100, -100, -100);
    
    testy.makeShape();
    shapes.add(testy);
    polys = new CollisionData(shapes);
    //rect(0, 0, 100, 100);
    /*pushMatrix();
    rotateZ(PI/3);
    rotateX(PI/6);
    box(50);
    popMatrix();*/ //so the fill is not cooperating at the moment for filling custom shapes....may Mr.K please have an answer...
    //GWindow shaInp = new GWindow(this, "shapeChoice", 0, 0, 100, 100, false, "P2D");
}

void draw() {
  //translate(width/2, height/2, 0);
  background(incep);
  pushMatrix();
  //rotateX(zTest);
  for (int x = 0; x <shapes.size(); x++) {
    shapes.get(x).makeShape();
  }
  //zTest+=PI/400;
  popMatrix();
  //tZ++;
  //println(shapes.get(0).getZOne());
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
    if (key == 'q' || key == 'Q') {
      kp='q';
      
    }
    if (key == 'e' || key == 'E') {
      kp='e';
      
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
      zvar+=10;
    }
    if (kp=='x'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      zvar-=10;
    }
    if (kp=='q'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      drot+=0.05;
    }
    if (kp=='e'){
      //do right stuff. will work with other commands once
      //we figure out grid stuff
      drot-=0.05;
    }
  }

  //Because processing can't detect two keys at once.
  if (FL){
    
    spotLight(102, 153, 204, mouseX, mouseY, 600, 0, 0, -1, PI/2, 50);
  }
  /*if (mousePressed == true) {
    camCenX = mouseX-right;
    camCenY = mouseY-zvar;
  }
  else if (held){
    camCenX = camCenX - right;
    camCenY = camCenY - zvar;
  }*/
  beginCamera();
  camera((width/2)-right, (height/2)-zvar, ((height/2) / tan(PI/6))-forward, mouseX-right, mouseY-zvar, 0-forward, 0, 1, 0);
  rotateY(drot);
  endCamera();
  //camera(mouseX-right, mouseY-zvar, 0-forward, (width/2)-right, (height/2)-zvar, ((height/2) / tan(PI/6))-forward, 0, 1, 0); 
  //Light tester to avoid glitch:
  //spotLight(102, 153, 204, 1, 1, 600, 0, 0, -1, PI/2, 500);
  ambientLight(128, 128, 500);
  if (mousePressed) {
    if (mouseX != cenX && mouseY != cenY) {
      if (ddlPick[0] != -1) {
        if (ddlPick[0] == 0) {
          Polyhedra newPoly = new Prism(base, cCR, leng, currFill[0], currFill[1], currFill[2], currStroke[0], currStroke[1], currStroke[2], rotX, rotY, rotZ, (width/2)-right, (height/2)-zvar, (int)((height/2) / tan(PI/6)-(forward+leng+50)) );
          shapes.add(newPoly);
          polys.addShape(newPoly);
          cenX = mouseX;
          cenY = mouseY;
        }
        else if (ddlPick[0] == 1) {
        }
      }
    }
  }
    
}

ControlFrame addControlFrame(String name, int wid, int hei) {
  Frame foo = new Frame(name);
  ControlFrame bar = new ControlFrame(this, wid, hei);
  foo.add(bar);
  bar.init();
  foo.setTitle(name); 
  foo.setSize(bar._width, bar._height);
  foo.setLocation(100, 100);
  foo.setResizable(false);
  foo.setVisible(true);
  return bar;
} 


public class ControlFrame extends PApplet {
  
  int _width;
  int _height;
  DropdownList shaSel;//shape selector
  Textfield fillSel;//fill selector
  Textfield strokeSel;//stroke selector
  Knob rotateX;
  Knob rotateY;
  Knob rotateZ;
  
  
  boolean makeShapeTime = false; 
  
  ControlP5 cp5;
  
  Object parent;
  
  
  public void setup() {
    background(180);
    size(_width, _height);
    frameRate(30);
    cp5 = new ControlP5(this);
    
    shaSel = cp5.addDropdownList("Polyhedra To Make:").setPosition(10,350);
    dropDownDesign(shaSel); //add all necessary details to shaSel
   
    cp5.addSlider("SNAFU").plugTo(parent,"incep").setRange(0,255).setPosition(10,33).setSize(150,13); //need to set up one of these for text fields
    cp5.addSlider("Base Radius").plugTo(parent,"cCR").setRange(10,200).setPosition(10,63).setSize(150,13);
    cp5.addSlider("Number of Sides of Base").plugTo(parent,"base").setRange(3,30).setPosition(10,93).setSize(150,13);
    cp5.addSlider("Height of Polyhedra").plugTo(parent,"leng").setRange(20,500).setPosition(10,123).setSize(150,13);
    
    fillSel = cp5.addTextfield("Enter values for Fill:").setPosition(10, 225).setSize(100,20);
    strokeSel = cp5.addTextfield("Enter values for Stroke:").setPosition(10, 265).setSize(100,20);
    
    rotateX = cp5.addKnob("Rotation Around X-Axis").setPosition(350,30).setColorBackground(color(0,160,100)).setColorForeground(color(255)).setColorActive(color(255,88,70));
    knobDesign(rotateX);
    rotateX.plugTo(parent,"rotX");
    rotateY = cp5.addKnob("Rotation Around Y-Axis").setPosition(350,150).setColorBackground(color(104,3,107)).setColorForeground(color(255)).setColorActive(color(255,243,0));
    knobDesign(rotateY);
    rotateY.plugTo(parent,"rotY");
    rotateZ = cp5.addKnob("Rotation Around Z-Axis").setPosition(350,270).setColorForeground(color(255)).setColorActive(color(255,172,46));
    knobDesign(rotateZ);
    rotateZ.plugTo(parent,"rotZ");
  }
  
  public void draw() {
    background(200);
    fill(0);
    text("Enter all values into text fields in the form: \"value1,value2,value3\" ;" + 
    "with value1/value 2/value3 being the numbers you wish to input. Use \"-1,-1,-1\" for noFill()/noStroke. Press Enter to input.", 10, 150, 250, 205);
  }
  
  private ControlFrame() {
    //hmm, this is kinda pointless, who knows what it may be needed for??? Only Andreas Schlegel knows...
  }
  
  public ControlFrame(Object patria, int wid, int hei) {
    parent = patria;
    _width = wid;
    _height = hei;
  }
  
  public ControlP5 control() {
    return cp5; //ugh...why cant libraries have better documentation
    //so i can know the purpose of more of this stuff...then again im
    //just writting comments not documenting so ehh i can understand them
  }    
  
  
  //pulls together all the messy method calls into one nice method
  void dropDownDesign(DropdownList ddl) {
    ddl.setItemHeight(25);
    ddl.setBarHeight(20);
    ddl.setWidth(200);
    ddl.captionLabel().set("Select a Polyhedra:");
    ddl.captionLabel().style().marginTop = 4; //positioning of top label
    ddl.captionLabel().style().marginLeft = 3; //positioning of top label
    ddl.valueLabel().style().marginTop = 3; //same as above just for the items in the ddl
    /* Ref for numbers, they are indices in 2D array holding what to call.
    First digit is the row, which corrsponds to the type of shape; i.e. prism, pyrimid, etc.
      --this number will be extracted by /10-ing the number so single digits pose no problem
    Second digit is the colomn, it is sorted according to number of sides of defining face; i.e. 4 == a rect
    The First two colomns will be empty and should never be called */  
    ddl.addItem("Prism, Tri.", 3);
    ddl.addItem("Prism, Rect.", 4); 
    ddl.addItem("Prism, Pent.", 5);
    ddl.setColorBackground(color(100));
    ddl.setColorActive(color(2, 255, 181));
  }
  
  //keeps all the customization methods in one place for cleanliness
  void knobDesign(Knob rkn) { 
    rkn.setDragDirection(Knob.HORIZONTAL);
    rkn.setRange(0,360);
    rkn.setRadius(40);
    rkn.setNumberOfTickMarks(48);
    rkn.snapToTickMarks(true);
    rkn.setTickMarkLength(7);
  }
  
  void controlEvent(ControlEvent event) {
    
    if (event.isGroup()) {
      if (event.getGroup().getName().equals("Polyhedra To Make:")) {
        println("Num sides wanted: " + event.getGroup().getValue());
        ddlPick[0] = (int) (event.getGroup().getValue()/10);
        println(ddlPick[0] + ""); 
        ddlPick[1] = (int) (event.getGroup().getValue()%10);
        println(ddlPick[1] + "");
      }  
    }
    else if (event.isController()) {
      if(event.isAssignableFrom(Textfield.class)) {
        String inp = "";
        int comInd1 = 0; //indices of the commas in inputed values for substring calls
        int comInd2 = 0;
        inp = event.getStringValue();
        inp = inp.trim();
        if (inp.substring(0,1).equals("\"")) {
          inp = inp.substring(1);
        }
        if (inp.substring((inp.length() - 1), inp.length()).equals("\"")) {
          inp = inp.substring(0,(inp.length()-1));
        }
        for (int ch = 0; ch < inp.length(); ch++) {
          if (inp.substring(ch,ch+1).equals(",")) {
            if (comInd1 == 0) {
              comInd1 = ch;
            }
            else {
              comInd2 = ch;
            }
          }
        }
        if(event.getController().getName().equals("Enter values for Fill:")) {
          println("New Inputed Fill Values: " + inp);
          currFill[0] = Integer.parseInt(inp.substring(0,comInd1));  //I realize these commands could be condense into a loop using two arrays,
          currFill[1] = Integer.parseInt(inp.substring(comInd1 + 1, comInd2)); //but considering that I would only have at most three values it did 
          currFill[2] = Integer.parseInt(inp.substring(comInd2 + 1, inp.length())); //not seem beneficial to condense considering # of lines to be written vs # of lines saved
          println(currFill[0] + "");
        }
        if(event.getController().getName().equals("Enter values for Stroke:")) {
          println("New Inputed Stroke Values: " + inp);
          currStroke[0] = Integer.parseInt(inp.substring(0,comInd1));  //I realize these commands could be condense into a loop using two arrays,
          currStroke[1] = Integer.parseInt(inp.substring(comInd1 + 1, comInd2)); //but considering that I would only have at most three values it did 
          currStroke[2] = Integer.parseInt(inp.substring(comInd2 + 1, inp.length())); //not seem beneficial to condense considering # of lines to be written vs # of lines saved
          println(currStroke[0] + ""); 
        }
      }//end if event.isAssignable
    } //end else if(event.isController())
  }//end controlEvent
  
}//ends ControlFrame
