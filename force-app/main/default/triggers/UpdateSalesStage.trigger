trigger UpdateSalesStage on Account(after update) {
  Set<Id> accIds = new Set<Id>();
  if (Trigger.isAfter && Trigger.isUpdate) {
    if (!Trigger.new.isEmpty()) {
      for (Account acc : Trigger.new) {
        accIds.add(acc.Id);
      }
    }
  }
  if (!accIds.isEmpty()) {
    List<Opportunity> listToUpdate = new List<Opportunity>();
    Date day30 = date.today() - 30; // date which is 30 days less than today
    List<Opportunity> oppList = [
      SELECT Id, AccountId, Test_Created_Date__c, Stagename
      FROM Opportunity
      WHERE AccountId IN :accIds
    ];
    if (!oppList.isEmpty()) {
      for (Opportunity oppObj : oppList) {
        if (
          oppObj.Test_Created_Date__c < day30 &&
          oppObj.Stagename != 'Closed Won'
        ) {
          oppObj.Stagename = 'Closed Lost';
          oppObj.CloseDate = date.today();
          listToUpdate.add(oppObj);
        }
      }
    }
    if (!listToUpdate.isEmpty()) {
      update listToUpdate;
    }
  }
}
