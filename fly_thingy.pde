Fly[] A;

float mouseGain;

void setup() {
  size(500,300);
  
  A = new Fly[12];
  
  for(int n=0; n<A.length; n++) {
    A[n] = new Fly(250+75*randomGaussian(),150+75*randomGaussian());
  }
}


void draw() {
 
  background(80,80,120);
  
  if(mousePressed) {
    mouseGain = 1;
    noStroke(); fill(255,255,120);
    ellipse(mouseX,mouseY,50,50);
  } else {
    mouseGain = 0;
  }
  
  
  
  for(int n=0; n<A.length; n++) {
    A[n].Update();
  }
  
}

class Fly {
 
  PVector p;
  boolean flap, flapped;
  int m, til_next_flap;
  int direction;
  
  Fly(float X, float Y) {
    p = new PVector(X,Y);
    flap = false; flapped = false;
    direction = 1;  // -1 for left, +1 for right
    m=0;
    til_next_flap = 1;
  }
  

  void Update() {
    
    flapped = false; m = m+1;
    
    //til_next_flap = round( 4 - 2*(p.y-mouseY)/100);
    float probability = 50 + 5*randomGaussian() + mouseGain*(20+randomGaussian())*(p.y-mouseY-75)/100;
    
    if(m>til_next_flap && !flap && (random(100) < probability) ) {
      flap = true; flapped = true;
      m = 0;
    } else if(m>til_next_flap) {
      flap = false; 
    }
    
    
    
    Move();
    Draw();
  }
  
  
  void Move() {
    
    p.set(p.x+ 3*randomGaussian(),p.y + 3*randomGaussian() + 2);
    
    
    if(flapped) {
      p.set(p.x + 3*randomGaussian() + mouseGain*0.1*(mouseX-p.x),  p.y - 10); 
    }
    
  }
  
  
  
  
  void Draw() {
    
    strokeWeight(2); stroke(0); fill(255);
    if(flap) {
      bezier(p.x,p.y,   p.x-20,p.y-40,   p.x-50,p.y,  p.x, p.y);
      bezier(p.x,p.y,   p.x+20,p.y-40,   p.x+50,p.y,  p.x, p.y);
    } else {
      bezier(p.x,p.y,   p.x-30,p.y-30,   p.x-40,p.y+25,  p.x, p.y);
      bezier(p.x,p.y,   p.x+30,p.y-30,   p.x+40,p.y+25,  p.x, p.y);
    }
    
    strokeWeight(20); stroke(0); noFill();
    point(p.x,p.y);
  }
  
}