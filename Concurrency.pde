void startThreads() { //<>//
  final int threadsLength = app.threadsDone.length;
  final int pixelsPerThread = width * height / threadsLength;

  for (int thread = 0; thread < threadsLength; thread++) {
    if (app.threads[thread] != null) {
      app.threads[thread].interrupt();
    }

    final int threadIndex = thread;
    final int start = threadIndex * pixelsPerThread;
    final int end = (threadIndex + 1) * pixelsPerThread;

    app.threads[thread] = new Thread() {
      private boolean isInterrupted = false;

      @Override
        public void run() {
        while (!isInterrupted) {
          if (app.isFrameRequested && !app.threadsAckowledged[threadIndex]) {
            app.threadsDone[threadIndex] = false;
            app.threadsAckowledged[threadIndex] = true;

            drawMandelbrot(start, end);

            app.threadsDone[threadIndex] = true;
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
    };

    app.threads[thread].start();
  }
}

void prepareThreadsForWork() {
  for (int thread = 0; thread < app.threadsAckowledged.length; thread++) {
    app.threadsAckowledged[thread] = false;
    app.threadsDone[thread] = false;
  }
}

boolean allThreadsDone() {
  boolean allDone = true;

  for (boolean done : app.threadsDone) {
    if (!done) {
      allDone = false;
      break;
    }
  }

  return allDone;
}
