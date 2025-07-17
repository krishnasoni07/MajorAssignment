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
        
        try{
            insert empList[0];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        
        try{
            insert empList[1];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        try{
            insert empList[2];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        try{
            insert empList[3];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        try{
            insert empList[4];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

        try{
            insert empList[5];
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }

    }

    
}