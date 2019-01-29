/*
Name            : BOT_DrugAccessTrigger
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Account ID and SFDC Formulary Product ID (Drug ID) 
				  by comparing BOT Entity ID and BOT Drug ID respectively.
*/

trigger BOT_DrugAccessTrigger on BOT_Drug_Access__c (before insert) 
{
    if(Trigger.isInsert && Trigger.isBefore)
    {
     	BOT_DrugAccessTriggerHandler.populateAccountAndProductIds(Trigger.new);   
    }
}