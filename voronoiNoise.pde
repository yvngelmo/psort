class voronoiNoise
{ 
  boolean empty;
  int seed, pointAmt, scatterAmt;
  
  float[][] value = new float[width][height];
  
  float[][] pointsX;  //vektorengrid, aber 2 floats weil einfacher. repräsentieren ihre punktposition im screenspace
  float[][] pointsY;
  
  voronoiNoise(boolean empty, int seed, int pointAmt, int scatterAmt)
  {
    set(empty, seed, pointAmt, scatterAmt);
  }

  void set(boolean setEmpty, int setSeed, int setPointAmt, int setScatterAmt)
  {
    empty = setEmpty;
    seed = setSeed;
    pointAmt = setPointAmt;
    scatterAmt = setScatterAmt;
    
    if(!empty)
    {
      randomSeed(seed);
      pointsX = new float[pointAmt][pointAmt];
      pointsY = new float[pointAmt][pointAmt];
      
      for (int y=0; y<pointAmt; y++)
      {
        for (int x=0; x<pointAmt; x++)
        {
        //punktposition im screnspace definieren. width/pointAmt*x also punkte auf grid, plus random aus scatterAmt also random versetzt, plus halbe zelle damit zentriert
        pointsX[x][y]= width/pointAmt*x+random(-scatterAmt,scatterAmt)+0.5*(width/pointAmt);
        pointsY[x][y]= height/pointAmt*y+random(-scatterAmt,scatterAmt)+0.5*(height/pointAmt);
        }
      }
      
      for (int y=0; y<height; y++)
      {
        for (int x=0; x<width; x++)
        {
          float nearestDist = 9999; //große initialdistanz
          
          for (int yi=0; yi<pointAmt; yi++)
          {
            for (int xi=0; xi<pointAmt; xi++)
            {
            float distTemp = sq(x-pointsX[xi][yi])+sq(y-pointsY[xi][yi]); //wie weit von punkt entfernt?
            if (distTemp<nearestDist) nearestDist=distTemp; //kleinste gefundene distanz wird gespeichert
            }
          }
          
          //farbe von pixel wird bestimmt von distanz zu nächstem punkt
          value[x][y]=nearestDist*0.1;
        }
      }
    }
  }
}
