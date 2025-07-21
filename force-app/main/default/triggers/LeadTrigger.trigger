trigger LeadTrigger on Lead (before update) {

    if( Trigger.isBefore && Trigger.isUpdate ){
        LeadHandler.handleDuplicateData( Trigger.new );
        LeadHandler.handleApprovelProcess(Trigger.new);
    }

    if( Trigger.isBefore && Trigger.isInsert ){
        LeadHandler.handleDuplicateData( Trigger.new );
    }

}