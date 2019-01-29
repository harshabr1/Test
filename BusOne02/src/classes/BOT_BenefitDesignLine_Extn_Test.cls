/*
Name            : BOT_BenefitDesignLine_Extn_Test
Created date    : 29/08/2018
Created by      : Sreenivasulu Adipudi
Description     : This class is written by BusinessOne Technologies Inc. It is test class for BOT_BenefitDesignLine_Extn class.
*/
@isTest(seeAllData=false)
private class BOT_BenefitDesignLine_Extn_Test
{
    //Testing BOT_BenefitDesignLine_Extn standard controller class
    static testMethod void BOT_BenefitDesignLine_Extn()
    {
        Benefit_Design_vod__c objBenefitDesign;           		//To store a Benefit design record
        Benefit_Design_Line_vod__c objBenefitDesignLine;  		//To store a Benefit design line record
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;	//To store a list if Benefit design records
        List<selectOption> options;                             //To store a list of markets
        Integer i, j, temp = 0;
        
        //To create a Benefit design Line record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createBenefitDesignRecords(1,1,'Commercial');
        clsTestDataFactory.createFormularyProductRecords(5);
        //clsTestDataFactory.createBenefitDesignLineRecords(5,5);
        
        //Creating a list of benefit design line records
        lstBenefitDesignLine = new List<Benefit_Design_Line_vod__c>();
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
			{
				objBenefitDesignLine = new Benefit_Design_Line_vod__c();
            	objBenefitDesignLine.BOT_Benefit_Design_ID__c = 0;
            	objBenefitDesignLine.BOT_Formulary_Product_ID__c = i;
            	objBenefitDesignLine.Status_Source_vod__c = 'Test Status 1';
            	objBenefitDesignLine.Restrictions_Source_vod__c = 'PA';
				objBenefitDesignLine.Notes_Source_vod__c = 'Test Notes';
            	objBenefitDesignLine.Copay_Source_vod__c = '$10 - $20';
            	lstBenefitDesignLine.add(objBenefitDesignLine);
			}
        }
        insert lstBenefitDesignLine;
        
        //Querying the created test data
        objBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c];
        
        //Creating instance for Benefit design standard controller class
        ApexPages.StandardController controller = new ApexPages.StandardController(objBenefitDesign);
        BOT_BenefitDesignLine_Extn clsBenefitDesignLine= new BOT_BenefitDesignLine_Extn(controller);
        
        //Calling dynamic list method
        options = clsBenefitDesignLine.getDynamicList();
       
        //Test data validation
        System.assertEquals(options.size(), 7);
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 25);
        
        //Calling marketFilterRetrieve method with selected market as 'Market 1'
        clsBenefitDesignLine.selectedMarket = 'Test Market 1';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 5);
        
        //Calling marketFilterRetrieve method with selected market as '--ALL-'
        clsBenefitDesignLine.selectedMarket = '--ALL--';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 25);
        
        //Calling marketFilterRetrieve method with selected market as 'All Company Products'
        clsBenefitDesignLine.selectedMarket = 'All Company Products';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 25);
    }
}