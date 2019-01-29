/*
Name            : BOT_BenefitDesignLineTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Benefit Design ID (plan formulary ID) and SFDC Formulary Product ID (Drug ID) 
				  by using BOT Formulary ID and BOT Drug ID respectively.

Modified By 	:Harsha BR
Modified date 	:14-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.
*/

public with sharing class BOT_BenefitDesignLineTriggerHandler 
{
	public static void populateBenefitDesignAndProductIds(List<Benefit_Design_Line_vod__c> lstBenefitDesignLine, Set<String> setBOTBenefitDesignIds, Set<String> setBOTFormularyproductIds)
    {
        Map<String, Id> mapBenefitDesignIds = new Map<String, Id>();		//Map of BOT Benefit design Ids and asssociated SFDC Benefit Design IDs
        Map<String, Id> mapFormularyProductIds = new Map<String, Id>();	//Map of BOT Formulary product Ids and asssociated SFDC Formulary product IDs
        
        //To Retrieve SFDC Benefit design Id by comparing BOT Benefit design Id and put in map   
        for(Benefit_Design_vod__c objBenefitDesign : [select Id, external_Id_vod__c from Benefit_Design_vod__c where external_Id_vod__c in : setBOTBenefitDesignIds])
        {
        	mapBenefitDesignIds.put(objBenefitDesign.external_Id_vod__c, objBenefitDesign.Id);
        }
        
        //To Retrieve SFDC Formulary product Id by comparing BOT Formulary product Id ID and put in map
        for(Formulary_Products_vod__c objFormularyProduct : [select Id, external_Id_vod__c from Formulary_Products_vod__c where external_Id_vod__c in : setBOTFormularyproductIds])
        {
        	mapFormularyProductIds.put(objFormularyProduct.external_Id_vod__c, objFormularyProduct.Id);
        }
        
        //Updating Benefit_Design_vod__c and Product_vod__c fileds
        for(Benefit_Design_Line_vod__c objBenefitDesignLine : lstBenefitDesignLine)
        {
            objBenefitDesignLine.Benefit_Design_vod__c = mapBenefitDesignIds.get(String.valueOf(objBenefitDesignLine.BOT_Benefit_Design_ID__c));
            objBenefitDesignLine.Product_vod__c = mapFormularyProductIds.get(String.valueOf(objBenefitDesignLine.BOT_Formulary_Product_ID__c));
 		}
    }
}