@istest
public class LeadProcessorTest {
  @TestSetup
  static void setup() {
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead temp = new Lead();
      temp.LastName = 'Lead ' + i;
      temp.Company = 'Lead Company ' + i;
      temp.Email = 'leademail@email.com';
      leads.add(temp);
    }

    insert leads;
  }

  @IsTest
  static void test() {
    Test.startTest();
    LeadProcessor lp = new LeadProcessor();
    Id batchId = Database.executeBatch(lp);
    Test.stopTest();
  }
}
