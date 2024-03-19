//fastest path formula
//f(n) = g(n) + h(n)

int scale = 10;

int cols;
int rows;
Spot[][] grid;

ArrayList<Spot> openSet = new ArrayList<Spot>();
ArrayList<Spot> closedSet = new ArrayList<Spot>();
ArrayList<Spot> path = new ArrayList<Spot>();
Spot start;
Spot end;

void setup()
{
  size(400,400);
  cols = (int)width/scale;
  rows = (int)height/scale;
  grid = new Spot[cols][rows];
  
  //fill grid with spots
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      grid[i][j] = new Spot(i,j);
    }
  }
  
  //get all nodes neighbors
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      grid[i][j].addNeighbors(grid);
    }
  }
  
  //start and end nodes
  //hardcoding it so that start and end are never walls
  start = grid[0][0];
  start.wall = false;
  end = null;
  
  
  openSet.add(start);
}

void draw()
{
  background(0);
  if(end != null)
  {
  if(openSet.size() > 0)
  {
    //keep computing
    int winner = 0;
    for(int i = 0; i < openSet.size(); i++)
    {
      if(openSet.get(i).f < openSet.get(winner).f)
      {
        winner = i;
      }
    }
    
    Spot current = openSet.get(winner);
    
    if(current == end)
    {
      //find the path
      path = new ArrayList<Spot>();
      Spot temp = current;
      path.add(temp);
      while(temp.previous != null)
      {
        path.add(temp.previous);
        temp = temp.previous;
      }
      noLoop();
      System.out.print("Done!");
    }
    
    openSet.remove(winner);
    closedSet.add(current);
    
     ArrayList<Spot> n = current.neighbors;
     for(Spot s: n)
     {
       if(!closedSet.contains(s) && !s.wall)
       {
         int tempG = current.g + 1;
         boolean newPath = false;
         if(openSet.contains(s))
         {
           if(tempG < s.g)
           {
             s.g = tempG;
             newPath = true;
           }
         }
         else
         {
           s.g = tempG;
           newPath = true;
           openSet.add(s);
         }
         if(newPath) {
           //find the heuristic, or educated guess
           s.h = heuristic(s,end);
           s.f = s.g + s.h;
           s.previous = current;
         }
       }
     }
    
  }
  else
  {
    //no solution
    System.out.print("no solution");
    noLoop();
  }
  
  }
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      grid[i][j].draw(color(255));
    }
  }
  
  for(Spot s: closedSet)
  {
    s.draw(color(255,0,0));
  }
  
  for(Spot s: openSet)
  {
    s.draw(color(0,255,0));
  }
  
  for(Spot s: path)
  {
    s.draw(color(0,0,255));
  }

}

int heuristic(Spot a, Spot b)
{
  //manhattan/taxicab distance
  int d = Math.abs(a.x-b.x) + Math.abs(a.y-b.y);
  return d;
}

void mousePressed()
{
  int w = width/cols;
  int h = height/rows;
  int i = (int)(mouseX / w);
  int j = (int)(mouseY/ h);
  end = grid[i][j];
  end.wall = false;
}
