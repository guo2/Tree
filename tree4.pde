ArrayList<Node> trees = new ArrayList<Node>();
Node tree;

void setup()
{
  size(600, 600);
  //frameRate(60);
  noStroke();
  background(255);
  ellipseMode(CENTER); //<>//
}

void draw()
{      
  for(int i = 0; i < trees.size(); i++)
  {
      tree = trees.get(i);
      tree.render();
      tree.update();
      if(tree.isDead)
        trees.remove(i--);
  }
}

void keyPressed()
{
  trees.clear();
  background(255);
  if(keyCode == ' ')
    trees.add(new Node(new PVector(width/2, height-50), new PVector(0, -1), 12, 12, 1, 0, 175));
}