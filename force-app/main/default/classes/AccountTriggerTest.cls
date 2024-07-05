@istest
public class AccountTriggerTest {
  @IsTest
  static void test() {
    List<Account> testAccs = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      Account testAc = new Account();
      testAc.Name = 'Test Account --' + i;
      testAccs.add(testAc);
    }
    Test.startTest();
    insert testAccs;
    Test.stopTest();
    //verify accounts
    List<Account> accs = [
      SELECT Id, ShippingState, BillingState
      FROM Account
      WHERE Name LIKE 'Test Account -%'
    ];
    System.assertEquals(200, accs.size());
    //verify shippingstate
    Integer count = 0;
    for (Account ac : accs) {
      if (ac.ShippingState == ac.BillingState)
        count++;
    }
    System.assertEquals(200, count);
  }
}
