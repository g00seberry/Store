({
    selectCategory : function(component, event, helper) {
        let item = component.get('v.searchResultItem');
        
        _storeUtil.fireWithParams(
            "SelectSearchCategoryEvent", 
            {"category" : item.searchResutItem}
        );
	}
})