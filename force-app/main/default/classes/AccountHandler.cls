public with sharing class AccountHandler {
    public static void insertAccount(Integer newActs) {
        List<Account> addAccounts=new List<Account>();
        Integer temp=1;
        while(temp<=newActs){
            addAccounts.add(new Account(Name='Acme Inc '+temp,AccountNumber='A000'+temp));
            temp++;
        }

        try{
            insert addAccounts;
        }catch(DmlException e){
            System.debug('Caught error. Please check'+e.getMessage());
        }
    }
}