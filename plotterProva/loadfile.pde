String filePath = ""; 
String fileName = ""; 

boolean fileLoaded = false;

public void fileLoad() {
  if (!isPlaying && !fileLoaded) {
    selectInput("Selezionare un file:", "fileSelected");
  } else if (!isPlaying && fileLoaded) {
    index = 0;
    fileLoaded = false;
    fileConverted = false;
    filePath = "";
    output = createWriter("linee.csv");
    pointDraw = false;

    selectInput("Selezionare un file:", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Annullato.");
  } else {
    println("Selezionato " + selection.getAbsolutePath());
    filePath = selection.getAbsolutePath();
    fileName = selection.getName();
    fileLoaded = true;
    println(filePath);
  }
}
