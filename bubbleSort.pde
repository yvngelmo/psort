int[] bubbleSort(int[] list)
{
  //swap wenn größer
  if(list[step]>list[step+1])
  {
    int x = list[step];
    list[step]=list[step+1];
    list[step+1]=x;
  }
  
  //stepper++, reset stepper
  if(step==list.length-2) step = 0;
  else step++;
  
  return list;
}
