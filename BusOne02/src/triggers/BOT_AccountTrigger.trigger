/*
Name            : BOT_AccountTrigger
Created By      : Sreenivasulu A
Created Date    : 05-SEP-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. It is used to update Record type Ids by the Account type (channel) and
                  update the salesforce parent Ids for the affiliated plans.                 
*/
trigger BOT_AccountTrigger on Account (before insert) 
{
    if(Trigger.isInsert || Trigger.isBefore)
    {
        Set<String> setAccountType = new Set<String>();			//To store the Account type
        List<Account> lstAccounts = new List<Account>();		//To store the list of Accounts where Entity Id and Account type not Null
        
        for(Account objAccount : Trigger.new)
        {
            //To verify Entity Id and Account type fields. These fields are mandatory for BOT records
            if(objAccount.BOT_Entity_ID__c != null && String.isNotBlank(objAccount.Account_Type__c))
            {
                setAccountType.add(objAccount.Account_Type__c);
                lstAccounts.add(objAccount);
            }
        }
        
		//If the Account records created by BOT then Entity Id will not be null
        if(lstAccounts.size() > 0)
        {
        	BOT_AccountTriggerHandler.updateRecordtypeAndParentIDs(lstAccounts, setAccountType);   
        }
    }
}