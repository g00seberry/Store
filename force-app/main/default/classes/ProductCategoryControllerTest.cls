@isTest
public class ProductCategoryControllerTest {

    @isTest
    public static void getChildCategoriesTest() {
        ProductCategory__c category = new ProductCategory__c(Name='Category ', ProductCategoryDescription__c = 'Description ');
        insert category;
        ProductCategory__c categoryChild = new ProductCategory__c(
            Name='Category ', 
            ProductCategoryDescription__c = 'Description ',
            ProductCategoryParent__c = category.Id);

        insert categoryChild;

        try {
            List<ProductCategory__c>  categories = ProductCategoryController.getChildCategories(category.Id);
            System.assertEquals(true, categories[0].Id == categoryChild.Id);

        } catch (Exception e) {
            System.assertEquals(1, 0);
        }
    }
}
