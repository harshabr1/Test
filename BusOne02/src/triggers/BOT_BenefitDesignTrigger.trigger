/*
Name            : BOT_BenefitDesignTrigger
Created By      : Sreenivasulu A
Created Date    : 28-AUG-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. 
                  1. It is used to truncate the name of the Benefit Design if the characters are more than 80 and Append the channel at the end of the name.
                  2. It is used to populate the parent Account SFDC ID.
*/
trigger BOT_BenefitDesignTrigger on Benefit_Design_vod__c (before insert) 
{
    if(Trigger.isInsert && Trigger.isBefore)
    {
        List<Benefit_Design_vod__c> lstBenefitDesign = new List<Benefit_Design_vod__c>();
        Set<Decimal> setAccountIds = new Set<Decimal>();            //To store Account BOT Entity Ids
        
        //Creating set of BOT Entity Ids
        for(Benefit_Design_vod__c objBenefitDesign : trigger.new)
        {
            if(objBenefitDesign.BOT_Entity_ID__c != null)
            {
                setAccountIds.add(objBenefitDesign.BOT_Entity_ID__c);       
                lstBenefitDesign.add(objBenefitDesign);
            }
        }
        
        if(lstBenefitDesign.size() > 0)
        {
            BOT_BenefitDesignTriggerHandler.manageNameAndPopulateAccountId(lstBenefitDesign, setAccountIds);
        }
    }  
}