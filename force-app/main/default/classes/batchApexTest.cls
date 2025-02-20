@isTest
private class batchApexTest {

    @isTest
    static void testBatchApex() {
        // Create test data
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;

        // Create an instance of the batch class
        batchApex batch = new batchApex();
        
        // Start the test
        Test.startTest();
        
        // Call the start method
        Database.BatchableContext bc = new MockBatchableContext();
        Database.QueryLocator ql = batch.start(bc);
        System.assertNotEquals(null, ql, 'The start method should return a QueryLocator.');
        
        // Call the execute method
        List<Account> scope = [SELECT Id FROM Account LIMIT 100];
        batch.execute(bc, scope);
        System.assertEquals(1, batch.i, 'The execute method should have been called once.');
        
        // Call the finish method
        batch.finish(bc);
        
        // End the test
        Test.stopTest();
        
        // Verify the results
        System.assertEquals(1, batch.i, 'The execute method should have been called once.');
    }
    
    // Mock implementation of Database.BatchableContext
    private class MockBatchableContext implements Database.BatchableContext {
        public String getChildJobId() {
            return 'mockJobId';
        }
        
        public String getJobId() {
            return 'mockJobId';
        }
    }
}