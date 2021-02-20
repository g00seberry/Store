({
	doInit : function(component, event, helper) {
		helper.getOrders(component);
	},
    
    addOrder: function(component, event, helper) {
        let orders = component.get('v.orders');
        orders.push(event.getParam('order'));
        component.set('v.orders', orders);
    }
})