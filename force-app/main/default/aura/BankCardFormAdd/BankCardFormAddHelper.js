({
	addBankCard : function(component, helper) {
        component.set('v.success',"");
        component.set('v.errors',"");
        
		let card = JSON.stringify(component.get('v.card'));

        let action = component.get("c.CreateBankCard");
        
        action.setParams({ 
            'cardRequest':card,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                helper.clearForm(component);
                _storeUtil.fireWithParams(
                    "AddBankCardEvent",
                    {
                        "card":response.getReturnValue()
                    }    
                );
                
                component.set('v.success',"Карта добавлена.");
            }
            else {
               	let error = response.getError(); 
               	component.set('v.errors',error[0].message);
            }
        });
        $A.enqueueAction(action); 
	},
    
    clearForm: function(component) { 
        component.set('v.card',{});
        component.set('v.expiryDateCache','');
        component.set('v.errors','');
    }, 
    
    checkDate: function(component){
        let card = component.get('v.card');
        
        if(card.ExpiryDate__c.length > 7)
        {
            card.ExpiryDate__c = component.get('v.expiryDateCache');
            component.set('v.card', card);
            return false;
        }
        return true;
    },
})