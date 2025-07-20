public with sharing class SetLeads implements Database.Batchable<SObject>, Database.Stateful{
    
    private Integer specialLeadsCount = 0;
    private Map<String, Integer> emailWithCount;

    public SetLeads(){
        emailWithCount = new map<String, Integer>();
    }

    public static Database.QueryLocator start( Database.BatchableContext bc ){
        List<User> activeUsers = [ SELECT Id FROM User WHERE LastLoginDate = LAST_N_DAYS:25 AND IsActive = True ];

        return Database.getQueryLocator('SELECT Id, Name, Company_Size__c, City__c, Company, Special_Lead__c, Referrer_Email__c FROM Lead WHERE CreatedDate = TODAY AND Special_Lead__c = false AND OwnerId IN :activeUsers.Id');
    }

    public void execute( Database.BatchableContext bc, List<Lead> nonSpecialLeads ){

        List<Lead> leadsToUpdate = new List<Lead>();

        for( Lead lead : nonSpecialLeads ){
            if( lead.Company_Size__c >= 500 &&
                LeadBatchHelper.isTierOneCity( lead.City__c ) &&
                LeadBatchHelper.getVowelsCount( lead.Company) >= 2
            ){
                lead.Special_Lead__c = true;

                leadsToUpdate.add(lead);
            }

            if( lead.Referrer_Email__c != null ){
                emailWithCount.put( lead.Referrer_Email__c, ( emailWithCount.containsKey(lead.Referrer_Email__c) ? emailWithCount.get(lead.Referrer_Email__c) + 1 : 1 ) );
            }

        }

        
        if( leadsToUpdate != null ){
            update leadsToUpdate;
            specialLeadsCount += leadsToUpdate.size();
        }

    }

    public void finish( Database.BatchableContext bc ){
        LeadBatchHelper.sendEmailsToUsers(specialLeadsCount);
        LeadBatchHelper.sendEmailsToReferrer(emailWithCount);
    }

}