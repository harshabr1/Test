/*
Name			: BOT_BenefitDesignTriggerHandler
Created By		: Sreenivasulu A
Created Date	: 28-AUG-2018
Overview		: This class is written by BusinessOne Technologies Inc. It performs below functionalities:-
				1.	It is used to truncate the name of the Benefit Design if the characters is more than 80. Append the channel at the end of the name.
				2.	It is used to populate the parent SFDC ID by using BOT Entity ID.
*/
public with sharing class BOT_BenefitDesignTriggerHandler 
{
	public static void manageNameAndPopulateAccountId(List<Benefit_Design_vod__c> lstBenefitDesign, Set<Decimal> setAccountIds)
    {
        Integer channelLength = 0;									//To store length of channel value
        Map<Decimal, ID> mapAccountIds = new Map<Decimal, ID>();	//To store BOT Entity Ids and SFDC Ids of Account object
        
        //To Retrieve SFDC Account Ids by comparing BOT Entity Ids and put in map
        for(Account objAccount : [SELECT Id, BOT_Entity_ID__c FROM Account WHERE BOT_Entity_ID__c in : setAccountIds])
        {
            mapAccountIds.put(objAccount.BOT_Entity_ID__c, objAccount.Id);
        }
		
        for(Benefit_Design_vod__c objBenefitDesign : lstBenefitDesign)
        {
            //To update related SFDC Account ID
            objBenefitDesign.Account_vod__c = mapAccountIds.get(objBenefitDesign.BOT_Entity_ID__c);
            
            //To handle name field
            if(objBenefitDesign.BOT_Formulary_Name__c != Null && objBenefitDesign.Type_vod__c != Null)
            {
                //To append ' - ' and channel to the BOT_Formulary_Name field make channelLength as 80 - (3 + channel value length)
                channelLength = 77 - objBenefitDesign.Type_vod__c.length();
                
                //Check weather BOT_Formulary_Name field value length is lessthan or equal to channelLength
                //If it is true then append channel to BOT_Formulary_Name field value and store it in name field
                if(objBenefitDesign.BOT_Formulary_Name__c.length() <= channelLength)
                {
                	objBenefitDesign.Name = objBenefitDesign.BOT_Formulary_Name__c + ' - '+ objBenefitDesign.Type_vod__c;   
                }
                
                //If name field more than channelLength trim the BOT_Formulary_Name field value
                //Append '.. - ' + channel to BOT_Formulary_Name field value and store it in name field 
                else
                {
                    channelLength = channelLength - 2;
                	objBenefitDesign.Name = objBenefitDesign.BOT_Formulary_Name__c.subString(0,channelLength) + '.. - '+ objBenefitDesign.Type_vod__c;  
                }
            }
        }
    }
}