trigger AccountAddressTrigger on Account (before insert,before update) {    
    //[SELECT Id,Match_Billing_Address__c,ShippingPostalCode,BillingPostalCode FROM Account WHERE Id IN :Trigger.new]
    For (Account a:Trigger.New){
        if(a.Match_Billing_Address__c){
            a.ShippingPostalCode=a.BillingPostalCode;
            System.debug('BillingPostalCode:'+a.BillingPostalCode);
            System.debug('ShippingPostalCode:'+a.ShippingPostalCode);
           
        }
        else{
           	System.debug('Do nothing');
        }
    }
}