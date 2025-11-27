void calcNoiseStackDraw()
{
  for (int y=0; y<height; y++)
  {
    for (int x=0; x<width; x++)
    {
      col[x][y]=0; //col reset wenn neu gedrawed wird
    }
  }
  
  for(int i=0; i<layers; i++) //für jeden layer, der der enabled ist wird noise berechnet und dann wird die noise in calcCol gesendet
  {
    if(!whiteList[i].empty)
    {
      whiteList[i].set(false,whiteList[i].seed); //noise berechnen
      calcCol(whiteList[i].value, i);
    }
    else if(!perlinList[i].empty)
    {
      perlinList[i].set(false,perlinList[i].seed,perlinList[i].rez); //noise berechnen
      calcCol(perlinList[i].value, i);
    }
    else if(!voronoiList[i].empty)
    {
      voronoiList[i].set(false,voronoiList[i].seed,voronoiList[i].pointAmt,voronoiList[i].scatterAmt); //noise berechnen
      calcCol(voronoiList[i].value, i);
    }
  }
  
  for (int y=0; y<height; y++)
  {
    for (int x=0; x<width; x++)
    {
      set(x,y,color(col[x][y])); //für jeden pixel wert von col drawen
    }
  }
}

void calcCol(float[][] listVal, int i)
{
  for (int y=0; y<height; y++)
  {
    for (int x=0; x<width; x++) //für jeden wert von col & input val
    {
      col[x][y]=col[x][y]*(1-0.01*alphaval[i])+(listVal[x][y]*0.01*brightness[i])*0.01*alphaval[i]; //alte farbe*(1-opacity%)+(neue farbe*brightness%)*(opacity%)
    }
  }
}
