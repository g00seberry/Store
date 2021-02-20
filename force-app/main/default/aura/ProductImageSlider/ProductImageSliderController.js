({
	doInit : function(component, event, helper) {
		let action = component.get("c.getProductAttachments");
        let productId = component.get("v.productId");
        
        action.setParams({
            'productId':productId,
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.productAttachments', response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
	}
})