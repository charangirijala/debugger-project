public class TestScheduledApexFromTestMethod implements Schedulable {
  public static String CRON_EXP = '0 0 0 3 9 ? 2042';

  public void execute(SchedulableContext ctx) {
    CronTrigger ct = [
      SELECT Id, CronExpression, TimesTriggered, NextFireTime
      FROM CronTrigger
      WHERE Id = :ctx.getTriggerId()
    ];
    System.assertEquals(CRON_EXP, ct.CronExpression);
    System.assertEquals(0, ct.TimesTriggered);
    Account a = [
      SELECT Id, Name
      FROM Account
      WHERE Name = 'testScheduledApexFromTestMethod'
    ];
    a.Name = 'testScheduledApexFromTestMethodUpdated';

    update a;
  }
}
