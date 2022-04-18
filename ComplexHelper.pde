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

long[] doubleToLongPair(double number) {
  final long integerPart = (long) number;
  final String decimalPart = String.valueOf(number - integerPart)
    .split("\\.")[1];
  final long lengthDecimalPart = (long) Math.pow(10, decimalPart.length());

  return new long[]{ integerPart, Long.valueOf(decimalPart) * Long.signum(integerPart), lengthDecimalPart };
}
