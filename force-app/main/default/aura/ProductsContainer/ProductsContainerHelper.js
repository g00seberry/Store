({
    resetPagerParams: function(component){
        component.set('v.pagerParams',{
                             'limit':6,
                             'offset':0,
                             });
    },
    
    fireFetchProductsEvent: function(component){
        let stringFilterParams = JSON.stringify(component.get('v.filterParams'));
        let stringPagerParams = JSON.stringify(component.get('v.pagerParams'));
        
        let action = component.get("c.getProducts");
        
        action.setParams({ 
            'filterParams':stringFilterParams,
            'pagerParams':stringPagerParams,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.products',response.getReturnValue());
            }
            else {
               console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);  
    },
    
    fireFetchProductsCount: function(component){
        let stringFilterParams = JSON.stringify(component.get('v.filterParams'));

        let action = component.get("c.getProductsCount");
        
        action.setParams({ 
            'filterParams':stringFilterParams,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.productsCountNoPager',response.getReturnValue());
            }
            else {
               console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);  
    },
})