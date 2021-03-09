@isTest
public class ProductsControllerTest {
    public static Product__c CreateTestProduct(String name, Decimal productPrice,String productLabel, String productDescription,Integer inStock){
        return new Product__c(
            Name = name, 
            ProductPrice__c = productPrice,
            ProductLabel__c = productLabel,
            ProductDescription__c = productDescription,
            InStock__c = inStock
        );
    }

    @isTest
    public static void getProductsTest() {
        Product__C product = CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);
        insert product;

        ProductCategory__c category = new ProductCategory__c(Name='Category ', ProductCategoryDescription__c = 'Description ');
        insert category;

        insert new CategoryToProduct__c(Products__c= product.Id, ProductCategory__c =category.Id);

        Map<string, string> filters = new Map<String, String>();
        filters.put('category', category.Id);
        filters.put('priceMin', '100');
        filters.put('priceMax', '200000');

        Map<string, string> pager = new Map<String, String>();
        pager.put('limit', '2');
        pager.put('offset', '0');

        try {
            List<Product__c> products = ProductsController.getProducts(JSON.serialize(filters), JSON.serialize(pager));

            System.assertEquals(true, products.size() == 1);
            
        } catch (Exception e) {
            System.assertEquals(1,0);
        } 
    }

    @isTest
    public static void getProductsCountTest() {
        Product__C product = CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);
        insert product;

        ProductCategory__c category = new ProductCategory__c(Name='Category ', ProductCategoryDescription__c = 'Description ');
        insert category;

        insert new CategoryToProduct__c(Products__c= product.Id, ProductCategory__c =category.Id);

        Map<string, string> filters = new Map<String, String>();
        filters.put('category', category.Id);
        filters.put('priceMin', '100');
        filters.put('priceMax', '200000');

        try {
            Integer productsCount = ProductsController.getProductsCount(JSON.serialize(filters));

            System.assertEquals(true, productsCount == 1);
            
        } catch (Exception e) {
            System.assertEquals(1,0);
        } 
    }

    @isTest
    public static void getProductAttachmentsTest() {
        Product__C product = CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);
        insert product;

        try {
            List<ContentDocumentLink> attachments = ProductsController.getProductAttachments(product.Id);
            System.assertEquals(true, attachments.size() == 0);
            
        } catch (Exception e) {
            System.assertEquals(1,0);
        } 
    }
}
