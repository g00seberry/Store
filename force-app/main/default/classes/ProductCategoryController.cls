public with sharing class ProductCategoryController {
  @AuraEnabled
  public static List<ProductCategory__c> getChildCategories(
    Id parentCategoryId
  ) {
    List<ProductCategory__c> childCategories = [
      SELECT Name, ProductCategoryParent__c, Id
      FROM ProductCategory__c
      WHERE ProductCategoryParent__c = :parentCategoryId
    ];
    return childCategories;
  }
}
