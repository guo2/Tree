int MAX_GEN = 4;
int MAX_AGE = 60;
int AGE_MATURE = 10;
float GROWTH = 0.03;

class Node
{
  PVector location;
  PVector velocity;
  float radius;
  float targetR;
  int generation;
  int age;
  int depth;
  boolean grown;
  boolean isDead;
  Node left, right;
  
  float opacity;
  
  Node()
  {
  
  }
  
  Node(PVector l, PVector v, float r, float tr, int g, int a, int d)
  {
    location = l.copy();
    velocity = v.copy();
    velocity.setMag(1);
    radius = r;
    targetR = tr;
    generation = g;
    age = a;
    depth = d;
    grown = false;
    isDead = false;
    
    opacity = 0;
  }
  
  void update()
  {
    if(grown)
    {
      left.update();
      right.update();
      if(left.isDead && right.isDead)
        isDead = true;
      return;
    }
    
    if (radius < 0.4)
    {
      isDead = true;
      return;
    }
      
    if(age > AGE_MATURE * radius && random(1) < GROWTH * sqrt(radius) && age < MAX_AGE * radius)
    {
      float split = (generation <= 2)?random(0.15, 0.35):random(0.1, 0.5);
      float splitAngle = PI * ((generation <= 2) ? random(0.2, 0.4) : (random(0.4, 0.7) / sqrt(generation)));
      if(random(1)<0.5)
        split = 1 - split;
      PVector newV = velocity.copy();
      newV.rotate(split * splitAngle);
      targetR = radius * sqrt(split);
      velocity.rotate((split-1) * splitAngle);
      age = 0;
      generation++;
      
      this.left = new Node(location, velocity, radius, targetR, generation, 0, depth + (int)(random(-20, 30)/generation));
      this.right = new Node(location, newV, radius, radius * sqrt(1 - split), generation, 0, depth + (int)(random(-20, 30)/generation));
      grown = true;

      return;
    }
    
    location.add(velocity);
    
    if (radius > targetR || age > MAX_AGE * radius)
      radius*=0.98;
    else radius *= 0.995;

    float angle = PI * random(-0.01, 0.01) * sqrt(radius);
    velocity.rotate(angle);
    velocity.y -= 0.015 * sqrt(radius);
    velocity.setMag(1.2);
    depth+=(int)random(-4, 4);
    depth = constrain(depth, 30, 210);
    age++;
  }
  
  void render()
  {
    if (isDead)
      return;
      
    if(grown)
    {
      left.render();
      right.render();
      return;
    }
    
    if(generation == 1)
    {
      fill(depth, (int)opacity);
      opacity += 1.5;
      constrain(opacity, 0, 255);
    }
    else fill(depth);
    ellipse(location.x, location.y, radius*2, radius*2);

  }
}