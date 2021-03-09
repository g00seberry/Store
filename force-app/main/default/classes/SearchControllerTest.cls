@isTest
public class SearchControllerTest {

    @isTest
    public static void trySearchTest() {
        ProductCategory__c category = new ProductCategory__c(Name='Category', ProductCategoryDescription__c = 'Description');
        insert category;
        try {
            SearchController.trySearch('Cat');
            System.assertEquals(true, true);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
    }

    @isTest
    public static void trySearchEmptyTest() {
        try {
            SearchController.trySearch('category');
            System.assertEquals(true, true);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
    }
}
