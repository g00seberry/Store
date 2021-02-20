public with sharing class ProductCategoryController {
    @AuraEnabled
    public static List<ProductCategory__c> getChildCategories(ID parentCategoryId){
        List<ProductCategory__c> childCategories = [SELECT Name,ProductCategoryParent__c,Id FROM ProductCategory__c Where ProductCategoryParent__c = :parentCategoryId];
        return childCategories;
    }
}