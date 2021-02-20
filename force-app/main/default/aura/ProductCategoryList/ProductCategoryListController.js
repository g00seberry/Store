({
	doInit : function(component, event, helper) {
		helper.getChildCategories(component);
	},
    
    selectCategory: function(component, event, helper){
        let category = event.getParam("category");
        
        let selectedCategories =component.get("v.selectedCategories"); 
        
      	selectedCategories.push(category.ProductCategoryParent__c); 

        component.set("v.selectedCategories", selectedCategories);

        helper.getChildCategories(component,category.Id);
        
        _storeUtil.fireWithParams(
            "UpdateFilterEvent",
            {
                "filterParams":{
                    "key": "category",
                    "value": category.Id
                }
            }
        );      
    },
    
    toPrevCategories: function(component, event, helper){
        let prevSelectedCategory =component.get("v.selectedCategories").pop(); 
        helper.getChildCategories(component,prevSelectedCategory);
        
        _storeUtil.fireWithParams(
            "UpdateFilterEvent",
            {
                "filterParams":{
                    "key": "category",
                    "value": prevSelectedCategory
                }
            }
        );
    },
})