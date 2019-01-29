/*
Name            : BOT_DrugAccessTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is a helper class to BOT_DrugAccessTrigger trigger and used to populate 
				  the SFDC Account ID and SFDC Formulary Product ID (Drug ID) by comparing BOT Entity ID and BOT Drug ID respectively.

Modified By 	:Harsha BR
Modified date 	:12-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.
*/

public with sharing class BOT_DrugAccessTriggerHandler 
{
	public static void populateAccountAndProductIds(List<BOT_Drug_Access__c> lstDrugAccess)
    {
        Set<Decimal> setBOTEntityIds = new Set<Decimal>();				// To store the BOT Entity IDs
        Set<String> setBOTFormularyproductIds = new Set<String>();		// To store the Formulary Product IDs
    	Map<Decimal, Id> mapAccountIds;									// Map of BOT Entity ID and its asssociated SFDC Account ID
        Map<String, Formulary_Products_vod__c> mapFormularyProductIds;	// Map of BOT Formulary Product ID and its asssociated SFDC Formulary Product ID
        Formulary_Products_vod__c objFormularyProduct1;					// To store a formulary product record;
        
        //Creating set of BOT entity Ids and set of BOT Formulary Products Ids
        for(BOT_Drug_Access__c objDrugAccess : lstDrugAccess)
        {
       		if(objDrugAccess.BOT_Entity_ID__c != Null && objDrugAccess.BOT_Formulary_Product_ID__c != Null)
            {
            	setBOTEntityIds.add(objDrugAccess.BOT_Entity_ID__c);
            	setBOTFormularyproductIds.add(String.valueOf(objDrugAccess.BOT_Formulary_Product_ID__c));
            }
        }
 		
        //To Retrieve SFDC Accout Ids by comparing BOT Account Ids and put in map 
        mapAccountIds = new Map<Decimal, Id>();
        for(Account objAccount : [select Id, BOT_Entity_ID__c from Account where BOT_Entity_ID__c in : setBOTEntityIds LIMIT 50000])
        {
        	mapAccountIds.put(objAccount.BOT_Entity_ID__c, objAccount.Id);
        }
        
        //Retrieving SFDC Formulary product Id by comparing BOT Formulary Product ID and put in map
        mapFormularyProductIds = new Map<String, Formulary_Products_vod__c>();
        for(Formulary_Products_vod__c objFormularyProduct : [select Id, external_Id_vod__c, market_vod__c from Formulary_Products_vod__c where external_Id_vod__c in : setBOTFormularyproductIds LIMIT 50000])
        {
        	mapFormularyProductIds.put(objFormularyProduct.external_Id_vod__c, objFormularyProduct);    
        }
        
        //Updating BOT_Account__c, BOT_Formulary_Product__c and Name fileds of Drug Access object
        for(BOT_Drug_Access__c objDrugAccess : lstDrugAccess)
        {
            objDrugAccess.BOT_Account__c = mapAccountIds.get(objDrugAccess.BOT_Entity_ID__c);
            objFormularyProduct1 = mapFormularyProductIds.get(String.valueOf(objDrugAccess.BOT_Formulary_Product_ID__c));
            objDrugAccess.BOT_Formulary_Product__c = objFormularyProduct1.Id;
            objDrugAccess.Name = objFormularyProduct1.Market_vod__c;
            //objDrugAccess.BOT_Formulary_Product__c = mapFormularyProductIds.get(String.valueOf(objDrugAccess.BOT_Formulary_Product_ID__c)).Id;
            //objDrugAccess.Name = mapFormularyProductIds.get(String.valueOf(objDrugAccess.BOT_Formulary_Product_ID__c)).Market_vod__c;
        }
    }
}