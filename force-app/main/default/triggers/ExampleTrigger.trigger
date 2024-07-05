trigger ExampleTrigger on Contact (after insert,after delete) {
    if(Trigger.isInsert){
        Integer count=Trigger.new.size();
        EmailManager.sendMail('girijalac@gmail.com','Contacts Creation Alert','Hi, This is to inform that '+count+'have been inserted.');
    }
    else if(Trigger.isDelete){
        
    }
}