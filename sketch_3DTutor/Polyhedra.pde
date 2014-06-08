public interface Polyhedra {
  
  String getName();
  float getCynRad();//used to define an cylinder,cone,sphere for collision purposes
  float getCynHei();//used to define an cylinder,cone for collision purposes
  int[] getTrans();//used to define an cylinder,cone,sphere for collision purposes
  
  void makeShape();
  void formPoly();
  
  void add (float x, float y, float z);
  
} 
