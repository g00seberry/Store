({
	doInit : function(component, event, helper) { 
		helper.getBankCards(component);
	},
    
    pushCard: function(component, event, helper) {
        let cards = component.get('v.cards');
        cards.push(event.getParam('card'));
        component.set('v.cards',cards);
    },
    
    removeCard: function(component, event, helper) {
        let cards = component.get('v.cards');
        let card = event.getParam('card');
        
        cards = cards.filter(function( item ) {
            return item.Id !== card.Id;
        });
        
        component.set('v.cards',cards);
    },
})