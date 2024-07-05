public class OlderAccountsUtility {
    public static void updateOlderAccounts() {
        Account[] oldAccounts=[SELECT Id,Description FROM Account ORDER BY CreatedDate ASC LIMIT 5];

        for ( Account acc: oldAccounts) {
            acc.Description='Heritage Account';
        }

        Database.SaveResult[] results=Database.update(oldAccounts);

        for(Database.SaveResult res:results){
            if(res.isSuccess()){
                System.debug('Success Id-->'+res.id);
            }else{
                System.debug('Error'+res.getErrors());
            }
        }
    }
}