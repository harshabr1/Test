/*
Name            : BOT_AddressTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 20-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc. It is a test class of BOT_AddressTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_AddressTriggerHandlerTest 
{
    //Testing while creating an Address record
    static testMethod void createAddressRecord()
    {
        Account objAccount;                 //To store an Account record
        Address_vod__c objAddress;          //To store an Address record
        
        //To create an address record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createAddressRecords(1,1);
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account];
        objAddress = [SELECT Id, Account_vod__c FROM Address_vod__c];
       	
        //Test data validation
        System.assert(objAccount != null);
        System.assert(objAddress != null);
        System.assertEquals(objAddress.Account_vod__c , objAccount.Id);
    }
    
    //Testing while creating a list of Address records
    static testMethod void createAddressRecords()
    {
        List<Account> lstAccount;           //To store a list of Account records
        List<Address_vod__c> lstAddress;   	//To store a list of Address records
        integer i, j, temp = 0;
        
        //To create a list of address records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'MCO');
        clsTestDataFactory.createAddressRecords(5,5);
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c];
        lstAddress = [SELECT Id, Account_vod__c FROM Address_vod__c ORDER By BOT_Entity_Id__c];
       	
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstAddress.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
            	System.assertEquals(lstAddress[temp].Account_vod__c , lstAccount[i].Id);
                temp++;
			}
        }
    }
}