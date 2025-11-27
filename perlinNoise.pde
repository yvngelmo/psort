class perlinNoise
{ 
  boolean empty;
  int seed, rez;
  
  float[][] value = new float[width][height];
  float[][] vector;
  
  float topLeft,topRight,botLeft,botRight, 
        xRW, yRH;
  
  perlinNoise(boolean empty, int seed,int rez)
  {
    set(empty, seed,rez);
  }
  
  void set(boolean setEmpty, int setSeed,int setRez) //werte setzen in float grid
  {
    empty = setEmpty;
    seed = setSeed;
    rez = setRez;
    
    if(!empty)
    {
      randomSeed(seed);
      vector = new float[rez][rez];
      
      for (int y=0; y<rez; y++)
      {
        for (int x=0; x<rez; x++)
        {
          vector[x][y]=TWO_PI*0.01*random(100); //random prozentwert 0.0-1.0, mal 2PI
        }
      }
      
      for (int y=0; y<height; y++)
      {
        for (int x=0; x<width; x++)
        {
          //pixel position auf grid gescaled also xRW=2.5 zellen wenns auf der mitte der dritten zelle ist
          xRW = x*rez/float(width); 
          yRH = y*rez/float(height);
          
          //kleiner grid auf großen grid scalen, runden auf nächsten gridpunkt
          topLeft = vector[floor(xRW) % rez][floor(yRH) % rez];
          topRight = vector[ceil(xRW) % rez][floor(yRH) % rez];
          botLeft = vector[floor(xRW) % rez][ceil(yRH) % rez];
          botRight = vector[ceil(xRW) % rez][ceil(yRH) % rez];
          
          //wie viel influence hat ecke auf pixel?
          topLeft = dotPointCornerAngle(xRW,yRH,floor(xRW),floor(yRH),topLeft);
          topRight = dotPointCornerAngle(xRW,yRH,ceil(xRW),floor(yRH),topRight);
          botLeft = dotPointCornerAngle(xRW,yRH,floor(xRW),ceil(yRH),botLeft);
          botRight = dotPointCornerAngle(xRW,yRH,ceil(xRW),ceil(yRH),botRight);
          
          //wo in der gridzelle ist der pixel? + gesmoothed
          xRW = smoothstep(xRW-floor(xRW));
          yRH = smoothstep(yRH-floor(yRH));
          
          //horizontal oben und unten blenden über gesmoothte pixelposition, dann die beide blenden
          value[x][y] = lerp(
                        lerp(topLeft, topRight, xRW),
                        lerp(botLeft, botRight, xRW),
                        yRH
                        );
                        
          //(-1,1) auf (0,255) mappen
          value[x][y]= map(value[x][y],-1,1,0,255);
        }
      }
    }
  }
  
  //punktprodukt für punkt-ecke funktion
  float dotPointCornerAngle(float xPoint, float yPoint, float xCorner, float yCorner, float angle)
  {
    return cos(angle)*(xPoint-xCorner)+sin(angle)*(yPoint-yCorner);
  }
  
  //smoothstep funktion
  float smoothstep(float t)
  {
    return 3*t*t-2*t*t*t;
  }
}
