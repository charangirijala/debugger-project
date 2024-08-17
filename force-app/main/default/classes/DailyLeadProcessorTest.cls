@istest
public class DailyLeadProcessorTest {
  public static String CRON_EXP = '0 0 12 * * ?';
  @TestSetup
  static void setup() {
    List<Lead> records = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead temp = new Lead();
      temp.LastName = 'Test Lead ' + i;
      temp.Company = 'Lead Company ' + i;
      temp.Email = 'leademail@email.com';
      records.add(temp);
    }

    insert records;
  }

  @IsTest
  static void test() {
    Test.startTest();
    System.schedule('Test Job', '0 0 12 * * ?', new DailyLeadProcessor());
    Test.stopTest();
    list<Lead> leads = [
      SELECT Id, LeadSource
      FROM Lead
      WHERE LeadSource = 'Dreamforce' AND LastName LIKE 'Test Lead %'
    ];
    System.assertEquals(200, leads.size());
  }
}