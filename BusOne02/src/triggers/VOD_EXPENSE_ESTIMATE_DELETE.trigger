trigger VOD_EXPENSE_ESTIMATE_DELETE on EM_Expense_Estimate_vod__c (before delete) {
    Set<Id> eventIds = new Set<Id>();
    for (EM_Expense_Estimate_vod__c estimate: Trigger.old) {
        if (estimate.Event_vod__c != null) {
            eventIds.add(estimate.Event_vod__c);
        }
    }

    Map<Id, EM_Event_vod__c> eventMap = new Map<Id, EM_Event_vod__c>([SELECT Id, Estimated_Cost_vod__c, Lock_vod__c
                                                                      FROM EM_Event_vod__c
                                                                      WHERE Id IN : eventIds]);
    Set<String> lockedEvents = new Set<String>();
    for (Id eventId : eventMap.keySet()) {
        EM_Event_vod__c event = eventMap.get(eventId);
        if(VOD_Utils.isEventLocked(event)) {
            lockedEvents.add(event.Id);
        }
    }

	for(EM_Expense_Estimate_vod__c estimate: Trigger.old) {        
        Decimal estimateValue = estimate.Estimate_vod__c == null ? 0 : estimate.Estimate_vod__c;
        
        if(estimate.Override_Lock_vod__c == true) {
        	estimate.Override_Lock_vod__c = false;
        } else if (estimate.Event_vod__c != null && lockedEvents.contains(estimate.Event_vod__c)) {
            estimate.addError('Event is locked');
        }         
    }
}