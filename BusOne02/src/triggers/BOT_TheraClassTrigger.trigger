/*
Name            : BOT_TheraClassTrigger
Created By      : Sreenivasulu A
Created Date    : 25-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is used to populate the related SFDC Account ID on BOT_Specialty_Provider__c filed.
*/
trigger BOT_TheraClassTrigger on BOT_Thera_Class__c (before insert) 
{
	if(Trigger.isInsert && Trigger.isBefore)
    {
        BOT_TheraClassTriggerHandler.populateSpecialtyProviderIds(Trigger.new);   
    }
}