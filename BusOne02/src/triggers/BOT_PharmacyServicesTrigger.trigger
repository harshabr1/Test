/*
Name            : BOT_PharmacyServicesTrigger
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc. It is used to populate the SFDC Entity ID by comparing BOT Entity ID.
				  It also creates junction object records (Account to PBM linking) on child account object.
*/

trigger BOT_PharmacyServicesTrigger on BOT_Pharmacy_Service__c (before insert, after insert, after delete) 
{
    //To populate the SFDC Entity ID by comparing BOT Entity ID.
    if(Trigger.isInsert && Trigger.isBefore)
    {
    	BOT_PharmacyServicesTriggerHandler.populateAccountAndPbmIds(Trigger.new); 
    }
    
    //To create junction object records (Account to PBM linking) on child account object.
    if(Trigger.isInsert && Trigger.isAfter)
    {
        List<BOT_Pharmacy_Service__c> lstPharmacyServices = new List<BOT_Pharmacy_Service__c>();
    	for(BOT_Pharmacy_Service__c objPharmacyServices : Trigger.new)
    	{
        	if(objPharmacyServices.name == 'Formulary development/Admin' && objPharmacyServices.BOT_Account__c != null && objPharmacyServices.BOT_PBM_Name__c != null)
        	{
        		lstPharmacyServices.add(objPharmacyServices);   
        	}
        }
    	if(lstPharmacyServices.size() > 0)
    	{
        	BOT_PharmacyServicesTriggerHandler.createChildAccounts(lstPharmacyServices); 
    	}
    }
    
    /*
    if(Trigger.isDelete && Trigger.isBefore)
    {
        List<BOT_Pharmacy_Service__c> lstPharmacyServices = new List<BOT_Pharmacy_Service__c>();
    	for(BOT_Pharmacy_Service__c objPharmacyServices : Trigger.new)
    	{
        	if(objPharmacyServices.name == 'Formulary development/Admin' && objPharmacyServices.BOT_Account__c != null && objPharmacyServices.BOT_PBM_Name__c != null)
        	{
        		lstPharmacyServices.add(objPharmacyServices);   
        	}
        }
    	if(lstPharmacyServices.size() > 0)
    	{
        	BOT_PharmacyServicesTriggerHandler.deleteChildAccounts(lstPharmacyServices); 
        }
    }
	*/
}