({
    getAttachments : function(component) {
		let action = component.get("c.getProductAttachments");
        
        let product = component.get("v.product"); 
        
        action.setParams({
            "productId":product.Id,
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.productAttachments', response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }); 
        
        $A.enqueueAction(action);
	}
})