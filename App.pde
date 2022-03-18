class App {

  public long unitToPixelRatio;

  public double[] worldAnchorPoint;
  
  public int maxIterations;
  
  public boolean cardioidCheck = true;

  public final boolean[] threadsDone;

  public final boolean[] threadsAckowledged;
  
  public final ArrayList<Runnable> actions = new ArrayList<>();
  
  public boolean isFrameRequested = false;

  public App(long unitToPixelRatio, double[] worldAnchorPoint, int nrThreads, int maxIterations) {
    this.unitToPixelRatio = unitToPixelRatio;
    this.worldAnchorPoint = worldAnchorPoint;
    this.maxIterations = maxIterations;

    this.threadsDone = new boolean[nrThreads];
    this.threadsAckowledged = new boolean[nrThreads];
  }
}
