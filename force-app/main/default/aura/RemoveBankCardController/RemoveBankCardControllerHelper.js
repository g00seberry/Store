({
	removeCard : function(component) {
        component.set('v.errors',"");
        
		let cardId = component.get('v.cardId');
        let action = component.get("c.RemoveBankCard");
        
        action.setParams({ 
            'cardId':cardId,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
               _storeUtil.fireWithParams(
                   "RemoveBankCardEvent",
                   {
                       "card": response.getReturnValue()
                   }    
               );
            }
            else {
               	let error = response.getError(); 
               	component.set('v.errors',error[0].message);
            }
        });
        
        $A.enqueueAction(action);         
	}
})