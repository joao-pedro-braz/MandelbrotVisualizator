public enum RenderMode {
  Software,
    Hardware,
    PrecisionHardware;

  static RenderMode next(RenderMode mode) {
    boolean found = false;
    for (RenderMode currentMode : RenderMode.values()) {
      if (found) {
        return currentMode;
      }

      if (currentMode == mode) {
        found = true;
      }
    }

    return RenderMode.values()[0];
  }
}

class App {

  public long unitToPixelRatio;

  public double[] worldAnchorPoint;

  public int maxIterations;

  public boolean cardioidCheck = true;

  public final MandelbrotThread[] threads;

  public final float animationSpeed = 0;

  public final PVector size = new PVector();

  public boolean isFrameRequested = false;

  public RenderMode renderMode = RenderMode.Software;

  public int index = 0;

  public App(long unitToPixelRatio, double[] worldAnchorPoint, int nrThreads, int maxIterations) {
    this.unitToPixelRatio = unitToPixelRatio;
    this.worldAnchorPoint = worldAnchorPoint;
    this.maxIterations = maxIterations;

    this.threads = new MandelbrotThread[nrThreads];
  }
}
