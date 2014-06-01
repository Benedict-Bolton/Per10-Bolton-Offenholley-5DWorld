 
int concentration = 600; // Try values 1 -> 10000

void setup() 
{
  //size(200, 200, P3D);
  size(640, 360, P3D);
  noStroke();
  fill(204);
  sphereDetail(60);
}

void draw() 
{
  background(0); 
  
  
  
  // Moving spotlight that follows the mouse
  if (mousePressed){
    spotLight(102, 153, 204, mouseX, mouseY, 600, 0, 0, -1, PI/2, 600); 
  }
  camera(width/2, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, 0); 
  
}


