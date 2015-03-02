float rand;
float cargenerator;
int cargeneratoround;
int count = 0;
//int numobs = 0;
Obstic[] myCars = new Obstic[0];

void setup() {
  size(1280, 720, P3D);
  rand = random(width);
}
void draw() {
  //boxsize+=80;
  cargenerator = random(50);
  cargeneratoround = round(cargenerator);
  background(0);
  stroke(255);
  //noFill();
  lights();
  pushMatrix();//{
    camera(mouseX, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);
    translate(width/2, height-100, -100);
    box(100);
  popMatrix();//}
  int index = 0;
  if (cargeneratoround == 25) {
    count++;
    myCars[myCars.length-1] = new Obstic(1, random(width));
    expand(myCars,myCars.length+1);
    //append(myCars,new Obstic(1, random(width)));
    //myCars.add(new Obstic(1, random(width)));
    println(myCars.length);
  }
  if (count > 0) {
    for (Obstic car : myCars) {
      car.drive();
    }
  }
  line(0, height, width/2, height/2);
  line(width, height, width/2, height/2);
  line(0, height/2, width, height/2);
}
class Obstic {
  float boxsize;
  float randomnum;
  Obstic(float tempboxsize, float temprandomnum) {
    boxsize = tempboxsize;
    randomnum = temprandomnum;
  }
  void drive() {
    boxsize+=80;
    pushMatrix();//{
      camera(randomnum, height/2, (height/2) / tan(PI/6), randomnum, height/2, 0, 0, 1, 0);
      translate(width/2, height-100, -15000+boxsize);
      box(100, 200, 100);
    popMatrix();//}
  }
}

