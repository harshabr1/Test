/*
Name            : BOT_TheraClassTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 25-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a helper class of BOT_TheraClassTrigger trigger.
*/

public with sharing class BOT_TheraClassTriggerHandler 
{
	public static void populateSpecialtyProviderIds(List<BOT_Thera_Class__c> lstTheraClass)
    {
    	Set<Decimal> setSpecialtyProviderIds = new Set<Decimal>();			//To store BOT Specialty Provider Ids
        Map<Decimal,Id> mapSpecialtyProviderIds = new Map<Decimal, Id>();	//To store BOT Specialty ProviderId and Salesforce Specialty Provider Id
        
        //Creating a set of BOT SPP Ids
        for(BOT_Thera_Class__c objTheraClass : lstTheraClass)
        {
       		setSpecialtyProviderIds.add(objTheraClass.BOT_Specialty_Provider_ID__c);
        }
        
        //Retrieveing SFDC Account Id by comparing BOT_Entity_Id__c with SPP Id and put it in map
        for(Account objAccount : [select Id, BOT_Entity_Id__c from Account where BOT_Entity_Id__c in : setSpecialtyProviderIds LIMIT 50000])
        {
        	mapSpecialtyProviderIds.put(objAccount.BOT_Entity_Id__c, objAccount.Id);
        }
        
       	//Updating BOT_Specialty_Provider__c field with SFDC Account Id
        for(BOT_Thera_Class__c objTheraClass : lstTheraClass)
        {
            objTheraClass.BOT_Specialty_Provider__c = mapSpecialtyProviderIds.get(objTheraClass.BOT_Specialty_Provider_ID__c);
        }    
    }
}