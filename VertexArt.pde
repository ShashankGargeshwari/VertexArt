float xSeed = 10;
float ySeed = 8;
float xInc = 1;
float yInc = 1;

String version = "Granite";

class vertex
{
  float x;
  float y;
  
  public vertex(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
  
  public void Display()
  {
    ellipse( x , y , 2 , 2);
  }
}

class column
{
  public ArrayList<vertex> vertices;
  
  public column( int yRowCount, float xLocation, float xSpacing, float ySpacing)
  {
    vertices = new ArrayList<vertex>();
    for(int i = 0; i < yRowCount; i++)
    {
      vertex v = new vertex( xLocation + noise(xSeed) * xSpacing * i/20 , i * ySpacing + noise(ySeed) * ySpacing * i/20);
      vertices.add(v);
      xSeed += xInc;
      ySeed += yInc;
    }
  }
    
  public void Display()
  {
    for(int i=0; i <= vertices.size()-2 ; i++)
    {
      vertices.get(i).Display();
      line(vertices.get(i).x, vertices.get(i).y, vertices.get(i+1).x, vertices.get(i+1).y);
    }
    vertices.get(vertices.size()-1).Display();
  }
  
  void ConnectToPreviousColumn(column previous)
  {
    
  }
}

class GridConstructor
{
  ArrayList<column> grid;
  public int xSize;
  public int ySize;
  
  float xSpacing;
  float ySpacing;
  
  public float xSeed;
  public float ySeed;
  public float xPlus;
  public float yPlus;
  
  
  
  public GridConstructor(int xColumnCount, int yRowCount, int perturbation)
  {
      grid = new ArrayList<column>();
      xSeed = perturbation;
      ySeed = perturbation;
      xSpacing = 1920 / xColumnCount;
      ySpacing = 1080 / yRowCount;
      xSize = xColumnCount;
      ySize = yRowCount;
      
      for(int i=0; i < xColumnCount; i++)
      {
        column c = new column(yRowCount, i * xSpacing, xSpacing, ySpacing);
        grid.add(c);
      }
  }
  
  public void Display()
  {
    column cPrev = grid.get(0);
    for(int i = 1; i < grid.size()-1; i++)
    {
      column c = grid.get(i);
      c.Display();
      for(int j = 0; j < c.vertices.size()-1; j++)
      {
        stroke(noise(xSeed) * 150 + 50);
        xSeed+=xInc;
        line( c.vertices.get(j).x, c.vertices.get(j).y, cPrev.vertices.get(j).x, cPrev.vertices.get(j).y );
        stroke(noise(xSeed) * 150 + 50);
        xSeed+=xInc;
        line( c.vertices.get(j).x, c.vertices.get(j).y, c.vertices.get(j+1).x, c.vertices.get(j+1).y );
        stroke(70, 70,noise(xSeed) * 50 + 200);
        xSeed+=xInc;
        line( c.vertices.get(j).x, c.vertices.get(j).y, cPrev.vertices.get(j+1).x, cPrev.vertices.get(j+1).y );
        
      }
      cPrev = c;
    }
  }
}
 GridConstructor g;
 
public void setup()
{
   size(1920,1080);
  g = new GridConstructor(80 , 40, 4);
  g.Display();
}

public void draw()
{
  if (keyPressed) {
    if (key == 's' || key == 'S') {
      save( version + year() + month() + day() + hour() + minute() + second() + millis()  );
    }
  }
}