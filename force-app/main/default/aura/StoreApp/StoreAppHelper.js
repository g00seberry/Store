({   
    checkAuthUser: function(component, helper) {
        let action = component.get("c.CheckAuthUser");
          
        action.setCallback(this, function(response){    
            let state = response.getState();   
            if (state === "SUCCESS") {
				helper.updateUser(component, response.getReturnValue());
            }
            else {
               let error = response.getError(); 
               console.log(error[0]);
            }
        });
        
        $A.enqueueAction(action); 
	},
    
    updateUser : function(component, user) {
        component.set('v.user',user);
        component.set('v.isAuth',user != null);
        
        if(user != null){
            _storeUtil.fire('UserIsAuthEvent');
        }         	
	},
})