/*
Name            : BOT_TheraClassTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 25-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class of BOT_TheraClassTriggerHandler class.
*/
@isTest(seeAllData = false)
private class BOT_TheraClassTriggerHandlerTest 
{
    //Testing while creating a Thera class record
    static testMethod void createTheraClassRecord()
    {
       	Account objSpecialtyProvider;     //To store a Specilary provider Account record
        BOT_Thera_Class__c objTheraClass; //To store a Thera class record
        
        //To create a Thera class record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1, 'Specialty Provider');
        clsTestDataFactory.createTheraClassWithSpecialtyId(1,1);
        
        //Querying the created test data
        objSpecialtyProvider = [SELECT Id FROM Account];
        objTheraClass = [SELECT Id, BOT_Specialty_Provider__c FROM BOT_Thera_Class__c];
        
        //Test data validation
        System.assertEquals(objTheraClass.BOT_Specialty_Provider__c, objSpecialtyProvider.Id);
    }
    
    //To create a list of Thera class records
    static testMethod void createTheraClassRecords()
    {
       	List<Account> lstSpecialtyProvider;     //To store a list of Specilary provider Account records
        List<BOT_Thera_Class__c> lstTheraClass; //To store a list of Thera class records
        Integer i, j, temp = 0;
        
        //To create a list of Thera class records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5, 'Specialty Provider');
        clsTestDataFactory.createTheraClassWithSpecialtyId(5,5);
        
        //Querying the created test data
        lstSpecialtyProvider = [SELECT Id FROM Account ORDER BY BOT_Entity_ID__c];
        lstTheraClass = [SELECT Id, BOT_Specialty_Provider__c FROM BOT_Thera_Class__c ORDER BY BOT_Specialty_Provider_ID__c];
        
        //Test data validation
       	System.assertEquals(lstSpecialtyProvider.size(), 5);
        System.assertEquals(lstTheraClass.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
	        	System.assertEquals(lstTheraClass[temp].BOT_Specialty_Provider__c, lstSpecialtyProvider[i].Id);
                temp++;
            }
        }
    }
}