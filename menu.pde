void drawMenu()
{
  if(menuHidden) 
  {
    fill(255);
    rect(0,height-25,128,24);
    
    fill(0);
    text("show menu[H]", 6,height-8);
  }
  else
  {
    fill(255);
    rect(0,0,width-1,262);
    
    for(int i = 0; i<layers; i++)
    content(i);
    
    fill(255);
    rect(0,height-25,668,24);
    
    fill(0);
    text("change value using corresponding cell with LMB / RMB, hide menu[H]", 6,height-8);
  }
}

void content(int i) //werte darstellen
{  
  if(!whiteList[i].empty) //draw text&matrixSquares wenn layer whitenoise ist
  {
    fill(0);
    text("enabled, white, seed:"+whiteList[i].seed+", brightness:"+brightness[i]+", alpha:"+alphaval[i], 6, 16+16*i);
    fill(255);
    
    for(int v=0; v<5; v++)
    square(16*v,272+16*i,16);
  }
  
  else if(!perlinList[i].empty) //draw text&matrixSquares wenn layer perlinnoise ist
  {
    fill(0);
    text("enabled, perlin, seed:"+perlinList[i].seed+", rez:"+perlinList[i].rez+", brightness:"+brightness[i]+", alpha:"+alphaval[i], 6, 16+16*i);    
    fill(255);
    
    for(int v=0; v<6; v++)
    square(16*v,272+16*i,16);
  }
  
  else if(!voronoiList[i].empty) //draw text&matrixSquares wenn layer voronoinoise ist
  {
    fill(0);
    text("enabled, voronoi, seed:"+voronoiList[i].seed+", dens:"+voronoiList[i].pointAmt+", rand:"+voronoiList[i].scatterAmt+", brightness:"+brightness[i]+", alpha:"+alphaval[i], 6, 16+16*i);
    fill(255);
    
    for(int v=0; v<7; v++)
    square(16*v,272+16*i,16);
  }
  
  else //draw text wenn layer leer ist
  {
    fill(0);
    text("disabled", 6, 16+16*i);
    fill(255);
    square(0,272+16*i,16);
  }
}

void selectionMatrix() //auf mousePressed callen: werte verändern
{
  texSelected = mouseY/16;
  if(texSelected>16&&texSelected<33) texSelected = texSelected-17; //wert fixen damit richtiger input für listen
  else texSelected = -1; //von 17 bis 32, wenn außerhalb dann minus 1
  
  if(texSelected!=-1) //wenn mausY innerhalb dann wert bestimmen der in matrix ausgewählt wird
  {
    valSelected = mouseX/16;
    
    //welcher wert soll geändert werden? + werte ändern
    if(!whiteList[texSelected].empty&&valSelected<5) //werte: enabled, type, seed, brightness, alpha
    {
      if(valSelected==0) disableLayer(texSelected);
      
      if(valSelected==1) enableLayerToPerlin(texSelected);
      
      if(valSelected==2&&mouseButton==RIGHT) whiteList[texSelected].seed = whiteList[texSelected].seed-5;
      if(valSelected==2&&mouseButton==LEFT) whiteList[texSelected].seed = whiteList[texSelected].seed+5;
      
      if(valSelected==3&&mouseButton==RIGHT&&brightness[texSelected]>0) brightness[texSelected] = brightness[texSelected]-10;
      if(valSelected==3&&mouseButton==LEFT&&brightness[texSelected]<100) brightness[texSelected] = brightness[texSelected]+10;
      
      if(valSelected==4&&mouseButton==RIGHT&&alphaval[texSelected]>0) alphaval[texSelected] = alphaval[texSelected]-10;
      if(valSelected==4&&mouseButton==LEFT&&alphaval[texSelected]<100) alphaval[texSelected] = alphaval[texSelected]+10;
    }
    else if(!perlinList[texSelected].empty&&valSelected<6) //werte: enabled, type, seed, rez, brightness, alpha
    {
      if(valSelected==0) disableLayer(texSelected);
      
      if(valSelected==1) enableLayerToVoronoi(texSelected);
      
      if(valSelected==2&&mouseButton==RIGHT) perlinList[texSelected].seed = perlinList[texSelected].seed-5;
      if(valSelected==2&&mouseButton==LEFT) perlinList[texSelected].seed = perlinList[texSelected].seed+5;
      
      if(valSelected==3&&mouseButton==RIGHT&&perlinList[texSelected].rez>1) perlinList[texSelected].rez = perlinList[texSelected].rez-1;
      if(valSelected==3&&mouseButton==LEFT) perlinList[texSelected].rez = perlinList[texSelected].rez+1;
      
      if(valSelected==4&&mouseButton==RIGHT&&brightness[texSelected]>0) brightness[texSelected] = brightness[texSelected]-10;
      if(valSelected==4&&mouseButton==LEFT&&brightness[texSelected]<100) brightness[texSelected] = brightness[texSelected]+10;
      
      if(valSelected==5&&mouseButton==RIGHT&&alphaval[texSelected]>0) alphaval[texSelected] = alphaval[texSelected]-10;
      if(valSelected==5&&mouseButton==LEFT&&alphaval[texSelected]<100) alphaval[texSelected] = alphaval[texSelected]+10;
    }
    else if(!voronoiList[texSelected].empty&&valSelected<7) //werte: enabled, type, seed, pointAmt, scatterAmt, brightness, alpha
    {
      if(valSelected==0) disableLayer(texSelected);
      
      if(valSelected==1) enableLayerToWhite(texSelected);
      
      if(valSelected==2&&mouseButton==RIGHT) voronoiList[texSelected].seed = voronoiList[texSelected].seed-5;
      if(valSelected==2&&mouseButton==LEFT) voronoiList[texSelected].seed = voronoiList[texSelected].seed+5;
      
      if(valSelected==3&&mouseButton==RIGHT&&voronoiList[texSelected].pointAmt>0) voronoiList[texSelected].pointAmt = voronoiList[texSelected].pointAmt-1;
      if(valSelected==3&&mouseButton==LEFT) voronoiList[texSelected].pointAmt = voronoiList[texSelected].pointAmt+1;
      
      if(valSelected==4&&mouseButton==RIGHT&&voronoiList[texSelected].scatterAmt>0) voronoiList[texSelected].scatterAmt = voronoiList[texSelected].scatterAmt-10;
      if(valSelected==4&&mouseButton==LEFT) voronoiList[texSelected].scatterAmt = voronoiList[texSelected].scatterAmt+10;
      
      if(valSelected==5&&mouseButton==RIGHT&&brightness[texSelected]>0) brightness[texSelected] = brightness[texSelected]-10;
      if(valSelected==5&&mouseButton==LEFT&&brightness[texSelected]<100) brightness[texSelected] = brightness[texSelected]+10;
      
      if(valSelected==6&&mouseButton==RIGHT&&alphaval[texSelected]>0) alphaval[texSelected] = alphaval[texSelected]-10;
      if(valSelected==6&&mouseButton==LEFT&&alphaval[texSelected]<100) alphaval[texSelected] = alphaval[texSelected]+10;
    }
    else if(valSelected==0)//werte: enabled
    {
      enableLayerToWhite(texSelected);
    }
  }
}

void enableLayerToWhite(int layer)
{
  whiteList[layer].empty = false;
  perlinList[layer].empty = true;
  voronoiList[layer].empty = true;
}

void enableLayerToPerlin(int layer)
{
  whiteList[layer].empty = true;
  perlinList[layer].empty = false;
  voronoiList[layer].empty = true;
}

void enableLayerToVoronoi(int layer)
{
  whiteList[layer].empty = true;
  perlinList[layer].empty = true;
  voronoiList[layer].empty = false;
}

void disableLayer(int layer)
{
  whiteList[layer].empty = true;
  perlinList[layer].empty = true;
  voronoiList[layer].empty = true;
}
