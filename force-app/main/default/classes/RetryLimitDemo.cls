public class RetryLimitDemo implements Queueable, Finalizer {
  public void execute(QueueableContext context) {
    String jobId = context.getJobId();
    System.debug('The job has started JobID: ' + jobId);
    try {
      Finalizer finalizer = new RetryLimitDemo();
      System.attachFinalizer(finalizer);
      System.debug('Attached finalizer');
      Integer accountNum = 1;
      while (true) {
        Account a = new Account();
        a.Name = 'Queueable Account Number - ' + accountNum;
        insert a;
        accountNum++;
      }
    } catch (Exception e) {
      System.debug('Error executing job :' + jobId + ' ' + e.getMessage());
    } finally {
      System.debug('Completed exection of queuable job :' + jobId);
    }
  }

  public void execute(FinalizerContext context) {
    String parentJobId = context.getAsyncApexJobId();
    System.debug(
      'Begin: Executing finalizer attached to queuable jobs: ' + parentJobId
    );
    if (context.getResult() == System.ParentJobResult.SUCCESS) {
      System.debug('Parent Queuable Job ' + parentJobId + ' completed');
    } else {
      System.debug(
        'Parent queueable job [' +
          parentJobId +
          '] failed due to unhandled exception: ' +
          context.getException().getMessage()
      );
      System.debug('Enqueueing another instance of the queueable...');
      String newJobId = System.enqueueJob(new RetryLimitDemo());
      System.debug('Enqueued new job: ' + newJobId);
    }
    System.debug(
      'Completed: execution of finalizer attached to queueable job: ' +
      parentJobId
    );
  }
}