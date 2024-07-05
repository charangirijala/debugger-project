trigger HelloWorldTrigger on Account (before insert,before update) {
    for(Account a:Trigger.new){
        //commented code
        //a.Description='New description';
        //System.debug('Description changed');
    }
}