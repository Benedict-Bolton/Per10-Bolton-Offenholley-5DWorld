public class Prism {
  Vertex _start;
  Vertex _end;
  int numPoints;
  
  int[] fill; //rgb values for fill(int,int,int);
  int[] stroke; //rgb values for stroke(int,int,int);
  
  
  float rotX; float rotY; float rotZ;//x,y,&z rotations
  
  int tranX; int tranY; int tranZ; //x,y,&z vals for translation method
  
  String name;
  
  int bSN; //number of sides of base
  int cirCumRad; //circum radius of base
  int leng; //length of prism on z axis
  
  /*String getName () {
    return name;
  }*/
  
  Prism () {
    bSN = 4;
    cirCumRad = 50;
    leng = 50;
    name = "Custom Prism";
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
    name = "Custom Prism";
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
    stroke(stroke[0], stroke[1], stroke[2]);
    Vertex hold = _start.getNext();
    beginShape();
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
   
  void formPoly() {
    for (float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0);
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
    }
    for ( float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0 );
    }
    for ( float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
    } 
  }
      
   
}
