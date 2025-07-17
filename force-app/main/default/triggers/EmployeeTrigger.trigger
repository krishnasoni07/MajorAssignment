trigger EmployeeTrigger on Employee__c (before insert, before update, after update) {
    if( Trigger.isBefore && Trigger.isInsert ){
        EmployeeHelper.handleRequiredFields(Trigger.new);
    }

    if( Trigger.isBefore && Trigger.isUpdate ){
        EmployeeHelper.handleQuarterScoreUpdate(Trigger.new, Trigger.oldMap);
        EmployeeHelper.handleAverageUpdate(Trigger.new, Trigger.oldMap);
    }

}