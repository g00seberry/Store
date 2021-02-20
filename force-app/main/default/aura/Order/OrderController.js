({
	doInit : function(component, event, helper) {
		helper.getProductsFromOrder(component, helper);
	},
    
    addProduct : function(component, event, helper) {
        let productData = event.getParam('productData');
		let order = component.get("v.order");

        if(productData.orderDetail.Order__c != order.Id){
           return; 
        }
        
        let products = component.get('v.products');
        products.push(productData);    
        component.set('v.products',products);
        helper.calculateFullCost(component);
	},
    
    removeProduct : function(component, event, helper) {
        let productData = event.getParam('productData');
		let order = component.get("v.order");
        
        if(productData.orderDetail.Order__c != order.Id){
           return; 
        }
        
        let products = component.get('v.products');
        
        products = products.filter(function( item ) {
            return item.orderDetail.Id !== productData.orderDetail.Id;
        });
        
        component.set('v.products',products);
        helper.calculateFullCost(component);
	},  
    
    openCheckout: function(component, event, helper) {       
        _storeUtil.fireWithParams(
            "CloseModalEvent",
            {
                "id": "cart_modal"
            }
        );
        
        _storeUtil.fireWithParams(
            "OpenModalEvent",
            {
                "id": "checkout_modal"
            }
        );
	},
})