public void drawMandelbrot(int start, int end) { //<>//
  for (int index = start; index < end; index++) {
    final int x = index % width;
    final int y = index / width;

    double[] worldPoint = toWorld(x, y);
    double[] worldCameraPoint = toWorldCamera(worldPoint);
    int iterationCount = iteratePointMandel(worldCameraPoint);

    pixels[index] = chooseColor(iterationCount, 0);
  }
}

public void panCamera(int dx, int dy) {
  final double[] worldPoint = toWorld(dx, dy);
  app.worldAnchorPoint[0] += worldPoint[0];
  app.worldAnchorPoint[1] += worldPoint[1];
}

public void zoomCamera(double deltaUnitToPixelRatio) {
  double[] mouseBeforeZoom = toWorld(mouseX, mouseY);
  app.unitToPixelRatio -= deltaUnitToPixelRatio;
  double[] mouseAfterZoom = toWorld(mouseX, mouseY);

  app.worldAnchorPoint[0] += mouseBeforeZoom[0] - mouseAfterZoom[0];
  app.worldAnchorPoint[1] += mouseBeforeZoom[1] - mouseAfterZoom[1];
}

private int iteratePointMandel(double[] worldCameraPoint) {
  double x, y;

  if (app.cardioidCheck) {
    // https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Cardioid_/_bulb_checking
    x = worldCameraPoint[0];
    y = worldCameraPoint[1];

    final double q = (x - 0.25) * (x - 0.25) + y * y;

    if (q * (q + (x - 0.25)) <= (y * y) * 0.25) {
      return app.maxIterations;
    }
  }

  // https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Optimized_escape_time_algorithms
  int iterCount = 0;
  double x2 = 0.0D, y2 = 0.0D;

  x = 0.0D;
  y = 0.0D;
  while (x2 + y2 <= 4.0D && iterCount < app.maxIterations) {
    y = (x + x) * y + worldCameraPoint[1];
    x = x2 - y2 + worldCameraPoint[0];

    x2 = x * x;
    y2 = y * y;

    iterCount++;
  }

  return iterCount;
}


private int chooseColor(int iterationCount, double animationStep) {
  final int adjustedCount = (int) ((iterationCount + animationStep) % app.maxIterations);
  return color((adjustedCount % 16), (adjustedCount % 170), adjustedCount % 85);
}
