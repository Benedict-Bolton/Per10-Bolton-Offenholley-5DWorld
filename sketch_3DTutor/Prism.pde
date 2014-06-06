public class Prism implements Polyhedra{
  Vertex _start;
  Vertex _end;
  int numPoints;
  int[] fill;
  float[] rotations;
  int[] stroke;
  String name;
  
  int bSN;
  int cirCumRad;
  int leng;
  
  String getName () {
    return name;
  }
  
  Prism () {
    bSN = 4;
    cirCumRad = 50;
    leng = 50;
    name = "Custom Prism";
    fill = new int[3];
    fill[0] = -1;
    rotations = new float[3];
    for (int x = 0; x < rotations.length; x++) {
        rotations[x] = 0;
    } 
    stroke = new int[3];
    for (int x = 0; x < stroke.length; x++) {
        stroke[x] = 255;
    }
    _start = new Vertex();
    _end = new Vertex(); 
  }
    
  
  
  Prism (int baseSides, int cirCR, int lengOP ,int fillR, int fillG, int fillB, int strokeR, int strokeG, int strokeB) {
    bSN = baseSides;
    cirCumRad = cirCR;
    leng = lengOP;
    name = "Custom Prism";
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
  }
  
  float getZOne() {
    return _start.getNext().getZ();
  }
  
  int getNumPoints () {
    return numPoints;
  }
  
  void makeShape (rotX, rotY, rotZ, tranX, tranY, tranZ) {
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
    for ( float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), 0);
    }
    for ( float theta = 0; theta <= 2*PI; theta += (2*PI/bSN) ) {
      this.add( (cirCumRad) * (cos(theta)), (cirCumRad) * (sin(theta)), (-1*leng) );
    }
  }
      
   
}
