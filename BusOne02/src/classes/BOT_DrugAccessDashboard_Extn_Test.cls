/*
Name            : BOT_DrugAccessDashboard_Extn_Test
Created date    : 10/03/2018
Created by      : Sreenivasulu Adipudi
Description     : This class is written by BusinessOne Technologies Inc. It is a test class for BOT_DrugAccessDashboard_Extn controller class.
*/
@isTest(seeAllData=false)
private class BOT_DrugAccessDashboard_Extn_Test 
{
    //To test BOT_DrugAccessDashboard_Extn class
    static testMethod void BOT_DrugAccessDashboard_Extn()
    {
        Account objAccount;                           			//To store an Account record
        List<BOT_Drug_Access__c> lstDrugAccess;                 //To create a list of drug access records
        BOT_Drug_Access__c objDrugAccess;						//To create a drug Access record
        List<selectOption> options;                     		//To store a list of markets
        Integer i, j;
        
        //To create a list of Drug access records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1, 'MCO');
        clsTestDataFactory.createFormularyProductRecords(5);
        //clsTestDataFactory.createDrugAccessRecords(1, 5);
        
        //Creating a list of Drug access records
        lstDrugAccess = new List<BOT_Drug_Access__c>();
        for(i = 0; i < 5; i++)
        {
        	for(j = 0; j < 5; j++)
            {
            	objDrugAccess = new BOT_Drug_Access__c();
            	objDrugAccess.BOT_Entity_ID__c = 0;
            	objDrugAccess.BOT_Formulary_Product_ID__c = i;
            	objDrugAccess.BOT_Total_Plan_Rx_Lives__c = j + 10000;
            	objDrugAccess.BOT_Formulary_Drug_Rx_Lives__c = j + 1000;
            	objDrugAccess.BOT_Access_Percentage__c = j + 90;
            	objDrugAccess.BOT_Drug_Status__c = 'PA';
            	lstDrugAccess.add(objDrugAccess);    
            }
        }
       	insert lstDrugAccess;
        
        //Querying the created test data
        objAccount = [select Id from Account];
        
        //Creating instance for Acccount standard controller class
        ApexPages.StandardController controller = new ApexPages.StandardController(objAccount);
        BOT_DrugAccessDashboard_Extn clsDrugAccessDashbaord = new BOT_DrugAccessDashboard_Extn(controller);
        
        //Calling dynamic list method
        options = clsDrugAccessDashbaord.getDynamicList();
        
        //Test data validation
        System.assertEquals(options.size(), 6);
		System.assertEquals(clsDrugAccessDashbaord.lstDrugAccess.size(), 25);
    }
}