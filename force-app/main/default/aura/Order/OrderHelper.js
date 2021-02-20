({
	getProductsFromOrder: function(component, helper){
        let action = component.get("c.GetProductsAndDetails");
        
        action.setParams({
            "orderId": component.get("v.order").Id
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.products", JSON.parse(response.getReturnValue()));
                helper.calculateFullCost(component);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    calculateFullCost: function(component){
        let products = component.get('v.products');
        let fullCost = 0;
        for(let productData of products){
            fullCost += productData.product.ProductPrice__c * productData.orderDetail.ProductQuantity__c;
        }
        component.set('v.fullCost', fullCost);
    }
})