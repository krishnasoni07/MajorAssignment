@isTest
public with sharing class SetLeadsTest {

    @TestSetup
    static void makeData(){
        List<Lead> leadList = new List<Lead>();
        
        for( Integer i = 1; i <= 10; i++ ){
            leadList.add(
                new Lead( 
                    Company = 'Test Company ' + i, 
                    LastName = 'Last Test ' + i,
                    Company_size__c = i * 100,
                    City__c = 'Mumbai',
                    Referrer_Email__c = 'krmicr17@gmail.com'
                )
            );
        }

        insert leadList;
    }

    @isTest
    private static void testSetLeadsBatchClass(){
        Test.startTest();
        Database.executeBatch(new SetLeads(), 200);
        Test.stopTest();
    }

}