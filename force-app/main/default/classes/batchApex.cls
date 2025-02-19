public class batchApex implements Database.batchable<sobject>,Database.stateful{
    
    public integer i=0;

    public database.querylocator start(database.batchablecontext bc){
        system.debug('started');
        return database.getQueryLocator('select id from account');
    }
    
    public void execute(database.batchablecontext bc,List<account> scope){
        i=i+1;
       system.enqueuejob(new queueableClass(i));
    }
    
    public void finish(database.batchableContext bc){
        system.debug('finished');
    }
    
    public void  start(list<account> acc){
        
    }


}