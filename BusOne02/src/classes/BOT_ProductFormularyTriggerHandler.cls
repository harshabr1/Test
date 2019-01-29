/*
Name			: BOT_ProductFormularyTriggerHandler
Created by		: Sreenivasulu Adipudi
Created date	: 05-nov-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a helper class for BOT_ProductFormularyTrigger trigger.
*/
public with sharing class BOT_ProductFormularyTriggerHandler
{
	public static void populateProductIdAndFormularyId(List<BOT_Product_Formulary_JO__c> lstProductFormulary)
    {
    	set<String> setPlanProductIds = new set<String>();
        set<String> setBenefitDesignIds = new set<String>();
        Map<String, ID> mapPlanProductIds = new Map<String, ID>(); 
        Map<String, ID> mapBenefitDesignIds = new Map<String, ID>();
        for(BOT_Product_Formulary_JO__c objProductFormulary : lstProductFormulary)
        {
			if(objProductFormulary.BOT_Plan_Product_ID__c != null)
            {
            	setPlanProductIds.add(String.valueOf(objProductFormulary.BOT_Plan_Product_ID__c));
            }
            if(objProductFormulary.BOT_Benefit_Design_ID__c != null)
            {
				setBenefitDesignIds.add(String.valueOf(objProductFormulary.BOT_Benefit_Design_ID__c));
            }
        }
            
        for(BOT_Plan_Product__c objPlanProduct : [select Id, BOT_Product_ID__c from BOT_Plan_Product__c where BOT_Product_ID__c in : setPlanProductIds])
        {
        	mapPlanProductIds.put(objPlanProduct.BOT_Product_ID__c, objPlanProduct.Id);
        }
        
        for(Benefit_Design_vod__c objBenefitDesign : [select Id, External_ID_vod__c from Benefit_Design_vod__c where External_ID_vod__c in : setBenefitDesignIds])
        {
        	mapBenefitDesignIds.put(objBenefitDesign.External_ID_vod__c, objBenefitDesign.Id);
        }
        
        for(BOT_Product_Formulary_JO__c objProductFormulary : lstProductFormulary)
        {
            if(objProductFormulary.BOT_Plan_Product_ID__c != null)
            {
            	objProductFormulary.BOT_Plan_Product__c = mapPlanProductIds.get(String.valueOf(objProductFormulary.BOT_Plan_Product_ID__c));
            }
            if(objProductFormulary.BOT_Benefit_Design_ID__c != null)
            {
				objProductFormulary.BOT_Benefit_Design__c = mapBenefitDesignIds.get(String.valueOf(objProductFormulary.BOT_Benefit_Design_ID__c));
            }
        }
    }
}