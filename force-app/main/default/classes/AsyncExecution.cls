public class AsyncExecution implements Queueable {
  public void execute(QueueableContext context) {
    Account a = new Account(
      Name = 'AsyncExecution Account',
      Phone = '(415) 555-1212'
    );
    insert a;

    Id jobId = context.getJobId();
    System.debug(jobId);

    AsyncApexJob job = [
      SELECT Status, NumberOfErrors
      FROM AsyncApexJob
      WHERE Id = :jobId
    ];

    System.debug(job.Status);
  }
}