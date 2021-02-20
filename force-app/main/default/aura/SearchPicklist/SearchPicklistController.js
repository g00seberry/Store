({
	selectCategory : function(component, event, helper) {
        let category = event.getParam('category');
        category.ProductCategoryParent__c = null;
        
        _storeUtil.fireWithParams(
            "CategorySelectEvent", 
            {"category" : category}
        );

        component.set('v.disabled', true);
	}
})