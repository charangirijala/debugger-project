public class ContactController {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    throw new AuraHandledException('test Exception');
    //return [SELECT FirstName, LastName, Email FROM Contact];
  }
}