public without sharing class VeevaKamUtils {

    public static boolean isVeevaAccountPlanShareEnabled() {
        Veeva_Settings_vod__c vsc = Veeva_Settings_vod__c.getOrgDefaults();
        if(vsc == null || vsc.Account_Plan_Sharing_vod__c == null || vsc.Account_Plan_Sharing_vod__c.intValue() != 1) {
            return false;
        }
        return true;
    }


    public static Set<Id> getInactiveUserIds(Set<Id> userIds) {
        Map<ID,User> userObjectsMap = new Map<Id, User>([Select Id, IsActive from User where IsActive = false AND Id IN : userIds]);
        return userObjectsMap.keySet();
    }


}