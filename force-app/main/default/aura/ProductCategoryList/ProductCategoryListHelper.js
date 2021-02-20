({
	getChildCategories: function(component, parentCategoryId=null){
        
        let action = component.get("c.getChildCategories");
        
        action.setParams({
            parentCategoryId:parentCategoryId,
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.productCategories", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    fireUpdateFilterEvent: function(component, category){
        let event =$A.get("e.c:UpdateFilterEvent");
        
        event.setParams({
            "filterParams":{
                "key": "category",
            	"value": category
            }
        });

        event.fire();	
    }
})