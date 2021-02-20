({
	getBankCards : function(component) {
        
		let action = component.get("c.GetBankCards");

        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
               component.set('v.cards',response.getReturnValue());
            }
            else {
               	let error = response.getError(); 
                console.log(error[0].message);
            }
        });
        $A.enqueueAction(action); 
	},
})