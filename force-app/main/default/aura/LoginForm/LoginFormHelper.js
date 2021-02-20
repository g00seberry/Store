({
    tryAuth : function(component, helper) {
		let currentUser = JSON.stringify(component.get('v.user'));
        
        let action = component.get("c.AuthUser");
        
        action.setParams({ 
            "userRequest":currentUser,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                helper.clearForm(component);
                
                _storeUtil.fireWithParams(
                    "UpdateUserEvent",
                    {
                        "user": response.getReturnValue()
                    }
                ); 
                
                _storeUtil.fireWithParams(
                    "CloseModalEvent",
                    {
                        "id": "login_modal"
                    }
                );  
            }
            else {
               let error = response.getError(); 
               component.set('v.errors',error[0].message);
            }
        });
        
        $A.enqueueAction(action); 
	},
    
    clearForm: function(component) { 
        component.set('v.user',{
                             Password__c:'',
                             Email__c:'',
                             Login__c:'',
                             });
        component.set('v.errors', '');
    },
})