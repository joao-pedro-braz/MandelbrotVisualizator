class MandelbrotThread extends Thread {

  public volatile boolean isDone = false;

  public volatile boolean isAckowledged = false;

  private volatile boolean isInterrupted = false;
  
  private int start;
  
  private int end;
  
  public MandelbrotThread(int start, int end) {
    this.start = start;
    this.end = end;
  }

  @Override
    public void run() {
    while (!isInterrupted) {
      if (app.isFrameRequested && !isAckowledged) {
        isDone = false;
        isAckowledged = true;

        drawFrame(start, end);

        isDone = true;
      } else {
        delay(1);
      }
    }
  }


  @Override
    public void interrupt() {
    super.interrupt();

    isInterrupted = true;
  }
}
