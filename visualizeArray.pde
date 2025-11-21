void visualizeArray(int[] list)
{
  for (int i = 0; i<list.length; i++)
  {
    randomSeed(i);
    stroke(random(0,255),random(0,255),random(0,255));
    
    line(
    i*width/list.length+(width/list.length)/2,
    height,
    i*width/list.length+(width/list.length)/2,
    height-((list[i]+1)*height/maxVal)
    );
  }
}
