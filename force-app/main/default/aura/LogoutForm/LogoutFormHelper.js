({
   	logout : function(component) {
		let currentUser = JSON.stringify(component.get('v.user'));
        let action = component.get("c.LogoutUser");

        action.setParams({ 
            "userRequest":currentUser,
        }); 
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {    
                _storeUtil.fireWithParams(
                    "CloseModalEvent",
                    {
                        "id": "logout_modal"
                    }
                );
                
                _storeUtil.fireWithParams(
                    "UpdateUserEvent",
                    {
                        "user": null
                    }
                );
            }
            else {
               console.log(response.getError());
            }
        });
        
        $A.enqueueAction(action); 
	},
})