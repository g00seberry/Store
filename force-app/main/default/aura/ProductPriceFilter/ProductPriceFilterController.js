({
	updatePriceMin : function(component, event, helper) {
        let priceMin = component.get('v.priceMin');
        priceMin = priceMin?priceMin:null;
		helper.fireUpdateFilterEvent(component,'priceMin',priceMin);
	},
    
    updatePriceMax : function(component, event, helper) {
        let priceMax = component.get('v.priceMax');
        priceMax = priceMax?priceMax:null;
		helper.fireUpdateFilterEvent(component,'priceMax',priceMax);
	},
})