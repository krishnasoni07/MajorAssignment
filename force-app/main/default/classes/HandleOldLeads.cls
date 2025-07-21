public with sharing class HandleOldLeads implements Database.Batchable<SObject>, Database.Stateful{

    Map<Id, Integer> leadIdWithDays = new Map<Id, Integer>();

    public Database.QueryLocator start( Database.BatchableContext bc ){

        return Database.getQueryLocator([SELECT Id, OwnerId, LastModifiedDate FROM Lead WHERE LastModifiedDate <> LAST_N_DAYS:5 AND Special_Lead__c = true AND IsConverted = false]);

    }

    public void execute( Database.BatchableContext bc, List<Lead> nonConvertedLeads ){

        List<Database.LeadConvert> leadsToConvert = new List<Database.LeadConvert>();
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Set<Id> oppIds = new Set<Id>();

        for( Lead lead : nonConvertedLeads ){

            Database.LeadConvert leadToConvert = new Database.LeadConvert();

            leadToConvert.setLeadId(lead.Id);
            leadToConvert.setDoNotCreateOpportunity(false);
            leadToConvert.setOwnerId( lead.OwnerId );

            leadsToConvert.add( leadToConvert );
            leadIdWithDays.put( lead.Id, System.today().daysBetween(lead.LastModifiedDate.date()) );
        }


        if( leadsToConvert != null && !leadsToConvert.isEmpty() ){
            List<Database.LeadConvertResult> convertedLeads = Database.convertLead(leadsToConvert, false);

            for( Database.LeadConvertResult leadResult : convertedLeads ){
                if( leadResult.isSuccess() && leadResult.getOpportunityId() != null){
                    oppIds.add( leadResult.getOpportunityId() );
                }
            }

            oppToUpdate = [ SELECT Id, OwnerId, Owner.ManagerId FROM Opportunity WHERE Id IN :oppIds AND Owner.ManagerId != null];

            for( Opportunity opp : oppToUpdate ){
                opp.OwnerId = opp.Owner.ManagerId;
            }

            if( !oppToUpdate.isEmpty() ){
                update oppToUpdate;
            }
        }

    }
    
    public void finish( Database.BatchableContext bc ){
        LeadBatchHelper.sendUntouchedEmails(leadIdWithDays);
    }

}