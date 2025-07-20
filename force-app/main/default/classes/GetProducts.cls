public with sharing class GetProducts {

    public static void printHighestStockProduct(Integer num){
        List<Product2> productList = [ SELECT Id, Name, Product_Quantity__c, Stock_Category__c FROM Product2 ORDER BY Product_Quantity__c DESC, Name ASC LIMIT :num];
        Product2 highestStockProduct;
        String productNames = '';

        Integer max = -1;

        for( Product2 pro : productList ){
            System.debug( 'Product Name : ' + pro.Name + ' => ' + pro.Product_Quantity__c + ' => ' + pro.Stock_Category__c );

            if( max < pro.Product_Quantity__c ){
                max = (Integer)pro.Product_Quantity__c;
                highestStockProduct = pro;
            }
            productNames += pro.Name + ', ';
        }

        System.debug( highestStockProduct.Name + ' => ' + highestStockProduct.Product_Quantity__c );
        System.debug( 'Product Name => ' + productNames.substring(0, productNames.length() - 2) );
    }

}