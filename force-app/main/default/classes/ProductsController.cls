public with sharing class ProductsController {
  private static List<Product__c> filterProducts(
    List<Product__c> products,
    String filterParams
  ) {
    Map<String, String> filters = (Map<String, String>) JSON.deserialize(
      filterParams,
      Map<String, String>.class
    );

    if (filters.containsKey('category') && filters.get('category') != null) {
      products = [
        SELECT
          Name,
          ProductLabel__c,
          ProductDescription__c,
          ProductPrice__c,
          InStock__c
        FROM Product__c
        WHERE
          Id IN (
            SELECT Products__c
            FROM CategoryToProduct__c
            WHERE ProductCategory__c = :filters.get('category')
          )
      ];
    }

    if (filters.containsKey('priceMin') && filters.get('priceMin') != null) {
      Decimal priceMin = Decimal.valueOf(filters.get('priceMin'));
      products = [
        SELECT
          Name,
          ProductLabel__c,
          ProductDescription__c,
          ProductPrice__c,
          InStock__c
        FROM Product__c
        WHERE Id IN :products AND ProductPrice__c >= :priceMin
      ];
    }

    if (filters.containsKey('priceMax') && filters.get('priceMax') != null) {
      Decimal priceMax = Decimal.valueOf(filters.get('priceMax'));
      products = [
        SELECT
          Name,
          ProductLabel__c,
          ProductDescription__c,
          ProductPrice__c,
          InStock__c
        FROM Product__c
        WHERE Id IN :products AND ProductPrice__c <= :priceMax
      ];
    }

    return products;
  }

  private static List<Product__c> pagedProducts(
    List<Product__c> products,
    String pagerParams
  ) {
    Map<String, String> pager = (Map<String, String>) JSON.deserialize(
      pagerParams,
      Map<String, String>.class
    );

    Integer pagerLimit = Integer.valueOf(pager.get('limit'));
    Integer pagerOffset = Integer.valueOf(pager.get('offset'));
    Integer productsCount = products.size();

    products = [
      SELECT
        Name,
        ProductLabel__c,
        ProductDescription__c,
        ProductPrice__c,
        InStock__c
      FROM Product__c
      WHERE Id IN :products
      LIMIT :pagerLimit
      OFFSET :pagerOffset
    ];

    return products;
  }

  @AuraEnabled
  public static List<Product__c> getProducts(
    String filterParams,
    String pagerParams
  ) {
    List<Product__c> products = [
      SELECT
        Name,
        ProductLabel__c,
        ProductDescription__c,
        ProductPrice__c,
        InStock__c
      FROM Product__c
    ];

    products = filterProducts(products, filterParams);
    products = pagedProducts(products, pagerParams);

    return products;
  }

  @AuraEnabled
  public static Integer getProductsCount(String filterParams) {
    List<Product__c> products = [
      SELECT
        Name,
        ProductLabel__c,
        ProductDescription__c,
        ProductPrice__c,
        InStock__c
      FROM Product__c
    ];

    products = filterProducts(products, filterParams);

    return products.size();
  }

  @AuraEnabled
  public static Product__c getProduct(String productId) {
    return [
      SELECT
        Name,
        ProductLabel__c,
        ProductDescription__c,
        ProductPrice__c,
        InStock__c
      FROM Product__c
      WHERE Id = :productId
    ];
  }

  @AuraEnabled
  public static List<ContentDocumentLink> getProductAttachments(
    String productId
  ) {
    return [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :productId
    ];
  }
}
