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
  
  CollisionData(ArrayList<Polyhedra> polies /*float[] uLoc*/) {
    xVals = new float[20][2];
    yVals = new float[20][2];
    zVals = new float[20][2];
    for (int e = 0; e < polies.size(); e++) {
      int[] inps = polies.get(e).getTrans();
      xVals[e][0] = inps[0];
      xVals[e][1] = e;
      yVals[e][0] = inps[0];
      yVals[e][1] = e;
      zVals[e][0] = inps[0];
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
      yVals[fin][0] = inps[0];
      yVals[fin][1] = fin;
      zVals[fin][0] = inps[0];
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
          copTwoD(xVals,newX);
          copTwoD(yVals,newY);
          copTwoD(zVals,newZ);
          xVals = newX;
          yVals = newY;
          zVals = newZ;
        }
    }
  }
  
  
  boolean collide( ArrayList<Polyhedra> foo, float[] uLoc) {
    return true;
  }
  
  
  
}

  
  
  
