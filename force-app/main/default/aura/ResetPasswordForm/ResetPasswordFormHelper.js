({
	resetPassword : function(component, event, helper) {
        component.set('v.success',"");
        
        if(!helper.checkPass(component)){
            return;
        }

		let oldPassword = component.get('v.oldPassword');
        let newPassword = component.get('v.newPassword');
        let passwordRepeat = component.get('v.passwordRepeat');
    
        let action = component.get("c.ResetPassword");
        
        action.setParams({ 
            'oldPassword':oldPassword,
            'newPassword':newPassword,
            'passwordRepeat':passwordRepeat,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                helper.clearForm(component);
                component.set('v.success',"Пароль успешно сменён.");
            }
            else {
               	let error = response.getError(); 
                component.set('v.errors',error[0].message); 
            }
        });
        $A.enqueueAction(action); 
	},
    
	checkPass: function(component) { 
        let password = component.get('v.newPassword');
        let passwordRepeat = component.get('v.passwordRepeat');
        
        if(password !== passwordRepeat){
            component.set('v.errors', 'Пароли не совпадают');
            return false;
        }
        
        component.set('v.errors', '');
        return true; 
    },
    
    clearForm: function(component) { 
        component.set('v.oldPassword','');
        component.set('v.newPassword','');
        component.set('v.passwordRepeat','');
        component.set('v.errors', '');
    }, 
})