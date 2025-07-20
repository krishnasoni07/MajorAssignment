@isTest
public with sharing class GetProductTest {

    @TestSetup
    static void makeData(){
        List<Product2> productList = new List<Product2>();

        for( Integer i = 1; i <= 10;i++ ){
            productList.add(
                new Product2(
                    Name = 'Test ' + i,
                    Product_Quantity__c = 10 * i
                )
            );
        }

        insert productList;
    }

    @isTest
    private static void testPrintHighestProduct(){
        GetProducts.printHighestStockProduct(6);
    }

}