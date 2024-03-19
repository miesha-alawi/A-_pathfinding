class Spot{
  int f,g,h;
  int x,y;
  ArrayList<Spot> neighbors = new ArrayList<Spot>();
  Spot previous;
  boolean wall = false;
  Spot(int i, int j)
  {
    x = i;
    y = j;
    f = 0;
    g = 0;
    h = 0;
    previous = null;
    if(random(1) < 0.3)
    {
      wall = true;
    }
  }
  
  void draw(color c)
  {
    fill(c);
    if(wall)
    {
      fill(0);
    }
    stroke(0);
    rect(x*scale,y*scale,scale,scale);
  }
  
  void addNeighbors(Spot[][] grid)
  {
    int i = x;
    int j = y;
    if(i < cols-1)
    {
      neighbors.add(grid[i+1][j]);
    }
    if(i > 0)
    {
      neighbors.add(grid[i-1][j]);
    }
    if(j < rows-1)
    {
      neighbors.add(grid[i][j+1]);
    }
    if(j > 0)
    {
      neighbors.add(grid[i][j-1]);
    }
    if(i > 0 && j > 0)
    {
      neighbors.add(grid[i-1][j-1]);
    }
    if(i < cols-1 && j > 0)
    {
      neighbors.add(grid[i+1][j-1]);
    }
    if(i > 0 && j < rows-1)
    {
      neighbors.add(grid[i-1][j+1]);
    }
    if(i < cols-1 && j < rows-1)
    {
      neighbors.add(grid[i+1][j+1]);
    }
  }
}
