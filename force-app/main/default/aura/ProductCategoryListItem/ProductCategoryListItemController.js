({
	selectCategory : function(component, event, helper) {
        let category = component.get('v.category');
        let compEvent =$A.get("e.c:CategorySelectEvent");
        
        compEvent.setParams({"category" : category});
        compEvent.fire();	
	} 
})