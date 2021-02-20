public with sharing class SearchController {
    private class searchResut{
        public SObject searchResutItem;
        public string itemLabel;
        public string itemType;
        
        public searchResut(SObject searchResutItem_r, string itemType_r,string itemLabel_r){
            searchResutItem = searchResutItem_r;
            itemType = itemType_r;
            itemLabel= itemLabel_r;
        }
    }
    
    @AuraEnabled
    public static List<String> trySearch(String searchString){
        List<String> searchResutList = new List<String>();
        searchString = '*'+searchString+'*';
		List<List<sObject>> searchList = [FIND :searchString IN ALL FIELDS 
                                          RETURNING 
                                          ProductCategory__c(Name,ProductCategoryParent__c,Id)]; 
        
        ProductCategory__c[] searchProductCategory = (ProductCategory__c[])searchList[0];

        for (ProductCategory__c c : searchProductCategory) {
    		searchResutList.add(JSON.serialize(new searchResut(c,'ProductCategory__c','Категории')));
		}
        
        return searchResutList;
    }
}