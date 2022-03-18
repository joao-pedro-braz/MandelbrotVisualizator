double[] toWorld(int x, int y) {
  return new double[]{
    (double) x / app.unitToPixelRatio,
    (double) y / app.unitToPixelRatio
  };
}

double[] toWorldCamera(double[] worldPoint) {
  return new double[]{
    worldPoint[0] + app.worldAnchorPoint[0],
    worldPoint[1] + app.worldAnchorPoint[1]
  };
}
