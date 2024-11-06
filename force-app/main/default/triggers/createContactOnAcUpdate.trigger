trigger createContactOnAcUpdate on Account(after insert, after update) {
  List<Account> contactCreation = new List<Account>();
  if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
    for (Account ac : Trigger.new) {
      if (ac.Create_Contact__c == true) {
        if (Trigger.isUpdate) {
          if (Trigger.oldMap.get(ac.Id).Create_Contact__c == false) {
            contactCreation.add(ac);
          }
        } else {
          contactCreation.add(ac);
        }
      }
    }
    List<Contact> toCreate = new List<Contact>();
    for (Account ac : contactCreation) {
      Contact temp = new Contact();
      temp.FirstName = ac.Name;
      temp.LastName = 'Contact';
      temp.AccountId = ac.Id;
      if (ac.Phone != null || ac.Phone != '') {
        temp.Phone = ac.Phone;
      }

      toCreate.add(temp);
    }

    if (!toCreate.isEmpty()) {
      insert toCreate;
    }
  }
}
