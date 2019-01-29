/*
Name            : BOT_BenefitDesignLineTrigger
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Benefit Design ID (Formulary ID) and SFDC Formulary Product ID (Drug ID) 
                  by using BOT Formulary ID and BOT Drug ID respectively.
*/

trigger BOT_BenefitDesignLineTrigger on Benefit_Design_Line_vod__c (before insert,after insert) 
{
    if(Trigger.isInsert && Trigger.isBefore)
    {
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine = new List<Benefit_Design_Line_vod__c>();
        Set<String> setBOTBenefitDesignIds = new Set<String>();		//To store unique BOT Benefit design Ids
        Set<String> setBOTFormularyproductIds = new Set<String>();	//To store unique BOT Formulary product Ids
    	
        //Creating set of BOT benefitdesign Ids and BOT formulary product Ids
        for(Benefit_Design_Line_vod__c objBenefitDesignLine : Trigger.new)
        {
       		if(objBenefitDesignLine.BOT_Benefit_Design_ID__c != Null && objBenefitDesignLine.BOT_Formulary_Product_ID__c != Null)
            {
            	setBOTBenefitDesignIds.add(String.valueOf(objBenefitDesignLine.BOT_Benefit_Design_ID__c));
            	setBOTFormularyproductIds.add(String.valueOf(objBenefitDesignLine.BOT_Formulary_Product_ID__c));
                lstBenefitDesignLine.add(objBenefitDesignLine);
            }
        }
        if(lstBenefitDesignLine.size() > 0)
        {
        	BOT_BenefitDesignLineTriggerHandler.populateBenefitDesignAndProductIds(lstBenefitDesignLine, setBOTBenefitDesignIds, setBOTFormularyproductIds);
        }   
    }
}