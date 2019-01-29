/*
* Address_Detect_Knipper_Changes
* Author: Abha Gupta, J. Knipper
* Reviewed: Mark T. Boyer, Veeva Systems - Professional Services
* Date: 2013-05-23
* Summary:
*  This trigger is used to update the AddressModTime field when any of the specified fields are updated.
*  This trigger depends on a custom setting that contains the field list and record types.
*
* Updated by:
* Date:
* Summary:
*/

trigger KNI_Address_Detect_Knipper_Changes on Address_vod__c (before insert, before update) {

    // String RTDeveloperNameList = '';
    // String APIFieldNameList = 'Name,Address_line_2_vod__c,City_vod__c,State_vod__c,Zip_vod__c,Zip_4_vod__c,Primary_vod__c,DEA_vod__c,DEA_Status_vod__c,DEA_Expiration_Date_vod__c,License_vod__c,License_Expiration_Date_vod__c,Phone_vod__c,Fax_vod__c';

    Knipper_Settings__c ks = Knipper_Settings__c.getInstance();
    String RTDeveloperNameList = ks.Address_Detect_Changes_Record_Type_List__c;
    String APIFieldNameList = ks.Address_Detect_Change_FieldList__c;

    RTDeveloperNameList = '\'' + RTDeveloperNameList.replaceAll(',', '\',\'') + '\'';
    Set<id> ProfRT = new Set<Id>();
    String queryRT = 'SELECT Id FROM RecordType WHERE DeveloperName IN (' + RTDeveloperNameList + ') AND SobjectType = \'Address_vod__c\' ';
    List<RecordType> RTList = Database.query(queryRT);
    for(RecordType r : RTList) {
        ProfRT.add(r.Id);
    }

    List<String> fieldList = APIFieldNameList.split(',', 0);

    for (Integer i=0; i < trigger.new.size(); i++) {
        if (RTList.Size()>0  &&  ProfRT.contains(trigger.new[i].recordTypeId)) {
            if (Trigger.IsInsert) {
                trigger.new[i].KNI_Address_ModTime__c = system.now();
            }
            else {
                for(String f : fieldList) {
                    if (trigger.old[i].get(f) != trigger.new[i].get(f)) {
                        trigger.new[i].KNI_Address_ModTime__c = system.now();
                        continue;
                    }
                }
            }
        }
    }
}