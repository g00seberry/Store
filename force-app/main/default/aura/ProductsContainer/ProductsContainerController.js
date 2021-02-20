({
    doInit : function(component, event, helper) {
        helper.fireFetchProductsEvent(component);
        helper.fireFetchProductsCount(component);
	}, 
     
	fetchProducts: function(component, event, helper){
        helper.fireFetchProductsEvent(component);
        helper.fireFetchProductsCount(component);
    },

    updateFilter:function(component, event, helper) {
        let eventFilterParams = event.getParam("filterParams");
        let filterParams =component.get('v.filterParams');
        
        filterParams[eventFilterParams['key']] = eventFilterParams['value'];

        component.set('v.filterParams',filterParams);
        
        helper.resetPagerParams(component);
        helper.fireFetchProductsCount(component);  
        helper.fireFetchProductsEvent(component);       
	},
    
    updatePagerParams:function(component, event, helper) {
        component.set('v.pagerParams',event.getParam('pagerParams'));
        helper.fireFetchProductsEvent(component);
        helper.fireFetchProductsCount(component);
	},
})