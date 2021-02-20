({ 
    doInit: function(component, event, helper) {
        helper.checkAuthUser(component,helper)
	},
    
	updateUser : function(component, event, helper) { 
        helper.updateUser(component, event.getParam('user'));
	}
})