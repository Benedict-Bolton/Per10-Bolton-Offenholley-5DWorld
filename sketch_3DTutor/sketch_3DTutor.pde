import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;



private ControlP5 cp5;

ControlFrame cf;

float x,y,z;

String userInput;
String[] savedInput;

int[] dimensions;

int countInp;

int incep;

ArrayList<Prism> shapes;


void setup() {
    dimensions = new int[3];
    shapes = new ArrayList<Prism>();
    
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
    frame.setLocation(500, 100);
    
    cp5 = new ControlP5(this);
    
    cf = addControlFrame("select", 300, 400);
    
    translate(width/2, height/2, -100);
    //stroke(255);
    //rotateX(PI/2);
    //rotateZ(-PI/6);
    //noFill();
    fill(204, 102, 0);
    
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
    shapes.add(testy);
    //rect(0, 0, 100, 100);
    pushMatrix();
    rotateZ(PI/3);
    rotateX(PI/6);
    box(50);
    popMatrix(); //so the fill is not cooperating at the moment for filling custom shapes....may Mr.K please have an answer...
    //GWindow shaInp = new GWindow(this, "shapeChoice", 0, 0, 100, 100, false, "P2D");
}

void draw() {
  translate(width/2, height/2, -100);
  background(incep);
  shapes.get(0).makePrism();
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
  
  ControlP5 cp5;
  
  Object parent;
  
  
  public void setup() {
    background(100);
    size(_width, _height);
    frameRate(30);
    cp5 = new ControlP5(this);
    shaSel = cp5.addDropdownList("Polyhedra").setPosition(10,200);
    dropDownDesign(shaSel); //add all necessary details to shaSel
    cp5.addSlider("SNAFU").plugTo(parent,"incep").setRange(0,255).setPosition(10,30); //need to set up one of these for text fields
  }
  
  public void draw() {
    background(200);
  }
  
  private ControlFrame() {
    //hmm, this is kinda pointless, who knows what it may be needed for???
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
    ddl.captionLabel().set("Select the Polyhedra you wish to create");
    ddl.captionLabel().style().marginTop = 4; //positioning of top label
    ddl.captionLabel().style().marginLeft = 3; //positioning of top label
    ddl.valueLabel().style().marginTop = 3; //same as above just for the items in the ddl
    /* Ref for numbers, they are indices in 2D array holding what to call.
    First digit is the row, which corrsponds to the type of shape; i.e. prism, pyrimid, etc.
      --this number will be extracted by %10-ing the number so single digits pose no problem
    Second digit is the colomn, it is sorted according to number of sides of defining face; i.e. 4 == a rect
    The First two colomns will be empty and should never be called */  
    ddl.addItem("Prism, Rect.", 4); 
    ddl.addItem("Prism, Tri.", 3);
    ddl.addItem("Prism, Pent.", 5);
    ddl.setColorBackground(color(100));
    ddl.setColorActive(color(2, 255, 181));
  }
  
  void controlEvent(ControlEvent event) {
    
    if (event.isGroup()) {
      println("Num sides wanted: " + event.getGroup().getValue());
    }
    else if (event.isController()) {
    }
  }
  
}
  
  
  
  
  
  
