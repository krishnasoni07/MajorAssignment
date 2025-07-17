public with sharing class GetEmployee {
    
    public static void printTopEmployees( Integer num ){
        List<Employee__c> empList = [ SELECT Name, Average_Score__c, Performance__c FROM Employee__c ORDER BY Name ASC, Average_Score__c DESC LIMIT :num ];

        Employee__c topEmployee;
        Employee__c poorEmployee;
        String empNames = '';

        Decimal max = 0.00;
        Decimal min = 0.00;


        for( Employee__c emp : empList ){
            System.debug( 'Employee : ' + emp.Name + ' -> Average Score : ' + emp.Average_Score__c + ' -> Rating : ' + emp.Performance__c );

            if( emp.Average_Score__c > max ){
                max = emp.Average_Score__c;
                topEmployee = emp;
            }

            if( emp.Average_Score__c < min ){
                min = emp.Average_Score__c;
                poorEmployee = emp;
            }
            empNames += emp.Name + ', ';
        }

        if (topEmployee != null) {
            System.debug('Top Performer : ' + topEmployee.Name + ' ( Average Score : ' + topEmployee.Average_Score__c + ' )');
        }
        if (poorEmployee != null) {
            System.debug('Employees for HR Review : ' + poorEmployee.Name);
        }

        if (empNames.length() > 2) {
            System.debug('Sorted Employee List : ' + empNames.substring(0, empNames.length() - 2));
        }

    }

}