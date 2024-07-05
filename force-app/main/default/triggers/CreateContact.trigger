trigger CreateContact on Candidate__c(after insert) {
  CreateContactFromCan.createContact(Trigger.new);
}
