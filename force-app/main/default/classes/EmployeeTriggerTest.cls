@isTest
private class EmployeeTriggerTest {

    @TestSetup
    static void makeData(){
        List<Employee__c> empList = new List<Employee__c>();

        for( Integer i = 1; i <= 10;i++ ){
            empList.add( new Employee__c( 
                Name = 'Test ' + i,
                Address__c = 'Hell',
                Email__c = 'Test@gmail.com',
                Phone__c = Long.valueOf('9352304201'),
                Date_of_Joining__c = System.today()
            ) );
        }

        try{
            insert empList;
        }
        catch( DmlException e ){
            System.debug( 'Record can\'t be inserted' );
            System.debug( e.getMessage() );
        }

    }

    @isTest
    private static void testHandleRequiredFields(){
        List<Employee__c> empList = new List<Employee__c>();

        empList.add( new Employee__c(  ) );
        empList.add( new Employee__c( Name = 'Test' ) );
        empList.add( new Employee__c( Name = 'Test', Address__c = 'Hell' ) );
        empList.add( new Employee__c( Name = 'Test', Address__c = 'Hell',  Email__c = 'Test@gmail.com' ) );
        empList.add( new Employee__c( Name = 'Test', Address__c = 'Hell',  Email__c = 'Test@gmail.com', Phone__c = Long.valueOf('9352304201') ) );
        empList.add( new Employee__c( Name = 'Test', Address__c = 'Hell',  Email__c = 'Test@gmail.com', Phone__c = Long.valueOf('9352304201'), Date_of_Joining__c = System.today() + 1 ) );
        
        for (Employee__c e : empList) {
            try {
                insert e;
                System.assert(false, 'Expected insert to fail due to validation');
            } catch (DmlException ex) {
                System.debug(ex.getMessage());
            }
        }

    }

    @isTest
    private static void testHandleQuarterScoreUpdate(){
        List<Employee__c> empList = [ SELECT Id, Quarter_Four__c, Quarter_Three__c, Quarter_One__c FROM Employee__c WHERE Name LIKE 'Test%' ];

        empList[0].Quarter_Three__c = 500;

        try{
            update empList[0];
            System.debug( '\n\nNo errors\n\n' );
        }
        catch( DmlException e ){
            System.debug('\n\n' + e.getMessage());
        }
    }

    @isTest
    private static void testHandleAverageUpdate(){

        List<Employee__c> empList = [ SELECT Id, Quarter_Four__c, Quarter_Three__c, Quarter_One__c FROM Employee__c WHERE Name LIKE 'Test%' ];
        
        for( Employee__c emp : empList ){
            emp.Quarter_Three__c = 360;
        }

        try{
            update empList;
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        List<Employee__c> empListOg = [ SELECT Id, Performance__c, Quarter_Three__c, Average_Score__c FROM Employee__c WHERE Id IN: empList ];

        for( Employee__c emp : empListOg ){
            System.debug('Employee Details : ' + emp.Id + ' => ' + emp.Performance__c + ' => ' + emp.Average_Score__c );
        }

    }

    @isTest
    private static void testPrintTopEmployees(){
        testHandleAverageUpdate();
        GetEmployee.printTopEmployees(5);
    }

}