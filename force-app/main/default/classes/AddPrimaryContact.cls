public class AddPrimaryContact implements Queueable {
  private Contact primaryContact;
  private String billingState;
  public AddPrimaryContact(Contact contact, String state) {
    primaryContact = contact;
    billingState = state;
  }
  public void execute(QueueableContext ctx) {
    List<Account> accounts = [
      SELECT Id
      FROM Account
      WHERE BillingState = :billingState
      LIMIT 200
    ];
    for (Account acc : accounts) {
      Contact clonedContact = primaryContact.clone(false, true, false, false);
      clonedContact.AccountId = acc.Id;
      insert clonedContact;
    }
  }
}