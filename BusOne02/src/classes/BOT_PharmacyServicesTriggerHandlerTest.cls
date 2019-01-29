/*
Name            : BOT_PharmacyServicesTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 21-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc.It is a test class of BOT_PharmacyServicesTriggerHandler.
*/
@isTest(seeAllData=false)
private class BOT_PharmacyServicesTriggerHandlerTest 
{
    //Testing while creating a single Pharmacy service record
    static testMethod void createPharmacyService()
    {
        Account objAccount;								//To store an Account record
        Account objPBMAccount;							//To store a PBM Account record
        BOT_Pharmacy_Service__c objPharmacyService;		//To store a Pharmacy service record

        //To create a Pharmacy service record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createPharmacyServices(1,1,1);
        
        //Querying the created test data
        objAccount = [select Id from Account where Account_Type__c = 'MCO'];
        objPBMAccount = [select Id from Account where Account_Type__c = 'PBM'];
        objPharmacyService = [select Id, BOT_Account__c, BOT_PBM_Name__c from BOT_Pharmacy_Service__c];
        
        //Test data validation
        System.assertEquals(objPharmacyService.BOT_Account__c, objAccount.Id);        
        System.assertEquals(objPharmacyService.BOT_PBM_Name__c, objPBMAccount.Id);
        
        //Querying Account plan to PBM linking record which is created by a after insert trigger
        Child_Account_vod__c objChildAccount = [select Id, Parent_Account_vod__c, Child_Account_vod__c from Child_Account_vod__c];
        
        //Test data validation
        System.assertEquals(objChildAccount.Parent_Account_vod__c, objPBMAccount.Id);
        System.assertEquals(objChildAccount.Child_Account_vod__c, objAccount.Id);
    }
    
    //Testing while creating a list of pharmacy service records
    static testMethod void createPharmacyServices()
    {
        List<Account> lstAccount;								//To store a List of Account records
        List<Account> lstPBMAccount;							//To store a List of PBM Account records
        List<BOT_Pharmacy_Service__c> lstPharmacyServices;		//To store a pharmacy services records
        Integer i, j, temp = 0;
        
        //To create a list of Pharmacy service records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'MCO');
        clsTestDataFactory.createPharmacyServices(5,5,10);
        
        //Querying the created test data
        lstAccount = [select Id from Account where Account_Type__c = 'MCO'];
        lstPBMAccount = [select Id from Account where Account_Type__c = 'PBM'];
        lstPharmacyServices = [select Id, BOT_Account__c, BOT_PBM_Name__c from BOT_Pharmacy_Service__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstPBMAccount.size(), 5);
        System.assertEquals(lstPharmacyServices.size(), 50);
        for(i = 0; i < 5; i++)
        {
        	for(j = 0; j < 10; j++)
            {
            	System.assertEquals(lstPharmacyServices[temp].BOT_Account__c, lstAccount[i].Id);        
        		System.assertEquals(lstPharmacyServices[temp].BOT_PBM_Name__c, lstPBMAccount[i].Id);
                temp++;
            }
        }
        
        //Querying Account plan to PBM linking records which are created by a after insert trigger
        List<Child_Account_vod__c> lstChildAccount = [select Id, Parent_Account_vod__c, Child_Account_vod__c from Child_Account_vod__c];
        
        //Test data validation
        System.assertEquals(lstChildAccount.size(), 5);
        for(i = 0; i < 5; i++)
        {
            System.assertEquals(lstChildAccount[i].Parent_Account_vod__c, lstPBMAccount[i].Id);
        	System.assertEquals(lstChildAccount[i].Child_Account_vod__c, lstAccount[i].Id);
        }
	}
}