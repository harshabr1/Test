/*
Name            : BOT_SpecialtyProviderJoTrigger
Created By      : Sreenivasulu A
Created Date    : 06-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Entity ID and SFDC Specialty provider ID
				  by comparing BOT Entity ID.
*/

trigger BOT_SpecialtyProviderJoTrigger on BOT_Specialty_Provider_JO__c (before insert) 
{
    if(Trigger.isInsert && Trigger.isBefore)
    {
        BOT_SpecialtyProviderJoTriggerHandler.populateAccountAndSpecialtyProviderIds(Trigger.new);   
    }   
}