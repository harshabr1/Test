/*
Name            : BOT_AccountTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 05-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to update the RecordType ID's and
                  parent Salesforce ID's on the Child accounts.

Modified By 	:Harsha BR
Modified date 	:12-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.
*/
public with sharing class BOT_AccountTriggerHandler 
{
    //Used to autopoplate the record type Id and SFDC Parent Id.
    public static void updateRecordtypeAndParentIDs(List<Account> lstAccounts, Set<String> setAccountType)
    {
        Set<Decimal> setEntityParentIds = new Set<Decimal>();			//Used to store the BOT parent Entity ID's
        Map<String, Id> mapRecordtypeIds = new Map<String, Id>();		//Used to store the Record type name and its associated salesforce ID
        Map<Decimal, Id> mapEntityParentIds = new Map<Decimal, Id>();	//Used to store the BOT Entity ID and its associated salesforce ID
        List<String> lstAccountType = new List<String>(); 				//Used to store Account types
        
        //Creating a set of channels and a set of BOT Entity Ids
        for(Account objAccount : lstAccounts)
        {
            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
                setEntityParentIds.add(objAccount.BOT_Parent_Entity_ID__c);
            }
        }
        
        for(String accountType : setAccountType)
        {
        	lstAccountType.add('BOT '+accountType);            
        }
        
        lstAccountType.add('BOT Commercial');
        
        //To Retrieve SFDC RecordTypeId by comparing Account, Channel and put in a map
        for(RecordType objRecordTypeId : [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Account' AND Name in : lstAccountType LIMIT 50000])
        {
            mapRecordtypeIds.put(objRecordTypeId.Name, objRecordTypeId.Id);
        }
		
        if(setEntityParentIds != null)
        {
        	//To Retrieve SFDC Parent Id by comparing BOT parent Entity Id and put in a map
        	for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setEntityParentIds LIMIT 50000])
        	{
            	mapEntityParentIds.put(objAccount.BOT_Entity_Id__c, objAccount.Id);
        	}
        }
       	//Updating appropriate reoctdTypeId by comparing the channel
        for(Account objAccount : lstAccounts)
        {             
            objAccount.BOT_Is_BOT_Data__c = true;
            if(objAccount.Account_Type__c == 'Medicare' || objAccount.Account_Type__c == 'MCO' || objAccount.Account_Type__c == 'Stand-Alone Medicare' || objAccount.Account_Type__c == 'EGWP' || objAccount.Account_Type__c == 'Stand Alone Hix' || objAccount.Account_Type__c == 'VA')
            {
                //objAccount.RecordTypeId=Label.BOT_Commercial_RT;
                objAccount.RecordTypeId=mapRecordtypeIds.get('BOT Commercial');
                //objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('BOT Commercial').getRecordTypeId();
            }
            else
            {
                objAccount.RecordTypeId = mapRecordtypeIds.get('BOT '+objAccount.Account_Type__c);
                //objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(objAccount.Account_Type__c).getRecordTypeId();
            }

            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
            	objAccount.ParentId = mapEntityParentIds.get(objAccount.BOT_Parent_Entity_ID__c);
            	objAccount.Primary_Parent_vod__c = objAccount.ParentId;
            }
        }
    }
    
    //Used to autopoplate the SFDC Parent Id's.
    /*
    public static void updateParentIDs()
    {
        Set<Decimal> setEntityParentIds = new Set<Decimal>();			//Used to store the BOT parent Entity ID's
        Map<Decimal, Id> mapEntityParentIds = new Map<Decimal, Id>();	//Used to store the BOT Entity ID and its associated salesforce ID
        List<Account> lstAccounts;

        lstAccounts = [select Id, ParentId, Primary_Parent_vod__c, BOT_Parent_Entity_ID__c from Account where BOT_Parent_Entity_ID__c != null and Primary_Parent_vod__c = null];
        if(lstAccounts.size() > 0 && lstAccounts != null)
        {
        //Creating a set of channels and a set of BOT Entity Ids
        for(Account objAccount : lstAccounts)
        {
            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
                setEntityParentIds.add(objAccount.BOT_Parent_Entity_ID__c);
            }
        }
        //To Retrieve SFDC Parent Id by comparing BOT parent Entity Id and put in a map
        for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setEntityParentIds LIMIT 50000])
        {
            mapEntityParentIds.put(objAccount.BOT_Entity_Id__c, objAccount.Id);
        }
        
        //Updating appropriate reoctdTypeId by comparing the channel
        for(Account objAccount : lstAccounts)
        {             
            objAccount.ParentId = mapEntityParentIds.get(objAccount.BOT_Parent_Entity_ID__c);
            objAccount.Primary_Parent_vod__c = objAccount.ParentId;
        }
        update lstAccounts;
        }
    }
	*/
}