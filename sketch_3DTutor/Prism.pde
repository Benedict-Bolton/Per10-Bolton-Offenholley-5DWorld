public class Prism {
  Vertex _start;
  Vertex _end;
  int numPoints;
  int[] fill;
  float[] rotations;
  int[] stroke;
  
  Prism () {
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
    
  
  
  Prism (int fill1, int fill2, int fill3, float roteX, float roteY, float roteZ, int stroke1, int stroke2, int stroke3) {
    fill = new int[3];
    fill[0] = fill1;
    fill[1] = fill2;
    fill[2] = fill3;
    rotations = new float[3];
    rotations[0] = roteX;
    rotations[1] = roteY;
    rotations[2] = roteZ;
    stroke = new int[3];
    stroke[0] = stroke1;
    stroke[1] = stroke2;
    stroke[2] = stroke3;
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
  
  void makePrism () {
    if (fill[0] < 0) {
      //noFill();
    }
    else {
      //fill( fill[0], fill[1], fill[2]);
    }
    rotateX(rotations[0]);
    rotateY(rotations[1]);
    rotateZ(rotations[2]);
    stroke(stroke[0], stroke[1], stroke[2]);
    Vertex hold = _start.getNext();
    beginShape(TRIANGLES);
    int count = 0;
    while (hold != null) {
       if ((count%3) == 0) {
         fill( fill[0], fill[1], fill[2]);
       }
       vertex(hold.getX(), hold.getY(), hold.getZ());
       //println (hold.getX() + ", " + hold.getY() + ", " + hold.getZ());
       hold = hold.getNext();
    }
    endShape(CLOSE);
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
   
}
