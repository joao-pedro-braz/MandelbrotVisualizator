class App {

  public long unitToPixelRatio;

  public double[] worldAnchorPoint;

  public int maxIterations;

  public boolean cardioidCheck = true;

  public final boolean[] threadsDone;

  public final boolean[] threadsAckowledged;

  public final Thread[] threads;

  public final ArrayList<Runnable> actions = new ArrayList<>();

  public final float animationSpeed = 0;

  public boolean isFrameRequested = false;

  public boolean shaderMode = true;

  public int index = 0;

  public App(long unitToPixelRatio, double[] worldAnchorPoint, int nrThreads, int maxIterations) {
    this.unitToPixelRatio = unitToPixelRatio;
    this.worldAnchorPoint = worldAnchorPoint;
    this.maxIterations = maxIterations;

    this.threadsDone = new boolean[nrThreads];
    this.threadsAckowledged = new boolean[nrThreads];
    this.threads = new Thread[nrThreads];
  }
}
