@isTest
private class AccountManagerTest {
  @isTest
  static void myUnitTest() {
    Id recordId = createTestRecord();

    RestRequest req = new RestRequest();
    req.requestURI =
      'https://wise-narwhal-sl2f6z-dev-ed.my.salesforce.com/services/apexrest/Accounts/' +
      recordId +
      '/contacts';
    req.httpMethod = 'GET';
    RestContext.request = req;

    Account result = AccountManager.getAccount();

    Assert.isTrue(result != null);
    Assert.areEqual('Test Acc', result.Name);
    List<Contact> con = [SELECT Id FROM Contact WHERE AccountId = :result.Id];
    System.assertEquals(1, con.size());
  }

  //helper method
  static Id createTestRecord() {
    Account ac = new Account(Name = 'Test Acc');
    insert ac;
    Contact con = new Contact();
    con.LastName = 'Cherry';
    con.AccountId = ac.Id;

    insert con;

    return ac.Id;
  }
}