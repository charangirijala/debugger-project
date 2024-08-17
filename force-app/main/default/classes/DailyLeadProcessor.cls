public class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Lead> leads = [
      SELECT Id, LeadSource
      FROM Lead
      WHERE LeadSource = NULL
      LIMIT 200
    ];
    for (Lead ld : leads) {
      ld.LeadSource = 'Dreamforce';
    }

    update leads;
  }
}