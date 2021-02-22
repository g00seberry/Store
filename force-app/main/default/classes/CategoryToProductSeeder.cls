public class CategoryToProductSeeder {
  public static void seed() {
    delete [SELECT Id FROM CategoryToProduct__c];

    List<Product__c> products = [SELECT Id FROM Product__c];
    List<ProductCategory__c> categories = [SELECT Id FROM ProductCategory__c];
    List<CategoryToProduct__c> categoryToProductList = new List<CategoryToProduct__c>();

    for (Integer i = 0; i < products.size(); i++) {
      Integer randomCategoryIndex = 0;
      Id categoryId = categories.get(randomCategoryIndex).Id;
      Id productId = products.get(i).Id;

      if (categories.size() > 1) {
        randomCategoryIndex = (Math.random() * (categories.size() - 1))
          .intValue();
        categoryId = categories.get(randomCategoryIndex).Id;
      }
      categoryToProductList.add(
        new CategoryToProduct__c(
          Products__c = productId,
          ProductCategory__c = categoryId
        )
      );
    }

    upsert categoryToProductList;
  }
}
