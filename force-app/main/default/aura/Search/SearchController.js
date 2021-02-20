({
    trySearchSend:function(component, event, helper) {
        let unpend = component.get('c.unpend');
        $A.enqueueAction(unpend);
        
        let pend = component.get('c.pend');
        $A.enqueueAction(pend);
    },
    
	search : function(component, event, helper) {
		helper.search();
	},
    
    pend : function(component, event, helper) {
        let timerId = setTimeout($A.getCallback(function() {
            helper.search(component);
        }), 500);  
        
        component.set('v.timerId', timerId);
	},
    
    unpend : function(component, event, helper) {
        let timerId = component.get('v.timerId');
        clearTimeout(timerId);
	},
    
    showPicklist: function(component, event, helper) {
        component.set('v.disabledPicklist', false);
	},    
})