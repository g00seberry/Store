public class CategoriesSeeder {
    public static void seed(){
        delete [Select Id From ProductCategory__c];
        
        List<ProductCategory__c> categories = new List<ProductCategory__c>();
        
        for(Integer i = 1 ; i < 8; i++){
            
            Integer randomParentIndex = (Math.random() * (categories.size() - 1)).intValue();

            Id parent = null;
            
            if(categories.size()> 2){
                upsert categories.get(randomParentIndex);
                parent = categories.get(randomParentIndex).Id;
            }
             
            categories.add(new ProductCategory__c(
                Name='Category '+i,
                ProductCategoryDescription__c = 'Description '+i,
                ProductCategoryParent__c=parent
            ));
        }
        
        upsert categories;
    }
}