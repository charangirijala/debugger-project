public class BankAcct {
  private Integer balance = 0;
  public String acctName;
  public String accttype;

  public void makeDeposit(Integer deposit) {
    balance += deposit;
  }

  public Integer getBalance() {
    return balance;
  }
}