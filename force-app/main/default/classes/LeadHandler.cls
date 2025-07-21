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

    public static void handleDuplicateData( List<Lead> leadList ){

        

    }


}