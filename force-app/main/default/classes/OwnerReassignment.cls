public class OwnerReassignment implements Database.Batchable<sObject> {
  public String query;
  public String email;
  public Id toUserId;
  public Id fromUserId;

  public Database.QueryLocator start(Database.BatchableContext ctx) {
    return Database.getQueryLocator(query);
  }

  public void execute(Database.BatchableContext ctx, List<SObject> scope) {
    List<Account> accns = new List<Account>();

    for (SObject s : scope) {
      Account a = (Account) s;
      if (a.OwnerId == fromUserId) {
        a.OwnerId = toUserId;
        accns.add(a);
      }
    }

    update accns;
  }

  public void finish(Database.BatchableContext ctx) {
    AsyncApexJob job = [
      SELECT Id, Status, NumberOfErrors
      FROM AsyncApexJob
      WHERE ParentJobId = :ctx.getJobId()
    ];

    if (job.NumberOfErrors == 0 && job.Status == 'Completed') {
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(new List<String>{ email });
      mail.setReplyTo('girijalac@gmail.com');
      mail.setSenderDisplayName('Batch Process Alerts');
      mail.setSubject('Batch Process Alert for Job: ' + job.Id);
      mail.setPlainTextBody(
        'Batch process ' +
          job.Id +
          'has been completed successfully with 0 errors'
      );

      Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
    }
  }
}
