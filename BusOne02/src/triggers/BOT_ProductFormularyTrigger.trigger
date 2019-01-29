/*
Name			: BOT_ProductFormularyTrigger
Created by		: Sreenivasulu Adipudi
Created date	: 05-nov-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is used to populate the SFDC plan product Id and SFDC Benefit Design Id on Product formulary object.
*/
trigger BOT_ProductFormularyTrigger on BOT_Product_Formulary_JO__c (before insert) 
{
	if(Trigger.isBefore && Trigger.isInsert)
    {
        BOT_ProductFormularyTriggerHandler.populateProductIdAndFormularyId(Trigger.new);
    }
}