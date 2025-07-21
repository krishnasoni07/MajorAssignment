trigger LeadTrigger on Lead (before update) {

    if( Trigger.isBefore && Trigger.isUpdate ){

        LeadHandler.handleApprovelProcess(Trigger.new);
    }

    if( Trigger.isBefore && Trigger.isInsert ){
        
    }

}