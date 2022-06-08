PrintWriter output;
boolean fileConverted = false;
int indice = 1;
int maxX, minX = canvasW, maxY, minY = canvasH, midX, midY, valX, valY, dist = 5;
int aggX = 0, aggY = 0;  //immagine spostata di pixel (0 è centrato)
float scala = 3;  //scala immagine  (1 è originale)
boolean ripetizioni = true;  //se il tool può tornare in  punti già fatti
boolean fat = false;
int ultX, ultY;

int[] fattiX = new int[100000];
int[] fattiY = new int[100000];
int[] servo = new int[100000];

void conversion (String Path) {
  RG.init(this);
  grp = RG.loadShape(Path);
  RG.setPolygonizerLength(1);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  points = grp.getPointsInPaths();

  for (int n = 0; n < points.length; n++) {
    for (int i = 0; i < points[n].length; i++) {
      noFill();
      stroke(255, 0, 0);

      ultX = int(points[n][i].x * scala);
      ultY = int(points[n][i].y * scala);

      if (!ripetizioni) {
        for (int abc = 0; abc < indice; abc++) {
          if (ultX == fattiX[abc] && ultY == fattiY[abc]) {
            fat = true;
          }
        }
        if (!fat) {
          fattiX[indice - 1] = ultX;
          fattiY[indice - 1] = ultY;

          //minimo e massimo del disegno
          if (maxX <= fattiX[indice - 1]) {
            maxX = fattiX[indice - 1];
          }
          if (minX >= fattiX[indice - 1]) {
            minX = fattiX[indice - 1];
          }
          if (maxY <= fattiY[indice - 1]) {
            maxY = fattiY[indice - 1];
          }
          if (minY >= fattiY[indice - 1]) {
            minY = fattiY[indice - 1];
          }

          if (i == 0 && indice > 1) {
            if (abs(fattiX[indice - 2] - fattiX[indice - 1]) < dist && abs(fattiY[indice - 2] - fattiY[indice - 1]) < dist) {
              servo[indice - 1] = 1;
            } else if (abs(fattiX[indice - 2] - fattiX[indice - 1]) >= dist && abs(fattiY[indice - 2] - fattiY[indice - 1]) >= dist) {
              servo[indice - 1] = 0;
            }
          } else if (i != 0) {
            servo[indice - 1] = 1;
          }

          if (i == 0 && n == 0) {
            servo[indice - 1] = 0;
          }

          output.println(servo[indice - 1] + ", " + fattiX[indice - 1] + ", " + fattiY[indice - 1]);
          indice++;
        }
        fat = false;
      } else {
        fattiX[indice - 1] = ultX;
        fattiY[indice - 1] = ultY;

        //minimo e massimo del disegno
        if (maxX <= fattiX[indice - 1]) {
          maxX = fattiX[indice - 1];
        }
        if (minX >= fattiX[indice - 1]) {
          minX = fattiX[indice - 1];
        }
        if (maxY <= fattiY[indice - 1]) {
          maxY = fattiY[indice - 1];
        }
        if (minY >= fattiY[indice - 1]) {
          minY = fattiY[indice - 1];
        }

        if (i == 0 && indice > 1) {
          if (abs(fattiX[indice - 2] - fattiX[indice - 1]) < dist && abs(fattiY[indice - 2] - fattiY[indice - 1]) < dist) {
            servo[indice - 1] = 1;
          } else if (abs(fattiX[indice - 2] - fattiX[indice - 1]) >= dist && abs(fattiY[indice - 2] - fattiY[indice - 1]) >= dist) {
            servo[indice - 1] = 0;
          }
        } else if (i != 0) {
          servo[indice - 1] = 1;
        }

        if (i == 0 && n == 0) {
          servo[indice - 1] = 0;
        }

        output.println(servo[indice - 1] + ", " + fattiX[indice - 1] + ", " + fattiY[indice - 1]);
        indice++;
      }
    }
  }
  //stampa centrata
  midX = (maxX - minX) / 2;
  midY = (maxY - minY) / 2;

  valX = (canvasW / 2) - minX - midX;
  valY = (canvasH / 2) - minY - midY;

  for (int i = 0; i < indice - 1; i++) {
    fattiX[i] = fattiX[i] + valX + aggX;
    fattiY[i] = fattiY[i] + valY + aggY;
    point(fattiX[i] / 2, fattiY[i] / 2);
  }

  output.flush();
  output.close(); 
  lines = loadStrings("linee.csv");
  fileConverted = true;
}
