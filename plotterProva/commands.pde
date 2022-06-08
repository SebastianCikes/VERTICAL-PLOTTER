void play() {
  if (fileConverted) {
    isPlaying = !isPlaying;    
    if (isPlaying == true) {
      println("stampa! ");
    }
    if (isPlaying == false) {
      println("pausa! ");
    }
  }
}

void moveUp() {
  if (!simulation) {
    println("su");
    myPort.write("1" + "," + "2" + "," + "1" + "," + "1" + "\n");
  }
}

void moveDown() {
  if (!simulation) {
    println("giu");
    myPort.write("1" + "," + "2" + "," + "-1" + "," + "-1" + "\n");
  }
}

void moveLeft() {
  if (!simulation) {
    println("sinitra");
    myPort.write("1" + "," + "2" + "," + "1" + "," + "-1" + "\n");
  }
}

void moveRight() {
  if (!simulation) {
    println("destra");
    myPort.write("1" + "," + "2" + "," + "-1" + "," + "1" + "\n");
  }
}
