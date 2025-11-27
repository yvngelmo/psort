//base variablen
int layers = 16;
int texSelected;
int valSelected;
boolean menuHidden = true;

//arrays für noise types
whiteNoise[] whiteList;
perlinNoise[] perlinList;
voronoiNoise[] voronoiList;

//array für noise bearbeitung
int[] alphaval;
int[] brightness;

//array für kombinierte pixelval
float[][] col;

void setup()
{ 
  //setup
  size(768,768);
  pixelDensity(1);
  strokeWeight(1);

  PFont courier;
  courier = loadFont("CourierNewPS-BoldMT-16.vlw");
  textFont(courier);

  //init empty stacks
  whiteList = new whiteNoise[layers];
  perlinList = new perlinNoise[layers];
  voronoiList = new voronoiNoise[layers];
  
  alphaval = new int[layers];
  brightness = new int[layers];
  
  col = new float[width][height];
  
  for(int i=0; i<layers; i++)
  {
    //init textures & settings
    alphaval[i] = 100;
    brightness[i] = 100;
    
    whiteList[i] = new whiteNoise(true,0);
    perlinList[i] = new perlinNoise(true,0,20);
    voronoiList[i] = new voronoiNoise(true,0,10,30);
  }
  //first frame
  background(255);
  calcNoiseStackDraw();
  drawMenu();
}

void mousePressed()
{
  
  if(!menuHidden) selectionMatrix(); //gehoverten wert verändern
  
  //update frame
  background(255);
  calcNoiseStackDraw();
  drawMenu();
}

void keyPressed()
{
  if(key=='h') menuHidden=!menuHidden; //menu show/hide
  
  //update frame
  background(255);
  calcNoiseStackDraw();
  drawMenu();
}

void draw()
{}
