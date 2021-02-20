({
	addBankCard : function(component, event, helper) {
       helper.addBankCard(component, helper);
	},
    
    completeMonth: function(component, event, helper){
        
        if(!helper.checkDate(component)){
            return;
        }
        
        let card = component.get('v.card');
        
        let date = card.ExpiryDate__c;
        let expiryDateCache = component.get('v.expiryDateCache');
        
        if(date.length == 2 && date.length > expiryDateCache.length){
            card.ExpiryDate__c += '/';
            component.set('v.card', card);
        }
      
        component.set('v.expiryDateCache' , card.ExpiryDate__c);
    },

})