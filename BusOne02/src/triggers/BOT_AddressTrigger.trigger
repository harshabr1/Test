/*
Name            : BOT_AddressTrigger
Created By      : Sreenivasulu A
Created Date    : 06-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Account ID by comparing BOT Entity ID.

Modified By     :Harsha BR
Modified date   :14-SEP-2018
Reason          :Added comments and modified the code to follow the salesforce standard best practices.
*/
trigger BOT_AddressTrigger on Address_vod__c (before insert) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
        List<Address_vod__c> lstAddress = new List<Address_vod__c>();	//To store a list of Address records
        Set<Decimal> setAccountIds = new Set<Decimal>();				//To store unique BOT Entity Ids
        
        //Validating Entity Id in each account and add entity Id to a set
        //Entity Id is a mandatory field for BOT records
        for(Address_vod__c objAddress : Trigger.new)
        {
            if(objAddress.BOT_Entity_ID__c != null)
            {
            	setAccountIds.add(objAddress.BOT_Entity_ID__c);
                lstAddress.add(objAddress);
            }
        }
        
        if(lstAddress.size() > 0)
        {
        	BOT_AddressTriggerHandler.populateAccountId(lstAddress, setAccountIds);  
        }
    }
}