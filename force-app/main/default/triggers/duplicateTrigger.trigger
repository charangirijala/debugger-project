trigger duplicateTrigger on Account(before insert, before update) {
  Set<String> accNames = new Set<String>();

  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    if (!Trigger.new.isEmpty()) {
      for (Account acc : Trigger.new) {
        accNames.add(acc.Name);
      }
    }
  }

  List<Account> accList = [
    SELECT Id, Name
    FROM Account
    WHERE Name IN :accNames
  ];

  Map<String, Account> existingAccMap = new Map<String, Account>();

  if (!accList.isEmpty()) {
    for (Account accObj : accList) {
      existingAccMap.put(accObj.Name, accObj);
    }
  }

  if (!Trigger.new.isEmpty()) {
    for (Account existingAcc : Trigger.new) {
      if (existingAccMap.containsKey(existingAcc.Name)) {
        existingAcc.addError('Account name already exists');
      }
    }
  }
}
