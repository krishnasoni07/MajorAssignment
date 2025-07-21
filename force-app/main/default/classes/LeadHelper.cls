public with sharing class LeadHelper {

    public static void launchApprovelProcess( Lead lead, Map<Id, Id> usersWithManagerId){
        lead.Lead_Status__c	= 'Approved';

        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(lead.Id);

        if( usersWithManagerId.get( UserInfo.getUserId() ) != null ){
            req.setSubmitterId( usersWithManagerId.get( UserInfo.getUserId() ) );
        }
        else{
            req.setSubmitterId(UserInfo.getUserId());
        }
        
        Approval.ProcessResult result = Approval.process(req);
    }

}