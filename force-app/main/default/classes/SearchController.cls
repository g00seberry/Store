public with sharing class SearchController {
  private class SearchResult {
    public SObject searchResultItem;
    public String itemLabel;
    public String itemType;

    public SearchResult(
      SObject searchResultItem_r,
      String itemType_r,
      String itemLabel_r
    ) {
      searchResultItem = searchResultItem_r;
      itemType = itemType_r;
      itemLabel = itemLabel_r;
    }
  }

  @AuraEnabled
  public static List<String> trySearch(String searchString) {
    List<String> searchResultList = new List<String>();
    searchString = '*' + searchString + '*';
    List<List<SObject>> searchList = [
      FIND :searchString
      IN ALL FIELDS
      RETURNING ProductCategory__c(Name, ProductCategoryParent__c, Id)
    ];

    ProductCategory__c[] searchProductCategory = (ProductCategory__c[]) searchList[0];

    for (ProductCategory__c c : searchProductCategory) {
      searchResultList.add(
        JSON.serialize(new SearchResult(c, 'ProductCategory__c', 'Категории'))
      );
    }

    return searchResultList;
  }
}
