public with sharing class CreateContactFromCan {
  //Declare a method that returns void and accepts a Candidate list named candsFromTrigger
  public static void createContact(List<Candidate__c> candsFromTrigger) {
    List<Account> candAccts = [
      SELECT Id, Name
      FROM Account
      WHERE Name = 'Recruiting'
    ];
    //Instantiate a Contact list named conList
    List<Contact> conList = new List<Contact>();
    //Declare a list FOR loop that uses an iteration variable named currentCandidate
    //to loop through the candsFromTrigger list
    for (Candidate__c currentCandidate : candsFromTrigger) {
      //Create a Contact and add it to conList
      //Set the FirstName, LastName, and Email attributes to match the
      //corresponding attributes of the currentCandidate object (First_Name__c,
      //Last_Name__c, and Email__c)
      conList.add(
        new Contact(
          //Set the AccountId for the contact(we'll do this in the next unit)
          AccountId = candAccts[0].Id,
          FirstName = currentCandidate.First_Name__c,
          LastName = currentCandidate.Last_Name__c,
          Email = currentCandidate.Email__c
        )
      );
    }
    //Save conList to the database
    Database.insert(conList);
  }
}