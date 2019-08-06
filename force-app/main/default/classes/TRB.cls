@isTest
public class TRB {
    
    public class Mock implements HttpCalloutMock {
    	protected Integer code = 200;
    	protected String status = 'OK';
    	protected String body = '{"response":{"result":"success"}}';

        /**
         * @description Returns an HTTP response for the given request.
         * @param req HTTP request for which response should be returned
         * @return mocked response
         */
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse resp = new HttpResponse();
            resp.setStatusCode(code);
            resp.setStatus(status);
            resp.setBody(body);
            return resp;
        }
    }
    
	public class q implements Queueable,Database.AllowsCallouts{
        public void execute(QueueableContext context) {
            new Http().send(new HttpRequest());
        }
    }
    
    public class q2 implements Queueable,Database.AllowsCallouts{
        public void execute(QueueableContext context) {
            Exception ex;
            try{
                mixedDML();
            } catch (Exception e) {
                ex = e;
            }
            System.assertNotEquals(null, ex, 'There should be mixed DML exception');
        }
    }
    
    private static testMethod void testQ() {
        System.enqueueJob(new q2());
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Mock());
            System.enqueueJob(new q());
        Test.stopTest();
    }
    @future(callout=true)
    public static void y() {
        new Http().send(new HttpRequest());
    }
    public static void x() {
        y();
    }
    
    private static testMethod void testF() {
        System.enqueueJob(new q2());
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Mock());
            x();
        Test.stopTest();
    }
    
    private static testMethod void testB() {
        System.enqueueJob(new q2());
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Mock());
            Database.executeBatch(new b());
        Test.stopTest();
    }
    private static void mixedDML() {
        insert new Account(Name='x');
        insert new UserRole(Name='x');
        insert new Account(Name='x');
    }
}