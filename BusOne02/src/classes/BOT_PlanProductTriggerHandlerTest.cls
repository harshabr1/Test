/*
Name            : BOT_PlanProductTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 20-SEP-2018
Overview        : This class is writtern by BusinessOne Technologies Inc. It is a test class for BOT_PlanProductTriggerHandler class.
*/
@isTest(seeAllData = false)
private class BOT_PlanProductTriggerHandlerTest 
{
    //Testing while creating a Plan product record with Medicare channel and and name morethan 80 charcters 
    static testMethod void createPlanProductRecordWithMedicareChannel()
    {
        Account objAccount;						//To store an Account record
        BOT_Plan_Product__c objPlanProduct;     //To store a Plan product record
        
        //To create a plan product record with Medicare channel and name morethan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'Medicare');
        clsTestDataFactory.createPlanProductRecords(1,1,'Medicare');
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account];
        objPlanProduct = [SELECT Id, BOT_Account__c, BOT_Medical_Admin__c FROM BOT_Plan_Product__c 
        				  WHERE name = 'BOT Test Product Name Where product name is having more than 80 characters ar...'];
        
        //Test data validation
        System.assertEquals(objPlanProduct.BOT_Account__c, objAccount.Id);
        System.assert(objPlanProduct.BOT_Medical_Admin__c==null);
    }
    
    //Testing while creating a Plan product record with Employer channel and name lessthan 80 characters
    static testMethod void createPlanProductRecordWithEmployerChannel()
    {
        Account objAccount;							//To store an Account record
        BOT_Plan_Product__c objPlanProduct;       	//To store a Plan product records
        
        //To create a plan product record with Employer channel and name lessthan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'Employer');
        clsTestDataFactory.createPlanProductRecords(1,1,'Employer');
        
       	//Querying the created test data
        objAccount = [select Id FROM Account];
       	objPlanProduct = [SELECT Id, Name, BOT_Account__c, BOT_Medical_Admin__c FROM BOT_Plan_Product__c 
                          WHERE name = 'BOT Test Product Name 0'];
        
        //Test data validation     
        System.assertEquals(objPlanProduct.BOT_Account__c, objAccount.Id, 'Plan Product Account Id is equal to Account Id');
        System.assertEquals(objPlanProduct.BOT_Medical_Admin__c, objAccount.Id, 'Plan Product Medical Admin Id is equal to Account Id');
    }
	
    //Testing while creating a list of Plan product records with Medicare channel and name morethan 80 characters 
    static testMethod void createPlanProductRecordswithMedicareChannel()
    {
        List<Account> lstAccount;						//To store a list of Account records
        List<BOT_Plan_Product__c> lstPlanProduct;       //To store a list of Plan product records
        Integer temp = 0;                               //Temporary variable used as index position of plan prouduts list
        
        //To create a plan product record with Medicare channel and name morethan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'Medicare');
        clsTestDataFactory.createPlanProductRecords(5,5,'Medicare');
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account];
        lstPlanProduct = [SELECT Id, BOT_Account__c, BOT_Medical_Admin__c FROM BOT_Plan_Product__c 
                          WHERE name = 'BOT Test Product Name Where product name is having more than 80 characters ar...' 
                          ORDER BY BOT_Account__c, BOT_Medical_Admin__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstPlanProduct.size(), 25);
		for(Integer i = 0; i < 5; i++)
        {
        	for(Integer j = 0; j < 5; j++ )
            {
                System.assertEquals(lstPlanProduct[temp].BOT_Account__c, lstAccount[i].Id, 'Plan Product Account Id is equal to Account Id');
                System.assertEquals(lstPlanProduct[temp].BOT_Medical_Admin__c, null, 'Plan Product Medical Admin Id is null');
            	temp++;
            }
        }
    }
    
    //Testing while creating a list of Plan product records with Employer channel and name lessthan 80 characters
    static testMethod void createPlanProductRecordswithEmployerChannel()
    {
        List<Account> lstAccount;						//To store a list of Account records
        List<BOT_Plan_Product__c> lstPlanProduct;       //To store a list of Plan product records
        Integer temp = 0;                               //Temporary variable used as index position of plan prouduts list
        
        //To create a plan product record with Employer channel and name lessthan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'Employer');
        clsTestDataFactory.createPlanProductRecords(5,5,'Employer');
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account];
        lstPlanProduct = [SELECT Id, Name, BOT_Account__c, BOT_Medical_Admin__c FROM BOT_Plan_Product__c ORDER BY BOT_Account__c, BOT_Medical_Admin__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstPlanProduct.size(), 25);
        for(Integer i = 0; i < 5; i++)
        {
        	for(Integer j = 0; j < 5; j++ )
            {
                System.assertEquals(lstPlanProduct[temp].BOT_Medical_Admin__c, lstAccount[i].Id);
                System.assertEquals(lstPlanProduct[temp].BOT_Account__c, lstAccount[i].Id);   
                System.assertEquals(lstPlanProduct[temp].Name, 'BOT Test Product Name ' + temp);
            	temp++;
            }
        }
    }
}