// Plotter verticale by ITT Marconi
// Sebastian Cikes 5°AEA 2021/2022

#include <Stepper.h>
#include <Servo.h>

//finecorsa
#define fcA 11
#define fcB 12

// Motori (1 passo = 0.3925 mm lunghezza)
Stepper stepperSX(200, 3, 4, 5, 6);
Stepper stepperDX(200, 7, 8, 9, 10);
Servo penna;

long V = 20; //velocità motori %;

long c, c1, c2, oldc, oldc1, oldc2;

long startX = 1700; //punto inizio X
long startY = 600;  //punto inizio Y
int canvasW = 1800; //lunghezza plotter

long ox, oy, vx, vy, dx, dy, p, ix, iy;

long iSX, iDX, iSXold, iDXold, vecX, vecY;

int a = 2, q = 1, h = 500;

////////////////////////////////////////////////////////////////////SETUP
void setup() {
  Serial.begin(9600);

  oldc1 = startX;
  oldc2 = startY;

  ipo(startX, startY);

  penna.attach(2);
  penna.write(180);

  stepperSX.setSpeed(V);
  stepperDX.setSpeed(V);

  for (int i = 0; i < 50; i++) {
    stepperSX.step(1);
    stepperDX.step(1);
  }
}

////////////////////////////////////////////////////////////////////LOOP
void loop() {
  while (Serial.available() > 0) {
    if (Serial.parseInt() == 1) {
      c = Serial.parseInt();
      c1 = Serial.parseInt();
      c2 = Serial.parseInt();
    }

    if (eseguiComando()) {
      Serial.print("Y");
      Serial.println("Y");
      oldc = c;

      if (c != 2) {
        oldc1 = c1;
        oldc2 = c2;
      }
    }
  }
}

////////////////////////////////////////////////////////////////////ESEGUI COMANDO
bool eseguiComando () {
  if (c == 0) { //non scrivere, segui linea
    penna.write(180);
    delay(500);
    algoritmo(oldc1, oldc2, c1, c2);
    delay(200);

  } else if (c == 1) {  //scrivi, segui linea
    penna.write(0);
    delay(500);
    algoritmo(oldc1, oldc2, c1, c2);

  } else if (c == 2) {  //muovi stepper di x,x steps
    penna.write(180);
    delay(500);
    moveSteppers(c1, c2);
  }
  delay(50);
  return true;
}

////////////////////////////////////////////////////////////////////MUOVI LUNGO LINEA
void algoritmo (long x0, long y0, long x1, long y1) {
  ox = x0;
  oy = y0;
  ix = x1;
  iy = y1;

  dx = abs(ox - ix);
  dy = abs(oy - iy);

  if (dx > dy)
    p = (q * dy) - dx;
  else
    p = (q * dx) - dy;

  if (dx >= dy) {
    while (ox <= ix and oy <= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      ox++;
      if (p < 0) {
        p = p + (q * dy);
      } else {
        p = p + (q * dy) - (q * dx);
        oy++;
      }
    }

    while (ox <= ix and oy >= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      ox++;
      if (p < 0) {
        p = p + (q * dy);
      } else {
        p = p + (q * dy) - (q * dx);
        oy--;
      }
    }

    while (ox >= ix and oy >= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      ox--;
      if (p < 0) {
        p = p + (q * dy);
      } else {
        p = p + (q * dy) - (q * dx);
        oy--;
      }
    }

    while (ox >= ix and oy <= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      ox--;
      if (p < 0) {
        p = p + (q * dy);
      } else {
        p = p + (q * dy) - (q * dx);
        oy++;
      }
    }

  } else if (dx < dy) {
    while (ox <= ix and oy <= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      oy++;
      if (p < 0) {
        p = p + (q * dx);
      } else {
        p = p + (q * dx) - (q * dy);
        ox++;
      }
    }

    while (ox >= ix and oy >= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      oy--;
      if (p < 0) {
        p = p + (q * dx);
      } else {
        p = p + (q * dx) - (q * dy);
        ox--;
      }
    }

    while (ox >= ix and oy <= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      oy++;
      if (p < 0) {
        p = p + (q * dx);
      } else {
        p = p + (q * dx) - (q * dy);
        ox--;
      }
    }

    while (ox <= ix and oy >= iy) {
      moveSteppers(ox, oy);
      vx = ox;
      vy = oy;
      oy--;
      if (p < 0) {
        p = p + (q * dx);
      } else {
        p = p + (q * dx) - (q * dy);
        ox++;
      }
    }
  }
}

////////////////////////////////////////////////////////////////////MUOVI STEPPER
void moveSteppers (long xSteps, long ySteps) {
  ipo(xSteps, ySteps);
  xSteps = iSX;
  ySteps = iDX;

  if (xSteps - vecX == 0 and ySteps - vecY == 0) {
    stepperSX.step(0);
    stepperDX.step(0);
  } else if (xSteps - vecX < 3 and xSteps - vecX > -3 and ySteps - vecY < 3 and ySteps - vecY > -3) {
    stepperSX.step((xSteps - vecX) * a);
    stepperDX.step((ySteps - vecY) * a);
  }

  vecX = xSteps;
  vecY = ySteps;
}

////////////////////////////////////////////////////////////////////CALCOLO IPOTENUSA
void ipo(long xPass, long yPass) {
  iSX = -1 * sqrt((xPass * xPass) + ((yPass + h) * (yPass + h)));
  iDX = -1 * sqrt((canvasW - xPass) * (canvasW - xPass) + ((yPass + h) * (yPass + h)));
}
