({
    getCart: function(component, helper){
        let action = component.get("c.GetCart");
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cart", response.getReturnValue()); 
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
})