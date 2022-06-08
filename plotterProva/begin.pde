boolean beginned = false;
float bar = 0;

void begin() {
  background(220);

  if (bar < keyboard_big.width) {
    shape(keyboard_big, width / 2 - (keyboard_big.width / 2), height / 2 - (keyboard_big.height / 2)); 

    bar+=5;
    pushMatrix();
    noStroke();
    fill(cText);

    rect(width / 2 - (keyboard_big.width / 2), height / 2 + ((keyboard_big.height / 2) + 10), bar, 10);

    popMatrix();
  } else {
    beginned = true;
    return;
  }
}
