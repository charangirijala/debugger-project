@isTest
public class AddPrimaryContactTest {
  @TestSetup
  static void setup() {
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < 50; i++) {
      String acName = 'Test Account - ' + i;
      accounts.add(new Account(Name = acName, BillingState = 'NY'));
    }
    for (Integer i = 0; i < 50; i++) {
      String acName = 'Test Account - ' + i;
      accounts.add(new Account(Name = acName, BillingState = 'CA'));
    }
    insert accounts;
  }

  static testMethod void testQueuable() {
    Contact con = new Contact(LastName = 'Test Contact');
    AddPrimaryContact testInstance = new AddPrimaryContact(con, 'CA');
    Test.startTest();
    System.enqueueJob(testInstance);
    Test.stopTest();
    System.assertEquals(
      50,
      [
        SELECT COUNT()
        FROM Contact
        WHERE
          Account.Name LIKE 'Test Account -%'
          AND Account.BillingState = 'CA'
      ]
    );
  }
}
