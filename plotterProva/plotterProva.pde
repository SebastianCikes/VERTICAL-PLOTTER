// Plotter verticale by ITT Marconi
// Sebastian Cikes 5°AEA 2021/2022

import geomerative.*;
import processing.serial.*;

RShape grp;
PGraphics pdf;
RPoint[][] points;

color c1 = color(250);
color c2 = color(180);
color cText = color(24, 133, 187);

int canvasW = 1800;  //lunghezza plotter
int canvasH = 400;  //altezza plotter
int startX = 1700;  //punto inizio x
int startY = 600;  //punto inizio y

int stepfactor = 2; //quanti step x mm

boolean simulation = false;  //solo simulazione
boolean connected = false;  //è connesso?
boolean isPlaying = false;  //stà stampando?
boolean isCommandExecuting = true;  //stà eseguendo comandi?

int index = 0;
String[] lines;

int comDX, comSX;
int oldx, oldy;

Serial myPort;

void setup() {
  size(1101, 600);
  background(200);
  stroke(255);

  try {
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\n');
    println("connesso al plotter"); 
    connected = true;
    simulation = false;
  } 
  catch (Exception e) {
    println("ERRORE: " + e);
    println("non connesso al plotter");
    connected = false;
    simulation = true;
  }

  output = createWriter("linee.csv");  //punti disegno
  Titillium = createFont("Titillium-Regular.otf", 14);  //font
  keyboard_big = loadShape("keyboard.svg");  //schermata caricamento
  comList = loadShape("comList.svg");  //immagine a lato

  frame = createGraphics(canvasW, canvasH);
}

void draw() {
  if (beginned == false) {
    begin();
    display(index);
  } else {
    if (fileLoaded == true && fileConverted == false) {
      conversion(filePath);
    }
  }

  if (simulation && isPlaying) {
    index++;
    display(index);
    if (index >= lines.length) {
      println("Stampa completata!"); 
      index = 0;
      play();
    }
  }

  if (!simulation && isPlaying && isCommandExecuting) {
    if (index < lines.length) {
      String[] pieces = split(lines[index], ',');
      if (pieces.length == 3) {

        myPort.write("1" + "," + servo[index] + "," + fattiX[index] + "," + fattiY[index] + "\n");

        index++;
        display(index);
        isCommandExecuting = false;
        serialEvent(myPort);

        //vai a casa
        if (index == lines.length) {
          play();
          index = 0;
          for (int abc = 0; abc < indice - 1; abc++) {
            fattiX[abc] = 0;
            fattiY[abc] = 0;
            servo[abc] = 0;
          }
          indice = 1;
          myPort.write("1" + "," + "0" + "," + startX + "," + startY + "\n");
        }
      }
    }
  }
}
