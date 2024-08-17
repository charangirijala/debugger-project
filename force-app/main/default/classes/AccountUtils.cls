public class AccountUtils {
  public static List<Account> accountsByState(String billingAbbrevation) {
    return [
      SELECT Id, Name
      FROM Account
      WHERE BillingState = :billingAbbrevation
    ];
  }
}