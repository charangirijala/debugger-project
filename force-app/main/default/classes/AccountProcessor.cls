public class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    List<Account> accs = [
      SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts)
      FROM Account
      WHERE Id = :accountIds
    ];
    for (Account ac : accs) {
      ac.Number_Of_Contacts__c = ac.Contacts.size();
    }

    update accs;
  }
}
