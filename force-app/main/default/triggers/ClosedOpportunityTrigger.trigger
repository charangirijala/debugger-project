trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> tasks=new List<Task>();
    for(Opportunity op:[SELECT Id FROM Opportunity WHERE StageName='Closed Won' AND Id IN :Trigger.New]){
        System.debug('Oppty in Closed Won, Creating a new task..');
        tasks.add(new Task(WhatId=op.Id,Subject='Follow Up Test Task'));
    }
    
    insert tasks;
}