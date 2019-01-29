/*
Name            : BOT_BenefitDesignLineTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 20-sep-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class of BOT_BenefitDesignLineTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_BenefitDesignLineTriggerHandlerTest 
{
    //Testing while creating a Benefit design Line record
    static testMethod void createBenefitDesignLineRecord()
    {
        Benefit_Design_vod__c objBenefitDesign;           //To store a Benefit design record
        Formulary_Products_vod__c objFormularyProduct;    //To store a Formulary product record
        Benefit_Design_Line_vod__c objBenefitDesignLine;  //To store a Benefit design line record
        
        //To create a Benefit design Line record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'Employer');
        clsTestDataFactory.createBenefitDesignRecords(1,1,'Employer');
        clsTestDataFactory.createFormularyProductRecords(1);
        clsTestDataFactory.createBenefitDesignLineRecords(1,1);
        
        //Querying the created test data
        objBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c];
        objFormularyProduct = [SELECT Id FROM Formulary_Products_vod__c];
        objBenefitDesignLine = [SELECT Id, Benefit_Design_vod__c, Product_vod__c FROM Benefit_Design_Line_vod__c];        
        
        //Test data validation
        System.assertEquals([SELECT count() FROM Account], 1);
        System.assertEquals(objBenefitDesignLine.Benefit_Design_vod__c, objBenefitDesign.Id);
        System.assertEquals(objBenefitDesignLine.Product_vod__c, objFormularyProduct.Id);
	}
                             
    //Testing while creating a list of Benefit design Line records
    static testMethod void createBenefitDesignLineRecords()
    {
        List<Benefit_Design_vod__c> lstBenefitDesign;           //To store list of Benefit design records
        List<Formulary_Products_vod__c> lstFormularyProduct;    //To store list of Formulary product records
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;  //To store list of Benefit design line records
        integer i, j, temp = 0;
        
        //To create a list of Benefit design Line records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'Employer');
        clsTestDataFactory.createBenefitDesignRecords(1,5,'Employer');
        clsTestDataFactory.createFormularyProductRecords(5);
        clsTestDataFactory.createBenefitDesignLineRecords(5,5);
        
        //Querying the created test data
        lstBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c ORDER BY external_Id_vod__c];
        lstFormularyProduct = [SELECT Id FROM Formulary_Products_vod__c ORDER BY external_Id_vod__c];
        lstBenefitDesignLine = [SELECT Id, Benefit_Design_vod__c, Product_vod__c FROM Benefit_Design_Line_vod__c ORDER BY BOT_Benefit_Design_ID__c];        
        
        //Test data validation
        System.assertEquals(lstBenefitDesign.size(), 5);
        System.assertEquals(lstFormularyProduct.size(), 5);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
            	System.assertEquals(lstBenefitDesignLine[temp].Benefit_Design_vod__c, lstBenefitDesign[i].Id);
        		System.assertEquals(lstBenefitDesignLine[temp].Product_vod__c, lstFormularyProduct[i].Id);
                temp++;
            }
        }
	}
}