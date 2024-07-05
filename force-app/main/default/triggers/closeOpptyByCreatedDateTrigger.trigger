trigger closeOpptyByCreatedDateTrigger on Account(before update) {
  List<Opportunity> opptysToUpdate = new List<Opportunity>();
  for (Opportunity oppty : [
    SELECT Id, CreatedDate, StageName
    FROM Opportunity
    WHERE AccountId = :Trigger.new
  ]) {
    if (
      oppty.CreatedDate.date().daysBetween(Date.today()) > 30 &&
      oppty.StageName != 'Closed Won'
    ) {
      oppty.StageName = 'Closed Lost';
      opptysToUpdate.add(oppty);
    }
  }

  update opptysToUpdate;
}
