final App app = new App(
  256,
  new double[]{-1.375, -0.625},
  256,
  1000);

void setup() {
  size(640, 360);
  startThreads();
}

void draw() {
  loadPixels();
  prepareThreadsForWork();
  app.isFrameRequested = true;

  while (!allThreadsDone()) {
    // no-op
    delay(1);
  }

  app.isFrameRequested = false;
  updatePixels();

  if ((frameRate % 20) == 0) {
    System.out.println(frameRate);
  }
}

void mouseDragged() {
  final int dx = pmouseX - mouseX;
  final int dy = pmouseY - mouseY;

  panCamera(dx, dy);
}

void mouseWheel(MouseEvent event) {
  zoomCamera(event.getCount() * app.unitToPixelRatio * 0.3D);
}

void keyPressed() {
  switch(key) {
  case 'q':
    app.cardioidCheck = !app.cardioidCheck;
    System.out.println(String.format("Cardioid Check: %b", app.cardioidCheck));
    break;
  case '-':
    app.maxIterations /= 10;
    System.out.println(String.format("Max Iterations: %d", app.maxIterations));
    break;
  case '+':
    app.maxIterations *= 10;
    System.out.println(String.format("Max Iterations: %d", app.maxIterations));
    break;
  }
}
