/*
Name            : BOT_AccountSummaryExtn_Test
Created date    : 10/03/2018
Created by      : Sreenivasulu Adipudi
Description     : This class is written by BusinessOne Technologies Inc. It is a test class for BOT_AccountSummary_Extn controller class.
*/
@isTest(seeAllData=false)
private class BOT_AccountSummaryExtnTest 
{
    static testMethod void BOT_AccountSummaryExtn()
    {
        Account objAccount;                         //To create an Account record
        BOT_coverage_policy__c objCoveragePolicy;   //To create a coverage policy record
        
        //Creating an account record
        objAccount = new Account();
        objAccount.Name = 'Test Account Name 1';
        objAccount.BOT_Entity_Id__c = 101;
        objAccount.Account_Type__c = 'Commercial';
        objAccount.BOT_Entity_Level__c = 'National';
        insert objAccount;
        
        //Creating a coverage policy record
        objCoveragePolicy = new BOT_coverage_policy__c();
        objCoveragePolicy.BOT_Account__c = objAccount.Id;
        objCoveragePolicy.BOT_Channel__c = 'Commercial';
        objCoveragePolicy.Name = 'Test Coverage Policy 1';
        objCoveragePolicy.BOT_Score__c = 'Baseline';
        objCoveragePolicy.BOT_Indication__c = 'Biallelic RPE65 Mutation-associated Retinal Dystro';
        insert objCoveragePolicy;

        ApexPages.StandardController controller = new ApexPages.StandardController(objAccount);
        BOT_Account_Summary_Extn clsAccountSummary = new BOT_Account_Summary_Extn(controller);
        
        //Verifiying no of coverage policy records returned form the server
        System.assertEquals(1,clsAccountSummary.lstCoveragePolicy.size());
    }
}