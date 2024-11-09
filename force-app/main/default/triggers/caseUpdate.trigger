// You need to update a custom field on the Contact object, ‘LastCaseDate’, with the date of the most recent related Case. How would you write this trigger?
trigger caseUpdate on Case(after insert, after update) {
  List<Id> cWithContacts = new List<Id>();
  if (Trigger.isAfter) {
    if (Trigger.isInsert || Trigger.isUpdate) {
      for (Case c : Trigger.new) {
        if (c.ContactId != null) {
          cWithContacts.add(c.ContactId);
        }
      }
      Map<Id, Date> conToUpdate = new Map<Id, Date>();
      for (AggregateResult ar : [
        SELECT ContactId, MAX(CreatedDate) lastDate
        FROM Case
        WHERE ContactId IN :cWithContacts
        GROUP BY ContactId
      ]) {
        conToUpdate.put((Id) ar.get('ContactId'), (Date) ar.get('lastDate'));
      }

      List<Contact> contactsToUpdate = new List<Contact>();
      for (Id contactId : cWithContacts) {
        contactsToUpdate.add(
          new Contact(
            Id = contactId,
            LastCaseDate__c = contactLastCaseDate.get(contactId)
          )
        );
      }

      update contactstoUpdate;
    }
  }
}
