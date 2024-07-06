@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
  @HttpGet
  global static Account getAccount() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String accId = req.requestURI.substringBetween('Accounts/', '/contacts');
    Account ac = [
      SELECT Id, Name, (SELECT Id, Name FROM Contacts)
      FROM Account
      WHERE Id = :accId
    ];
    return ac;
  }
}
