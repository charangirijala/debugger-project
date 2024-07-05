public class QueableJob implements Queueable, Finalizer {
  public void execute(QueueableContext context) {
    Account a = new Account(Name = 'Queuable Job');
    insert a;
  }

  public void execute(FinalizerContext context) {
    System.ParentJobResult result = context.getResult();
    if (result.toString() == 'SUCCESS') {
      System.debug('Job completed..');
    } else {
      System.debug('Job failed with exception' + context.getException());
    }
  }
}
