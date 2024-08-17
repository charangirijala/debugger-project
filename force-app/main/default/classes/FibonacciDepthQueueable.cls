public class FibonacciDepthQueueable implements Queueable {
  private Long nMinus1, nMinus2;
  public static void calculateFibonacci(Integer depth) {
    AsyncOptions options = new AsyncOptions();
    options.MaximumQueueableStackDepth = depth;
    System.enqueueJob(new FibonacciDepthQueueable(null, null), options);
  }
  FibonacciDepthQueueable(Long param1, Long param2) {
    nMinus1 = param1;
    nMinus2 = param2;
  }
  public void execute(QueueableContext context) {
    Integer currentDepth = AsyncInfo.getCurrentQueueableStackDepth();

    Long fibonacciSequenceStep;

    switch on (currentDepth) {
      when 1, 2 {
        fibonacciSequenceStep = 1;
      }
      when else {
        fibonacciSequenceStep = nMinus1 + nMinus2;
      }
    }
    System.debug(
      'Current depth: ' +
        currentDepth +
        'fibonacciSequenceStep: ' +
        fibonacciSequenceStep
    );

    if (
      AsyncInfo.hasMaxStackDepth() &&
      AsyncInfo.getCurrentQueueableStackDepth() >=
      AsyncInfo.getMaximumQueueableStackDepth()
    ) {
      String accName =
        '#LAST Account Depth - ' +
        currentDepth +
        ' fibonacciSequenceStep - ' +
        fibonacciSequenceStep;
      Account ac = new Account(Name = accName);
      insert ac;
    } else {
      String accName =
        'Account Depth - ' +
        currentDepth +
        ' fibonacciSequenceStep - ' +
        fibonacciSequenceStep;
      Account ac = new Account(Name = accName);
      insert ac;
      System.enqueueJob(
        new FibonacciDepthQueueable(fibonacciSequenceStep, nMinus1)
      );
    }
  }
}