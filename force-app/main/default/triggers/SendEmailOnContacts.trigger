// When the account is updated, send an email to the account owner with the details of contact modified between the last update of account vs current update.
trigger SendEmailOnContacts on Account(after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      Map<Id, Datetime> AcsMap = new Map<Id, Datetime>();
      for (Account ac : Trigger.old) {
        AcsMap.put(ac.Id, ac.LastModifiedDate);
      }

      Map<Id, List<Contact>> emailSentDetails = new Map<Id, List<Contact>>();
      for (Contact con : [
        SELECT Id, Name, Email, LastModifiedDate, AccountId
        FROM Contact
        WHERE AccountId IN :AcsMap.keySet()
      ]) {
        if (con.LastModifiedDate > AcsMap.get(con.AccountId)) {
          if (emailSentDetails.containsKey(con.AccountId)) {
            List<Contact> conList = emailSentDetails.get(con.AccountId);
            conList.add(con);
            emailSentDetails.put(con.AccountId, conList);
          } else {
            emailSentDetails.put(con.AccountId, new List<Contact>{ con });
          }
        }
      }

      Messaging.SingleEmailMessage[] emails = new List<Messaging.SingleEmailMessage>();
      for (Id accId : emailSentDetails.keySet()) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        System.debug('Account: ' + Trigger.newMap.get(accId));
        String acOwner = Trigger.newMap.get(accId).OwnerId;
        String[] toAdd = new List<String>{ acOwner };
        String body = 'Dear Account Owner, Pls find the list of contacts modified';
        for (Contact con : emailSentDetails.get(accId)) {
          String contactInfo =
            'Name= ' +
            con.Name +
            ' Email: ' +
            con.email +
            '\n';
          body += contactInfo;
        }
        email.setToAddresses(toAdd);
        email.setSubject('Contacts Modified');
        email.setPlainTextBody(body);
        emails.add(email);
      }

      Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
    }
  }

}
