@istest
public class TestClass {
  static testMethod void test() {
    Test.startTest();
    Account a = new Account();
    a.Name = 'testScheduledApexFromTestMethod';
    insert a;

    String jobId = system.schedule(
      'testBasicScheduledApex',
      TestScheduledApexFromTestMethod.CRON_EXP,
      new TestScheduledApexFromTestMethod()
    );

    CronTrigger ct = [
      SELECT Id, CronExpression, TimesTriggered, NextFireTime
      FROM CronTrigger
      WHERE id = :jobId
    ];
    System.assertEquals(
      TestScheduledApexFromTestMethod.CRON_EXP,
      ct.CronExpression
    );

    // Verify the job has not run
    System.assertEquals(0, ct.TimesTriggered);

    System.assertNotEquals(
      'testScheduledApexFromTestMethodUpdated',
      [SELECT id, name FROM account WHERE id = :a.id].name
    );
    Test.stopTest();

    System.assertEquals(
      'testScheduledApexFromTestMethodUpdated',
      [SELECT Id, Name FROM Account WHERE Id = :a.Id].Name
    );
  }
}
