trigger EmployeeTrigger on Employee__c (before insert) {
    if( Trigger.isBefore && Trigger.isInsert ){
        EmployeeHelper.handleRequiredFields(Trigger.new);
    }

    if( Trigger.isBefore && Trigger.isUpdate ){
        
    }

}