public class UpdateAccountFields implements Database.Batchable<SObject> {
  public final String Query;
  public final String Entity;
  public final String Field;
  public final String Value;
  public UpdateAccountFields(String q, String e, String f, String v) {
    Query = q;
    Entity = e;
    Field = f;
    Value = v;
  }

  public Database.QueryLocator start(Database.BatchableContext ctx) {
    return Database.getQueryLocator(Query);
  }

  public void execute(Database.BatchableContext ctx, List<SObject> scope) {
    for (SObject s : scope) {
      s.put(Field, Value);
    }

    update scope;
  }

  public void finish(database.BatchableContext ctx) {
  }
}
