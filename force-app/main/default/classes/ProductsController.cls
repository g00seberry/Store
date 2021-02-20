public with sharing class ProductsController {
    private static List<Product__c> filterProducts (List<Product__c> products, string filterParams){    
        Map<string, string> filters = (Map<string, string>)JSON.deserialize(filterParams, Map<string, string>.class);

        if(filters.containsKey('category') && filters.get('category') != null){         
            products = [SELECT 
                        Name,
                        ProductLabel__c,
                        ProductDescription__c,
                        ProductPrice__c,
                        InStock__c FROM Product__c
                        WHERE Id IN (SELECT Products__c FROM CategoryToProduct__c 
                         			WHERE ProductCategory__c = :filters.get('category'))];
        }
        
        if(filters.containsKey('priceMin') && filters.get('priceMin') != null){
            Decimal priceMin = Decimal.ValueOf(filters.get('priceMin'));
            products = [SELECT 
                        Name,
                        ProductLabel__c,
                        ProductDescription__c,
                        ProductPrice__c,
                        InStock__c FROM Product__c 
                        WHERE Id IN :products AND ProductPrice__c >=: priceMin];
        }
        
        if(filters.containsKey('priceMax') && filters.get('priceMax') != null){
            Decimal priceMax = Decimal.ValueOf(filters.get('priceMax'));
            products = [SELECT 
                        Name,
                        ProductLabel__c,
                        ProductDescription__c,
                        ProductPrice__c,
                        InStock__c FROM Product__c 
                        WHERE Id IN :products AND ProductPrice__c <= :priceMax];
        }
        
        return products;
    } 
    
    private static List<Product__c> pagedProducts (List<Product__c> products, string pagerParams){    
        Map<string, string> pager = (Map<string, string>)JSON.deserialize(pagerParams, Map<string, string>.class);
        
        Integer pagerLimit = Integer.ValueOf(pager.get('limit'));
        Integer pagerOffset = Integer.ValueOf(pager.get('offset'));
        Integer productsCount = products.size();
        
        products = [SELECT 
                        Name,
                        ProductLabel__c,
                        ProductDescription__c,
                        ProductPrice__c,
                        InStock__c FROM Product__c 
                        WHERE Id IN :products 
                        LIMIT :pagerLimit OFFSET :pagerOffset];
        
        return products;
    } 
   
    @AuraEnabled
    public static List<Product__c> getProducts(string filterParams, string pagerParams){
        
        List<Product__c> products = [SELECT 
                                     Name,
                                     ProductLabel__c,
                                     ProductDescription__c,
                                     ProductPrice__c,
                                     InStock__c 
                                     FROM Product__c];

        products = filterProducts (products, filterParams);
		products = pagedProducts (products, pagerParams);
        
        return products;
    } 
    
    @AuraEnabled
    public static Integer getProductsCount(string filterParams){
        List<Product__c> products = [SELECT 
                                         Name,
                                         ProductLabel__c,
                                         ProductDescription__c,
                                         ProductPrice__c,
                                         InStock__c 
                                         FROM Product__c];
        
        products = filterProducts (products, filterParams);

        return products.size();
    } 
    
    @AuraEnabled
    public static Product__c getProduct(string productId){
        return [SELECT
                Name,
                ProductLabel__c,
                ProductDescription__c,
                ProductPrice__c,
                InStock__c 
                FROM Product__c
                WHERE Id =: productId];
    } 
    
    @AuraEnabled
    public static List<ContentDocumentLink> getProductAttachments(string productId){
        return [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :productId];
    }
}