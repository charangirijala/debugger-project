trigger Employee on Employee__c(
  after insert,
  after update,
  after delete,
  after undelete
) {
  Set<Id> firms = new Set<Id>();
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      for (Employee__c e : Trigger.new) {
        if (
          (e.Salary__c != Trigger.oldMap.get(e.Id).Salary__c) &&
          e.Tech_Firm__c != null
        ) {
          firms.add(e.Tech_Firm__c);
        }
      }
    }
    if (Trigger.isInsert || Trigger.isUndelete) {
      for (Employee__c e : Trigger.new) {
        if (e.Salary__c != null && e.Tech_Firm__c != null) {
          firms.add(e.Tech_Firm__c);
        }
      }
    }
    if (Trigger.isDelete) {
      for (Employee__c e : Trigger.old) {
        if (e.Salary__c != null && e.Tech_Firm__c != null) {
          firms.add(e.Tech_Firm__c);
        }
      }
    }
    List<Tech_Firm__c> toUpdate = new List<Tech_Firm__c>();

    for (AggregateResult ar : [
      SELECT Tech_Firm__c, MIN(Salary__c) MinSalary, MAX(Salary__c) MaxSalary
      FROM Employee__c
      WHERE Tech_Firm__c IN :firms
      GROUP BY Tech_Firm__c
    ]) {
      Tech_Firm__c temp = new Tech_Firm__c();
      temp.Id = (Id) ar.get('Tech_Firm__c');
      temp.Min_Salary__c = (Decimal) ar.get('MinSalary');
      temp.Max_Salary__c = (Decimal) ar.get('MaxSalary');

      toUpdate.add(temp);
    }

    if (!toUpdate.isEmpty()) {
      update toUpdate;
    }
  }
}
