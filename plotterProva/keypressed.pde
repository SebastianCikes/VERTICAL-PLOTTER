boolean control = false;

void keyPressed() {
  if (key == ' ') {
    play();
  }

  if (!isPlaying) {
    if (key == CODED && isPlaying == false) {
      if (keyCode == CONTROL) {
        control = true;
      } else if (keyCode == LEFT) {
        moveLeft();
      } else if (keyCode == RIGHT) {
        moveRight();
      } else if (keyCode == UP && control==false) {
        moveUp();
      } else if (keyCode == DOWN && control==false) {
        moveDown();
      } else if (keyCode == ALT && control==false ) {
        //     setZero();
      } else if (keyCode == ALT && control==true ) {
        //     goHome();
      } else if (keyCode == UP && control==true) {
        //     penUp();
      } else if (keyCode == DOWN && control==true) {
        //penDown();
      }
    }

    if (key == 'l' && isPlaying == false) {
      fileLoad();
    }
  }
}


void keyReleased() {
  if (key == CODED && isPlaying == false) {

    if (keyCode == CONTROL) {
      control = false;
    }
  }
}
