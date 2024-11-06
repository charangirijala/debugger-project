trigger contactDescriptionUpdate on Contact(after insert, after update) {
  if (Trigger.isAfter) {
    List<Contact> descUpdatedContacts = new List<Contact>();
    for (Contact c : Trigger.new) {
      String cDesc = c.Description;
      if (cDesc != Trigger.oldMap.get(c.Id).Description) {
        descUpdatedContacts.add(c);
      }
    }
    List<Account> forUpdateAcs = new List<Account>();
    for (Contact c : descUpdatedContacts) {
      Account ac = [
        SELECT Id, Description
        FROM Account
        WHERE Id = :c.AccountId
      ];
      if (ac != null) {
        ac.Description = c.Description;
        forUpdateAcs.add(ac);
      }
    }

    update forUpdateAcs;
  }
}
