PShape keyboard_big, comList;
PFont Titillium;
boolean pointDraw = false;
int cursorX, cursorY;
int x, y;

int[] puntiX = new int[100000];
int[] puntiY = new int[100000];

void display(int index) {
  background(220);
  smooth();

  if (fileConverted) {  
    frame.beginDraw();
    frame.smooth();

    if (!pointDraw) {
      frame.background(220);
      pointDraw = true;
    }
  }

  if (fileLoaded && index > 0) {
    puntiX[index] = fattiX[index] / 2;
    puntiY[index] = fattiY[index] / 2;
    for (int b = 0; b < index; b++) {
      stroke(0);
      point(puntiX[b], puntiY[b]);
    }
    pushMatrix();
    stroke(200, 0, 0);
    noFill();
    ellipse(puntiX[index], puntiY[index], 6, 6);
    fill(200, 0, 0);
    textSize(8);

    text("x "+ puntiX[index] + "  y "+ puntiY[index], puntiX[index] + 7, puntiY[index] + 3);
    strokeWeight(0.1);
    line(5, 5, puntiX[index], puntiY[index]);
    line(5 + (canvasW / 2) - 10, 5, puntiX[index], puntiY[index]);

    popMatrix();
  }

  pushMatrix();
  fill(cText);
  if (connected) {
    textSize(11);
    text("Connesso al plotter", width - 190, height - 100);
  }

  if (!connected) {
    textSize(11);
    text("Non connesso al plotter", width - 190, height - 100);
  }

  if (!fileLoaded) {
    textSize(11);
    text("Selezionare un file .svg", width - 190, height - 85);
  }

  if (fileLoaded) {
    textSize(11);
    text("Selezionato: " + fileName + "", width - 190, height - 85);
  }

  if (isPlaying) {

    pushMatrix();
    textSize(11);
    textAlign(LEFT);
    text("Stampa", width - 190, height - 70);
    popMatrix();
  }

  if (!isPlaying) {
    textSize(11);  
    text("Programma in pausa", width - 190, height - 70);
  }

  stroke(cText);
  strokeWeight(1);
  line(0, canvasH / 2, canvasW / 2, canvasH / 2);
  popMatrix();

  shape(comList, width - comList.width, 1);
}

void refreshCanvas() {
  pointDraw = false;
}

PGraphics frame;
