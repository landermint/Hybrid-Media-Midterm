boolean leftpressed = false;
boolean rightpressed = false;
void keyPressed()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
      leftpressed = true;
    }
    if (keyCode == RIGHT) {
      rightpressed = true;
    }
    if (keyCode == UP) {
      gamestarted = true;
    }
  }
}
void keyReleased()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
      leftpressed = false;
    }
    if (keyCode == RIGHT) {
      rightpressed = false;
    }
  }
}
