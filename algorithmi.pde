//settings
int maxVal = 10;
int listLength = 25;
int step = 0;

//liste
int[] randomList = new int[listLength];

void setup()
{
  //basic
  size(600,400);
  strokeWeight(width/listLength);
  strokeCap(SQUARE);
  
  //init liste
  for (int i = 0; i<randomList.length; i++)
  {
    randomList[i]=int(random(0,maxVal));
  }
}

void draw()
{
  //sort
  randomList = bubbleSort(randomList);
  
  //draw scene
  background(255);
  visualizeArray(randomList);
}
