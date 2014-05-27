class Prism {
  Vertex _start;
  Vertex _end;
  int numPoints;
  
  Prism (Vertex start) {
    numPoints = 0;
    _start = new Vertex();
    _end = new Vertex();
  }
  
  int getNumPoints () {
    return numPoints;
  }
  
  void makePrism () {
    Vertex hold = _start;
    beginShape();
    while (hold.getNext() != null) {
       vertex(hold.getX(), hold.getY(), hold.getZ());
       hold = hold.getNext();
    }
    endShape();
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
    if (position != numPoints) {
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
    _end.setNext(newOne);
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
