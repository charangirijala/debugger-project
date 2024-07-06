@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
  @HttpGet
  global static Account doGet() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    System.debug(req);
    System.debug(res);
    String accountId = req.requestURI.substring(
      req.requestURI.lastIndexOf('/') + 1
    );
    Account ac = [
      SELECT Id, Name, Phone, Website
      FROM Account
      WHERE Id = :accountId
    ];
    return ac;
  }
  @HttpPost
  global static String doPost(String name, String phone, String website) {
    Account ac = new Account();
    ac.Name = name;
    ac.Phone = phone;
    ac.Website = website;
    insert ac;
    return ac.Id;
  }

  @HttpDelete
  global static void doDelete() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    String accountId = req.requestURI.substring(
      req.requestURI.lastIndexOf('/') + 1
    );
    Account ac = [SELECT Id FROM Account WHERE Id = :accountId];

    delete ac;
  }
}
