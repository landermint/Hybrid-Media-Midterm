import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ddf.minim.*;

Minim minim;
AudioPlayer song1;
AudioPlayer song2;

Capture video;
OpenCV opencv;
float rand;
float cargenerator;
int cargeneratoround;
int count = 0;
int howlong = 0;
//int numobs = 0;
Obstic[] myCars = new Obstic[0];
ArrayList obsticles;
int boxplace;
int points = 0;
String pointcounter;
String lose = "not lose";
boolean gamestarted = false;
String maintext = "PRESS START TO BEGIN GAME";
int faces2;
int counter = 0;
int[] scores = new int[5];
int score;
float howlongdev;
int howlongdevround;
void setup() {
  for (int i=0; i<scores.length; i++) {
    scores[i] = 0;
  }

  minim = new Minim(this);
  //frameRate(30);
  size(1280, 720, P3D);
  obsticles = new ArrayList();
  rand = random(width);
  boxplace = width/2;
  //video = new Capture(this, 640/2, 480/2,"Logitech Camera");
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  song1 = minim.loadFile("bluescreen.wav");
  song2 = minim.loadFile("redscreen.wav");
  song1.loop();
  song2.loop();
  song2.mute();
  song1.mute();
}
void draw() {
  if (gamestarted == true) {
    counter++;
  }
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  faces2 = faces.length;
  //boxsize+=80;
  if (faces2 > 0) {
    song2.mute();
    song1.unmute();
    cargenerator = random(16);
    background(15, 15, 255);
    howlong = 0;
  } else {
    howlong++;
    song1.mute();
    song2.unmute();

    cargenerator = random(16);
    background(255, 0, 0);
  }
  howlongdev = howlong/15;
  howlongdevround = round(howlongdev);
  cargeneratoround = round(cargenerator);
  
  stroke(255);
  //noFill();
  lights();
  pushMatrix();//{
  camera(boxplace, height/2, (height/2) / tan(PI/6), boxplace, height/2, 0, 0, 1, 0);
  if (gamestarted == true) {

    translate(width/2, height-100, -100);
  } else {
    translate(width/2, height-50, -100);
  }
  if (gamestarted == false) {
    fill(255, 0, 0);
    box(100, 5, 100);
  } else {
    fill(255);
    box(100);
  }
  popMatrix();//}
  int index = 0;
  if (cargeneratoround == 2 && gamestarted == true) {
    count++;
    //myCars[myCars.length-1] = new Obstic(1, random(width));
    //expand(myCars,myCars.length+1);
    //append(myCars,new Obstic(1, random(width)));
    obsticles.add(new Obstic(1, random(width), false));
    //println(myCars.length);
  }
  if (count > 0) {
    for (int i = 0; i < obsticles.size (); i++) {
      Obstic p = (Obstic) obsticles.get(i);
      p.drive();
    }
  }
  pushMatrix();
  translate(0, 0, -150);
  line(0, height, width/2-80, height/2+30);
  line(width, height, width/2+80, height/2+30);
  line(0, height/2+30, width, height/2+30);
  popMatrix();
  if (gamestarted == true) {
    if (leftpressed == true && boxplace < 1144) {
      boxplace+=9;
    }
    if (rightpressed == true && boxplace > 136) {
      boxplace-=9;
    }
  }
  //draw score
  if (gamestarted == true) {

    pointcounter = str(points);
    fill(255);
    textSize(32);
    text("points: "+pointcounter, 150, 30); 
    //text(lose, 200, 30);
  } else {
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text(maintext, width/2, 50);
    text("Scores: ", 100, 60);
    for (int i=0; i<scores.length; i++) {
      text(scores[i], 100, 120+60*i);
    }
    text("Last try: ", 300, 60);
    text(score, 300, 120);
  }
  println(howlong);
}
class Obstic {
  float boxsize;
  float randomnum;
  boolean pointmade;
  Obstic(float tempboxsize, float temprandomnum, boolean tempmade) {
    boxsize = tempboxsize;
    randomnum = temprandomnum;
    pointmade = tempmade;
  }
  void drive() {
    if (faces2 > 0) {
      boxsize+=5;
    } else {
      boxsize+=300;
    }

    pushMatrix();//{
    camera(randomnum, height/2, (height/2) / tan(PI/6), randomnum, height/2, 0, 0, 1, 0);
    translate(width/2, height-100, -5000+boxsize);
    if (gamestarted == true) {
      box(100, 200, 100);
    }

    if (-5000+boxsize > -350 && -5000+boxsize < -50 && randomnum+100 >= boxplace && randomnum+50 <= boxplace+150) {
      //game lost
      score = points;

      obsticles.clear();
      addNewScore(score);

      points = 0;
      gamestarted = false;
    }
    if (-5000+boxsize > -350 && -5000+boxsize < -50 && pointmade == false && gamestarted == true) {
      points+=1+howlongdevround;
      pointmade = true;
    }
    popMatrix();//}
  }
}
void mousePressed() {
  println(mouseX + " " + mouseY);
}
void captureEvent(Capture c) {
  c.read();
}
void addNewScore(int score) {
  for (int i=0; i<scores.length; i++) {
    if (score>=scores[i]) {
      for (int j=scores.length-1; j>=max (i, 1); j--) {
        scores[j] = scores[j-1];
      }
      scores[i] = score;
      break;
    }
  }
}

