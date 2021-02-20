({
    nextPage : function(component, event, helper) { 
        let offset = component.get('v.offset');
        let limit = component.get('v.limit');
        let productsCount = component.get('v.productsCount');
        
        if(offset>=productsCount-limit){
            return;
        }
        
        offset+=limit;
        
        component.set('v.offset', offset);
        component.set('v.pageNum', component.get('v.pageNum')+1);
        
        _storeUtil.fireWithParams(
        	"UpdatePagerParamsEvent",
            {
            "pagerParams": {
                           'limit':limit,
                           'offset':offset,
                           }
            }
        );
	},
    
    prevPage : function(component, event, helper) { 
        let offset = component.get('v.offset');
        let limit = component.get('v.limit');

        if(offset===0){
            return;
        }
        
        offset-=limit;
        
        component.set('v.offset', offset);
        component.set('v.pageNum', component.get('v.pageNum')-1);
        
        _storeUtil.fireWithParams(
        	"UpdatePagerParamsEvent",
            {
            "pagerParams": {
                           'limit':limit,
                           'offset':offset,
                           }
            }
        );
	},
})