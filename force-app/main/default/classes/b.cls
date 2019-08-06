public class b implements  Database.Batchable<SObject>,Database.AllowsCallouts{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT id FROM user WHERE IsActive=true limit 1');
    }
    public void execute(Database.BatchableContext bc, List<User> users) {
        new Http().send(new HttpRequest());
    }
    public void finish(Database.BatchableContext bc) {}
}