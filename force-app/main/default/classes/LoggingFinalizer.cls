public class LoggingFinalizer implements Queueable, Finalizer {
  public void execute(QueueableContext ctx) {
    String jobId = '' + ctx.getJobId();
    System.debug('Begin: executing queuable job: ' + jobId);
    try {
      LoggingFinalizer f = new LoggingFinalizer();
      System.attachFinalizer(f);
      f.addLog('About to do some work...', jobId);
      Integer accCount = 0;
      while (true) {
        Account ac = new Account(Name = 'JustofDMLException');
        accCount++;
        insert ac;
      }
    } catch (Exception e) {
      System.debug(
        'Error executing the job [' + jobId + ']: ' + e.getMessage()
      );
    } finally {
      System.debug('Completed: execution of queueable job: ' + jobId);
    }
  }

  private List<LogMessage__c> logRecords = new List<LogMessage__c>();
  public void execute(FinalizerContext ctx) {
    String parentJobId = ctx.getAsyncApexJobId();
    System.debug(
      'Begin: executing finalizer attached to queueable job: ' + parentJobId
    );
    System.Debug('Updating job id on ' + logRecords.size() + ' log records');
    for (LogMessage__c log : logRecords) {
      log.Name = parentJobId;
    }
    System.debug('Comitting log records to database');
    Database.insert(logRecords, false);

    if (ctx.getResult() == ParentJobResult.SUCCESS) {
      System.debug(
        'Parent queueable job [' + parentJobId + '] completed successfully.'
      );
    } else {
      System.debug(
        'Parent queueable job [' +
          parentJobId +
          '] failed due to unhandled exception: ' +
          ctx.getException().getMessage()
      );
      System.debug('Enqueueing another instance of the queueable...');
    }
    System.debug(
      'Completed: execution of finalizer attached to queueable job: ' +
      parentJobId
    );
  }

  public void addLog(String message, String source) {
    LogMessage__c instance = new LogMessage__c(
      DateTime__c = DateTime.now(),
      Name = 'setbeforecommit',
      Message__c = message,
      Source__c = source
    );

    logRecords.add(instance);
  }
}