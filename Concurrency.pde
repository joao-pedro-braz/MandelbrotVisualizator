void startThreads() { //<>//
  final int threadsLength = app.threads.length;
  final int pixelsPerThread = width * height / threadsLength;
  final int leftoverPixels = (width * height) - (pixelsPerThread * threadsLength);

  int threadIndex = 0;
  for (MandelbrotThread thread : app.threads) {
    if (thread != null) {
      thread.interrupt();
    }

    final int start = threadIndex * pixelsPerThread;
    final int end = (threadIndex + 1) * pixelsPerThread +
      (threadIndex + 1 == threadsLength ? leftoverPixels : 0);

    thread = new MandelbrotThread(start, end);

    thread.start();

    app.threads[threadIndex] = thread;
    threadIndex++;
  }
}

void prepareThreadsForWork() {
  for (MandelbrotThread thread : app.threads) {
    thread.isAckowledged = false;
    thread.isDone = false;
  }
}

boolean allThreadsDone() {
  boolean allDone = true;

  for (MandelbrotThread thread : app.threads) {
    if (!thread.isDone) {
      allDone = false;
      break;
    }
  }

  return allDone;
}
