void serialEvent(Serial myPort) {  //sicurezza che abbia raggiunto il punto
  if (myPort.available() > 0) {
    char inByte2 = myPort.readChar();
    
    if (inByte2 == 'Y') {
      isCommandExecuting = true;
    }
  }
}
