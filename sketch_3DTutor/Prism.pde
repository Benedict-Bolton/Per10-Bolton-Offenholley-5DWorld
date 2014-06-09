public class Prism implements Polyhedra {
  Vertex _start; //The linked list structure here may seem arbitrary but in fact gives a TAD bit of efficiency to the Polyhedra
  Vertex _end;   //for with an array its size would have to be managed, resulting in extra code and time spent in resizing
  int numPoints; //since adding to the end of the List is functionally exclusively add(float,float,float) it maintains O(1) time, while in an array it 
                 //would be slightly higher with b/c of the occasional resizing, and both take O(n) to make a shape as regardless every element must be visited once.
                 //Thus Linked List does provide a slight degree of efficiency, while also letting the code itself be a tad cleaner thanks to no indices needing to be tracked. 
                 //It is recognized this is a small (almost personal) benefit, but are we not to enjoy the little things in Life?
  
  int[] fill; //rgb values for fill(int,int,int);
  int[] stroke; //rgb values for stroke(int,int,int);
  
  
  float rotX; float rotY; float rotZ;//x,y,&z rotations
  
  int tranX; int tranY; int tranZ; //x,y,&z vals for translation method
  
  String name;
  
  int bSN; //number of sides of base
  int cirCumRad; //circum radius of base
  int leng; //length of prism on z axis
  
  String getName () {
    return name;
  }
<<<<<<< HEAD
  String toString () {
    return name;
  }
=======
  
  float getCynRad() {
    return cirCumRad;
  }
  float getCynHei() {
    return leng;
  }
  int[] getTrans(){
    int[] out = new int[3];
    out[0] = tranX;
    out[1] = tranY;
    out[2] = tranZ;
    return out;
  }
  
>>>>>>> 05b943ee6a9d93137a74be86760b3bb4125a0ae1
  Prism () {
    bSN = 4;
    cirCumRad = 50;
    leng = 50;
    name = "";
    fill = new int[3];
    fill[0] = -1;
    stroke = new int[3];
    for (int x = 0; x < stroke.length; x++) {
        stroke[x] = 255;
    }
    numPoints = 0;
    _start = new Vertex();
    _end = new Vertex(); 
  }
    
  
  
  //lengOP is the length Of the Prism, cirCR is the circum radius of the base of the prism, otherwise variable names should be self-explanatory
  //the letters correspond with those of RBGB
  // rota == rotation
  // trans == translation
  Prism (int baseSides, int cirCR, int lengOP, int fillR, int fillG, int fillB, int strokeR, int strokeG, int strokeB, float xRota, float yRota, float zRota, int xTrans, int yTrans, int zTrans) {     
    bSN = baseSides;
    cirCumRad = cirCR;
    leng = lengOP;
    name = "";
    rotX = xRota;
    rotY = yRota;
    rotZ = zRota;
    tranX = xTrans;
    tranY = yTrans;
    tranZ = zTrans;
    fill = new int[3];
    fill[0] = fillR;
    fill[1] = fillG;
    fill[2] = fillB;
    stroke = new int[3];
    stroke[0] = strokeR;
    stroke[1] = strokeG;
    stroke[2] = strokeB;
    numPoints = 0;
    _start = new Vertex();
    _end = new Vertex();
    formPoly();
  }
  
  float getZOne() {
    return _start.getNext().getZ();
  }
  
  int getNumPoints () {
    return numPoints;
  }
  
  void makeShape () {
    pushMatrix();
    translate(tranX, tranY, tranZ);
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    if (fill[0] < 0) {
      noFill();
    }
    else {
      fill( fill[0], fill[1], fill[2]);
    }
    if (stroke[0] < 0) {
      noStroke();
    }
    else {
      stroke(stroke[0], stroke[1], stroke[2]);
    }
    Vertex hold = _start.getNext();
    beginShape(QUAD_STRIP);
    int count = 0;
    while (hold != null) {
       vertex(hold.getX(), hold.getY(), hold.getZ());
       //println (hold.getX() + ", " + hold.getY() + ", " + hold.getZ());
       hold = hold.getNext();
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  public Vertex getVert (int position) {
    Vertex tmp = new Vertex();
    tmp.setNext(_start);
    //System.out.println(tmp.getNext());
    for (int x = -1; x < position; x++) {
        tmp.setNext((tmp.getNext()).getNext());
    }
    return tmp.getNext();
  }
  
  void add (float x, float y, float z, int position) {
    name=name+""+x+","+y+","+z+",";
    Vertex newOne = new Vertex (x, y, z);
    if (numPoints == 0) {
       _start.setNext(newOne);
       _end = newOne;
    }
    else if (position != numPoints) {
        newOne.setNext(getVert(position));
    }
    else {
        _end = newOne;
    }
    getVert(position - 1).setNext(newOne);
    numPoints++;
  }
  
  void add (float x, float y, float z) {
    name=name+""+x+","+y+","+z+",";
    Vertex newOne = new Vertex (x, y, z);
    if (numPoints == 0) {
      _start.setNext(newOne);
    }
    else {
      _end.setNext(newOne);
    }
    _end = newOne;
    numPoints++;
  }
  
  void remove (int position) {
    Vertex newSpo = getVert(position - 1);
    newSpo.setNext(newSpo.getNext().getNext());
    if (position == numPoints - 1) {
        _end = newSpo;
    }
    numPoints--;
  }
  
  void set (int position, float x, float y, float z) {
    getVert(position).setX(x);
    getVert(position).setY(y);
    getVert(position).setZ(z);
  } 
  
  
  //Many points have to be redrawn to create the desired shape due to how processing creates custom shapes with begin/endShape()
  //The need to redraw so many points results in the need for all the math
  //The math is serving to redraw the points in different orders so processing will fill all the spaces. (the exact equations vary based on the line pattern preffered on the faces)
  void formPoly() {
    for (float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0);
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
    }
    for ( float theta = 0; theta <= ( (2*PI) * 2*((bSN/2) + 1) ); theta += ( (2*PI/bSN) * ((bSN/2) + 1) ) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0 );
    }
    if (bSN% 2 == 1) {
      for ( float theta = (2*PI/bSN); theta <= ( ((2*PI) * ((bSN/2) + 1)) + 2*(2*PI/bSN) ); theta += ( (2*PI/bSN) * ((bSN/2) + 1) ) ) {
        this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0 );
      }
    }
    else {
      for (float theta = 0; theta <= ((2*PI) + (2*PI/bSN)); theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0);
      }
    }
    for ( float theta = 0; theta <= ( (2*PI) * ((bSN/2) + 1) ); theta += ( (2*PI/bSN) * ((bSN/2) + 1) ) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
    }
    if (bSN%2 == 1) { 
      for ( float theta = (2*PI/bSN); theta <= ( ((2*PI) * ((bSN/2) + 1)) + 2*(2*PI/bSN) ); theta += ( (2*PI/bSN) * ((bSN/2) + 1) ) ) {
        this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
      }
    }
    else {
      for (float theta = 0; theta <= ((2*PI) + (2*PI/bSN)); theta += (2*PI/bSN) ) {
        this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
      }
    }
    
  }
      
   
}
