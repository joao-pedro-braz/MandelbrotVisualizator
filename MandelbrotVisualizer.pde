final App app = new App(
  256,
  new double[]{-1.375, -0.625},
  512,
  1000);

PShader shader;
PImage img;

void setup() {
  size(640, 360, P3D);
  surface.setTitle("Hello World!");
  surface.setResizable(true);

  startThreads();
  shader = loadShader("mandelbrot.frag");
  img = createImage(width, height, RGB);
}

void draw() {
  if (app.size.x != width || app.size.y != height) {
    surfaceResized();
  }

  switch (app.renderMode) {
  case PrecisionHardware:
    final float mantissaX = (float) Math.floor(app.worldAnchorPoint[0]);
    final float mantissaY = (float) Math.floor(app.worldAnchorPoint[1]);
    shader.set("worldAnchorPointX", mantissaX, (float) (app.worldAnchorPoint[0] - mantissaX));
    shader.set("worldAnchorPointY", mantissaY, (float) (app.worldAnchorPoint[1] - mantissaY));
  case Hardware:
    shader.set("worldAnchorPoint", (float) app.worldAnchorPoint[0], (float) app.worldAnchorPoint[1]);
    
    shader.set("unitToPixelRatio", app.unitToPixelRatio);
    shader.set("maxIterations", app.maxIterations);
    shader.set("cardioidCheck", app.cardioidCheck);
    shader.set("precisionMode", app.renderMode == RenderMode.PrecisionHardware);

    shader(shader);
    image(img, 0, 0);
    break;
  case Software:
    loadPixels();
    prepareThreadsForWork();
    app.isFrameRequested = true;

    while (!allThreadsDone()) {
      // no-op
      delay(1);
    }

    app.isFrameRequested = false;
    updatePixels();
    break;
  }

  if (app.index % 20 == 0) {
    System.out.println(frameRate);
  }

  app.index++;
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
    app.renderMode = RenderMode.next(app.renderMode);
    System.out.println(String.format("Render Mode: %s", app.renderMode));
    break;
  }
}

void surfaceResized() {
  app.size.set(width, height);

  startThreads();
  img.resize(width, height);
}
