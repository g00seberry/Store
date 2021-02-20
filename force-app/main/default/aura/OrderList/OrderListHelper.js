({
	getOrders: function(component){
        let action = component.get("c.GetOrders");
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.orders", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    }
})