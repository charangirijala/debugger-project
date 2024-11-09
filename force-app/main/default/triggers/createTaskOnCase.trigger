//whenever create task checkbox gets checked for case on an Account a follow up task Should Automatically gets created on the primary contact of account
trigger createTaskOnCase on case(after insert, after update) {
  if (Trigger.isAfter) {
    Map<Id, Case> usefulCases = new Map<Id, Case>();
    for (Case c : Trigger.new) {
      if (c.Create_Task__c == true) {
        if (
          Trigger.oldMap.get(c.Id).Create_Task__c == false &&
          c.AccountId != null
        ) {
          usefulCases.put(c.AccountId, c);
        }
      }
    }
    Map<Contact, Case> taskOnContacts = new Map<Contact, Case>();
    List<Task> toBeCreated = new List<Task>();
    for (Id accId : usefulCases.keySet()) {
      Contact con = [
        SELECT Id
        FROM Contact
        WHERE AccountId = :accId AND Primary_Contact__c = TRUE
        LIMIT 1
      ];

      if (con != null) {
        Task temp = new Task();
        temp.Subject = usefulCases.get(accId).Subject + 'Related Task';
        temp.WhatId = usefulCases.get(accId).Id;
        temp.WhoId = con.Id;
        toBeCreated.add(temp);
      }
    }

    if (!toBeCreated.isEmpty()) {
      insert toBeCreated;
    }
  }

}
