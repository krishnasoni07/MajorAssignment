public with sharing class LeadHandler {

    public static void handleApprovelProcess( List<Lead> leadList ){

        List<User> allUsers = [ SELECT Id, ManagerId FROM User WHERE Profile.Name = 'System Administrator' AND UserRole.Name = 'Manager' AND IsActive = true ];
        Map<Id, Id> userWithManagerId = new Map<Id, Id>();

        for( User user : allUsers ){
            if (user.ManagerId != null) {
                userWithManagerId.put( user.Id, user.ManagerId );
            }
            else{
                userWithManagerId.put( user.Id, null);
            }
        }

        for( Lead lead : leadList ){
            if( lead.LastModifiedDate > System.today() - 5 ){
                LeadHelper.launchApprovelProcess( lead, userWithManagerId );
            }
        }

    }

    public static void handleDuplicateData(List<Lead> leadList) {

        Map<String, Lead> keyToLeadMap = new Map<String, Lead>();

        for (Lead l : leadList) {
            if (l.Special_Lead__c == true) {
                String domain = '';
                if (l.Email != null && l.Email.contains('@')) {
                    domain = l.Email.split('@').get(1).toLowerCase().trim();
                }
                String key =
                    (l.Company != null ? l.Company.toLowerCase().trim() : '') + '|' +
                    domain + '|' +
                    (l.City__c != null ? l.City__c.toLowerCase().trim() : '') + '|' +
                    (l.Industry != null ? l.Industry.toLowerCase().trim() : '');
                keyToLeadMap.put(key, l);
            }
        }

        if (!keyToLeadMap.isEmpty()) {
            List<Lead> existingLeads = [
                SELECT Id, Company, Email, City__c, Industry
                FROM Lead
                WHERE Special_Lead__c = true
                AND Id NOT IN :leadList
                AND IsDeleted = false
            ];

            for (Lead existing : existingLeads) {
                String existingDomain = '';
                if (existing.Email != null && existing.Email.contains('@')) {
                    existingDomain = existing.Email.split('@').get(1).toLowerCase().trim();
                }
                String key =
                    (existing.Company != null ? existing.Company.toLowerCase().trim() : '') + '|' +
                    existingDomain + '|' +
                    (existing.City__c != null ? existing.City__c.toLowerCase().trim() : '') + '|' +
                    (existing.Industry != null ? existing.Industry.toLowerCase().trim() : '');

                if (keyToLeadMap.containsKey(key)) {
                    keyToLeadMap.get(key).addError('A Special Lead already exists (Id: ' + existing.Id + ')');
                }
            }
        }
    }

    

}