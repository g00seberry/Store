({
	createOrder: function(component, helper){
        component.set('v.errors', '');
        
        let cardId = component.get("v.cardId");
        let action = component.get("c.CreateOrder");
        
        action.setParams({
            "bankCardId":cardId
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {      
                _storeUtil.fireWithParams(
                    "NewOrderEvent",
                    {
                        "order": response.getReturnValue()
                    }
                );
                _storeUtil.fireWithParams(
                    "OpenModalEvent",
                    {
                        "id": "order_list_modal"
                    }
                );  
                _storeUtil.fireWithParams(
                    "CloseModalEvent",
                    {
                        "id": "checkout_modal"
                    }
                );
            }
            else {
                let error = response.getError();
                component.set('v.errors', error[0].message);
                console.log(response.getError());
            }
        });
        
        $A.enqueueAction(action);
    },
})