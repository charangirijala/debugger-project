@istest
public class AccountProcessorTest {
  @istest
  static void test() {
    Account newAccount = new Account(Name = 'Test Account');
    insert newAccount;

    Contact c = new Contact();
    c.FirstName = 'Bob';
    c.LastName = 'Willie';
    c.AccountId = newAccount.Id;

    Contact c2 = new Contact();
    c2.FirstName = 'Tom';
    c2.LastName = 'Cruise';
    c2.AccountId = newAccount.Id;

    List<Id> accIds = new List<Id>{ newAccount.id };
    Test.startTest();
    AccountProcessor.countContacts(accIds);
    Test.stopTest();
  }
}