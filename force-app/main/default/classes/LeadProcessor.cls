public class LeadProcessor implements Database.Batchable<SObject> {
  public String Query = 'SELECT FROM Lead';
  public Database.QueryLocator start(Database.BatchableContext ctx) {
    return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead');
  }
  public void execute(Database.BatchableContext ctx, List<Lead> scope) {
    for (Lead rec : scope) {
      rec.LeadSource = 'Dreamforce';
    }

    update scope;
  }
  public void finish(Database.BatchableContext ctx) {
  }
}
