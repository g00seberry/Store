({
	search : function(component) {
		let searchString = component.get('v.searchString');
        
        let action = component.get("c.trySearch");
        
        action.setParams({ 
            'searchString':searchString,
        });
         
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                let searchResult = response.getReturnValue();
                for(let i =0; i< searchResult.length; i++){
                    searchResult[i] = JSON.parse(searchResult[i]);
                }
                
                component.set('v.disabledPicklist', false);
                component.set('v.searchResult',searchResult);

                let unpend = component.get('c.unpend');
        		$A.enqueueAction(unpend);
            }
            else {
               console.log("Failed with state: " + state);
               component.set('v.searchResult',[]);
            }
        });
        $A.enqueueAction(action);
	},
})