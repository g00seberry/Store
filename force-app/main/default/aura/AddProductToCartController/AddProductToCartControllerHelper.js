({
	addToCart : function(component, event) { 
        component.set('v.errors','');
        component.set('v.success','');
        
		let action = component.get("c.AddProductToCart");
        
        action.setParams({
            "productRequest":component.get("v.product"),
            "productQuantity":component.get("v.productQuantity"),
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.success','Добавлено в корзину');
               _storeUtil.fireWithParams(
                   "AddProductToOrderEvent",
                   {
                       "productData": JSON.parse(response.getReturnValue())
                   }    
               );
            }
            else {
                let error = response.getError(); 
               	component.set('v.errors',error[0].message);
            }
        });
        
        $A.enqueueAction(action);
	}
})