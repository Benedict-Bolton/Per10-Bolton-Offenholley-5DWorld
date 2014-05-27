class Vertex {
  float xpos;
  float ypos;
  float zpos;
  Vertex _next;
  
  Vertex (float x, float y, float z) {
    xpos = x;
    ypos = y;
    zpos = z;
  }
  
  Vertex() {
    _next = null;
  }

  void setNext (Vertex next) {
      _next = next;
  }
  Vertex getNext () {
     return _next;
  }
  
  float getX () {
     return xpos;
  }
  void setX (float x) {
    xpos = x;
  }
  
  float getY () {
    return ypos;
  }
  void setY (float y) {
    ypos = y;
  }
  
  float getZ () {
    return zpos;
  }
  void setZ (float z) {
    zpos = z;
  }
  
}
