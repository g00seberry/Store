({
	fireUpdateFilterEvent: function(component, key ,value){
        let event =$A.get("e.c:UpdateFilterEvent");
        event.setParams({
            "filterParams":{
                "key": key,
            	"value": value
            }
        });

        event.fire();	
    }

})