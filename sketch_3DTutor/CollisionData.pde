class CollisionData {
  
  //woot for trying to understand math's far beyond what i've learned....
  //well proto-collision is still something (will outline who this would develop into real collision in presentation)
  
  float[][] xVals;
  float[][] yVals;
  float[][] zVals;
  
  int fin;
  
  //float[] userCoor = new float[3];
  
  
  CollisionData () {
    xVals = new float[10][2];
    yVals = new float[10][2];
    zVals = new float[10][2];
    //for (int c =0; c < userCoor.length; c++) { userCoor[c] = 0;}
    fin = 0;
  }
  
  CollisionData(ArrayList<Polyhedra> polies ) {            //float[] uLoc
    xVals = new float[20][2];
    yVals = new float[20][2];
    zVals = new float[20][2];
    for (int e = 0; e < polies.size(); e++) {
      int[] inps = polies.get(e).getTrans();
      xVals[e][0] = inps[0];
      xVals[e][1] = e;
      yVals[e][0] = inps[1];
      yVals[e][1] = e;
      zVals[e][0] = inps[2] - (0.5 * polies.get(e).getCynHei());
      zVals[e][1] = e;
    }
    fin = polies.size();
    //for (int c =0; c < userCoor.length; c++) { userCoor[c] = uLoc[c];}
    Sorts.quicksort(xVals);
    Sorts.quicksort(yVals);
    Sorts.quicksort(zVals);
  }
  
  void addShape(Polyhedra newSha) {
      resize();
      int[] inps = newSha.getTrans();
      xVals[fin][0] = inps[0];
      xVals[fin][1] = fin;
      yVals[fin][0] = inps[1];
      yVals[fin][1] = fin;
      zVals[fin][0] = (inps[2] - (0.5 *newSha.getCynHei()));
      zVals[fin][1] = fin;   
      fin++;
      Sorts.quicksort(xVals);
      Sorts.quicksort(yVals);
      Sorts.quicksort(zVals);
  }
  
  //The polyhedra are indexed by the order they were created, and are removed with this index
  //Runtime is sacrificed here (it is O(n)) in order the searching for coordinates in collision
  //(which will be occuring every draw cycle, much more often than remove) can maintain O(log(n))
  void removeShape (int order) {
    int index = 0;
    while (index < xVals.length) {
      if (xVals[index][1] == order) {
        remArr(xVals, index);
        index = 0;
        break;
      }
    }
    while (index < yVals.length) {
      if (yVals[index][1] == order) {
        remArr(yVals, index);
        index = 0;
        break;
      }
    }
    while (index < zVals.length) {
      if (zVals[index][1] == order) {
        remArr(zVals, index);
        index = 0;
        break;
      }
    }
    fin--;
    Sorts.quicksort(xVals);
    Sorts.quicksort(yVals);
    Sorts.quicksort(zVals);
    resize();
  }
    
  
  //cols remain the same across both
  void copTwoD ( float[][] fromSmal, float[][] toBig ) {
    for (int r = 0; r < fromSmal.length; r++) {
      for (int c = 0; c < fromSmal[r].length; c++) {
         toBig[r][c] = fromSmal[r][c];
      }
    }
  }
  
  void remArr (float[][] arr, int ind) {
    for(int r = ind; r < (arr.length-1); r++) {
      for(int c = 0; c < arr[r].length; c++) {
        arr[ind][c] = arr[ind+1][c];
      }
    }
  }
  
  void resize() {
    if (fin >= xVals.length || fin >= yVals.length || fin >= zVals.length) {
        float[][] newX = new float[xVals.length * 2][xVals[0].length];
        float[][] newY = new float[yVals.length * 2][yVals[0].length];
        float[][] newZ = new float[zVals.length * 2][zVals[0].length];
        copTwoD(xVals,newX);
        copTwoD(yVals,newY);
        copTwoD(zVals,newZ);
        xVals = newX;
        yVals = newY;
        zVals = newZ;
    }
    else if (xVals.length >= 40 && yVals.length >= 40 && zVals.length >= 40) {
        if (fin <= (xVals.length * 0.25) && fin <= (yVals.length * 0.25) && fin <= (zVals.length * 0.25)) {
          float[][] newX = new float[xVals.length/2][xVals[0].length];
          float[][] newY = new float[yVals.length/2][yVals[0].length];
          float[][] newZ = new float[zVals.length/2][zVals[0].length];
          copTwoD(newX,xVals);
          copTwoD(newY,yVals);
          copTwoD(newZ,zVals);
          xVals = newX;
          yVals = newY;
          zVals = newZ;
        }
    }
  }
  
  
  boolean collide( ArrayList<Polyhedra> foo, float uX, float uY, float uZ) {
    boolean posMove = true;
    int[] hitShapeInd = {-1, -1, -1, -1, -1};
    Sorts.quicksort(xVals);
    Sorts.quicksort(yVals);
    Sorts.quicksort(zVals);
    int[] closeX = BinSearch.binSearch(xVals, uX);
    int[] closeY = BinSearch.binSearch(yVals, uY);
    int[] closeZ = BinSearch.binSearch(zVals, uZ);
    //I present to you what seems to be the ugliest code i've ever written... it is checking for x,y,z coordinates that coorespond to singular shapes
    A: for (int g = 0; g < closeX.length; g++) {
      if (closeX[g] >= 0 && closeX[g] < xVals.length) { // if 1
      
        B: for (int h = 0; h < closeY.length; h++) {
          if (closeY[h] >= 0 && closeY[h] < yVals.length) { // if 2
            if (xVals[closeX[g]][1] == yVals[closeY[h]][1]) { // if 3
                     
              C: for (int k = 0; k < closeZ.length; k++) {
                if (closeZ[k] >= 0 && closeZ[k] < zVals.length) { // if 4
                  if (xVals[closeX[g]][1] == zVals[closeZ[k]][1]) { // if 5
                    hitShapeInd[g] = (int)xVals[closeX[g]][1];
                    break B; //breaks the yVal loop to check the next xVal index
                  }//end if 5
                }//end if 4
              }//end loop C
              
            }//end if 3
          }//end if 2
        }//end loop B
        
      }//end if 1
    }//end loop A
    for (int w = 0; w < hitShapeInd.length; w++) {
      if (hitShapeInd[w] >= 0) {
        float colRad = foo.get(hitShapeInd[w]).getCynRad();
        float colHei = foo.get(hitShapeInd[w]).getCynHei();
        int[] inps = foo.get(hitShapeInd[w]).getTrans();
        int oneX = inps[0];
        int oneY = inps[1];
        int oneZ = inps[2];
        if (   ( ((uX - oneX) * (uX - oneX)) + ((uY - oneY) * (uY - oneY)) <= (colRad * colRad) )  &&
                ( (uZ <= oneZ) && (uZ >= (oneZ - colHei)) )  ) {
                  posMove = false;
                }
      } 
    }
    return posMove;
  }
  
  
  
}

  
  
  
