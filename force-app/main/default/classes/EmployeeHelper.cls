public with sharing class EmployeeHelper {

    public static void handleRequiredFields(List<Employee__c> empList) {
        for (Employee__c emp : empList) {

            if (String.isBlank(emp.Address__c)) {
                emp.Address__c.addError('Address field cannot be empty.');
            }

            if (String.isBlank(emp.Email__c)) {
                emp.Email__c.addError('Email is mandatory.');
            }

            if (String.isBlank(emp.Name)) {
                emp.Name.addError('Employee Name cannot be empty.');
            }

            if (emp.Date_of_Joining__c == null || emp.Date_of_Joining__c > System.today()) {
                emp.Date_of_Joining__c.addError('Please ensure the Date of Joining is not empty or a future date.');
            }

            if (emp.Phone__c == null || String.valueOf(emp.Phone__c).length() != 10) {
                emp.Phone__c.addError('Phone must be a 10-digit number.');
            }

        }
    }

    public static void handleQuarterScoreUpdate( List<Employee__c> empList, Map<Id, Employee__c> empMap){

        Integer currentMonth = Date.today().month();
        Integer nextQuarter = Math.mod( Date.today().month() + 3, 12 );

        for( Employee__c emp : empList ){
            Employee__c temp = empMap.get( emp.Id );

            if( ( temp.Quarter_One__c != emp.Quarter_One__c )){
                if( !( currentMonth >= 1 && currentMonth <= 3 ) ){
                    emp.addError( 'You can\'t modify any Other Quarter Data.' );
                }

                if( !( emp.Quarter_One__c >= 0 && emp.Quarter_One__c <= 100 ) ){
                    emp.addError( 'You can\'t Give Scores more than 100 or lesser than 0.' );
                }
            }

            if( ( temp.Quarter_Two__c != emp.Quarter_Two__c )){
                if( !( currentMonth >= 4 && currentMonth <= 6 ) ){
                    emp.addError( 'You can\'t modify any Other Quarter Data.' );
                }
                if( !( emp.Quarter_Two__c >= 0 && emp.Quarter_Two__c <= 100 ) ){
                    emp.addError( 'You can\'t Give Scores more than 100 or lesser than 0.' );
                }
            }

            if( ( temp.Quarter_Three__c != emp.Quarter_Three__c )){
                if( !( currentMonth >= 7 && currentMonth <= 9 ) ){
                    emp.addError( 'You can\'t modify any Other Quarter Data.' );
                }
                if( !( emp.Quarter_Three__c >= 0 && emp.Quarter_Three__c <= 100 ) ){
                    emp.addError( 'You can\'t Give Scores more than 100 or lesser than 0.' );
                }
            }

            if( ( temp.Quarter_Four__c != emp.Quarter_Four__c )){
                if( !( currentMonth >= 10 && currentMonth <= 12 ) ){
                    emp.addError( 'You can\'t modify any Other Quarter Data.' );
                }
                if( !( emp.Quarter_Four__c >= 0 && emp.Quarter_Four__c <= 100 ) ){
                    emp.addError( 'You can\'t Give Scores more than 100 or lesser than 0.' );
                }
            }
            
        }

    }
}

/*

if( !( emp.Quarter_One__c >= 1 && emp.Quarter_One__c <= 100 ) || 
                !( emp.Quarter_Two__c >= 1 && emp.Quarter_Two__c <= 100 ) ||
                !( emp.Quarter_Three__c >= 1 && emp.Quarter_Three__c <= 100 ) ||
                !( emp.Quarter_Four__c >= 1 && emp.Quarter_Four__c <= 100 )
            ){
                emp.addError(  );
            }

*/