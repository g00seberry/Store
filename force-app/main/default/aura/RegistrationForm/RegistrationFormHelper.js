({
	tryRegister : function(component, helper) {
        if(!helper.checkPass(component)){
            return;
        }
        
		let newUser = JSON.stringify(component.get('v.newUser'));
        let repeatPass = component.get('v.passwordRepeat');
    
        let action = component.get("c.CreateNewUser");
        
        action.setParams({ 
            'userRequest':newUser,
            'repeatPass':repeatPass,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                helper.clearForm(component);
               _storeUtil.fireWithParams(
                   "CloseModalEvent",
                   {
                       "id": "register_modal"
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
    
	checkPass: function(component) { 
        let password = component.get('v.newUser').Password__c;
        let passwordRepeat = component.get('v.passwordRepeat');
        
        if(password !== passwordRepeat){
            component.set('v.errors', 'Пароли не совпадают');
            return false;
        }
        
        component.set('v.errors', '');
        return true; 
    },
    
    clearForm: function(component) { 
        component.set('v.newUser',{
                                 Password__c:'',
                                 Email__c:'',
                                 Login__c:'',
                             });
        
        component.set('v.passwordRepeat','');
        component.set('v.errors', '');
    }, 
})