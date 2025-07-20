public with sharing class LeadBatchHelper {
    
    public static boolean isTierOneCity( String cityName ){
        Set<String> tierOneCityNames = new Set<String>{ 'Delhi', 'Mumbai', 'Bangalore', 'Chennai', 'Hyderabad', 'Kolkata', 'Pune', 'Ahmedabad' };

        return tierOneCityNames.contains(cityName);
    }

    public static Integer getVowelsCount( String companyName ){
        Integer count = 0;

        for(Integer i = 0; i < companyName.length(); i++) {
            if( 'aeiouAEIOU'.contains( String.valueOf( companyName.charAt(i) ) ) )
                count++;
        }

        return count;
    }

    public static void sendEmailsToUsers( Integer leadsSize ){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        List<User> usersEmails = [ SELECT Email FROM User WHERE Profile.Name = 'System Administrator' AND UserRole.Name = 'Manager' AND IsActive = true ];

        for( User currentUser : usersEmails ){
            Messaging.SingleEmailMessage tempEmail = new Messaging.SingleEmailMessage();

            tempEmail.setToAddresses(new String[]{ currentUser.Email });
            tempEmail.setPlainTextBody('Today\'s Special Leads Count : ' + leadsSize );
            tempEmail.setSubject('Special Lead Counts of the Day');

            emails.add(tempEmail);
        }

        if( emails.size() != 0 ){
            Messaging.sendEmail(emails);
        }
    }

    public static void sendEmailsToReferrer( Map<String, Integer> emailsWithCount ){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for( String email : emailsWithCount.keySet() ){
            Messaging.SingleEmailMessage tempEmail = new Messaging.SingleEmailMessage();

            tempEmail.setToAddresses(new String[]{ email });
            tempEmail.setPlainTextBody('Your Today\'s Special Lead Count : ' + emailsWithCount.get(email));
            tempEmail.setSubject('Special Lead Count of the Day');

            emails.add(tempEmail);
        }

        try{
            if( emails.size() != 0 ){
                Messaging.sendEmail(emails);
            }
        }
        catch( Exception e ){
            System.debug(e.getMessage());
        }
    }

}