final App app = new App(
  256,
  new double[]{-1.375, -0.625},
  256,
  1000);

PShader shader;
PImage img;

int oldWidth = 0, oldHeight = 0;

void setup() {
  size(640, 360, P2D);
  surface.setTitle("Hello World!");
  surface.setResizable(true);

  startThreads();
  shader = loadShader("mandelbrot.frag");
  img = createImage(width, height, RGB);
}

void draw() {
  if (oldWidth != width || oldHeight != height) {
    surfaceResized();
  }

  if (app.shaderMode) {
    shader.set("worldAnchorPoint", (float) app.worldAnchorPoint[0], (float) app.worldAnchorPoint[1]);
    shader.set("unitToPixelRatio", app.unitToPixelRatio);
    shader.set("maxIterations", app.maxIterations);
    shader.set("cardioidCheck", app.cardioidCheck);

    shader(shader);
    image(img, 0, 0);
  } else {
    loadPixels();
    prepareThreadsForWork();
    app.isFrameRequested = true;

    while (!allThreadsDone()) {
      // no-op
      delay(1);
    }

    app.isFrameRequested = false;
    updatePixels();
  }

  if (app.index % 20 == 0) {
    System.out.println(frameRate);
  }

  app.index++;
  oldWidth = width;
  oldHeight = height;
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
  case 't':
    app.shaderMode = !app.shaderMode;
    System.out.println(String.format("Shader Mode: %b", app.shaderMode));
    break;
  }
}

void surfaceResized() {
  startThreads();
  img.resize(width, height);
}
