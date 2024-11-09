trigger updateAccountOnOpp on Opportunity(
  after insert,
  after update,
  after delete,
  after undelete
) {
  Set<Id> accountIds = new Set<Id>();

  // Collect Account IDs from the Opportunities in the trigger context
  if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
    for (Opportunity opp : Trigger.new) {
      if (opp.AccountId != null) {
        accountIds.add(opp.AccountId);
      }
    }
  }
  if (Trigger.isUpdate || Trigger.isDelete) {
    for (Opportunity opp : Trigger.old) {
      if (opp.AccountId != null) {
        accountIds.add(opp.AccountId);
      }
    }
  }

  // Query for the highest amount Opportunity for each Account
  Map<Id, Opportunity> highestOpportunities = new Map<Id, Opportunity>();
  for (Opportunity opp : [
    SELECT Id, Name, Amount, AccountId
    FROM Opportunity
    WHERE AccountId IN :accountIds
    ORDER BY Amount DESC
  ]) {
    if (!highestOpportunities.containsKey(opp.AccountId)) {
      highestOpportunities.put(opp.AccountId, opp);
    }
  }

  // Update Account descriptions
  List<Account> accountsToUpdate = new List<Account>();
  for (Id accId : accountIds) {
    Opportunity highestOpp = highestOpportunities.get(accId);
    if (highestOpp != null) {
      accountsToUpdate.add(
        new Account(
          Id = accId,
          Description = 'Highest value opportunity: ' +
            highestOpp.Name +
            ' - Amount: ' +
            highestOpp.Amount
        )
      );
    }
  }

  if (!accountsToUpdate.isEmpty()) {
    update accountsToUpdate;
  }
}
