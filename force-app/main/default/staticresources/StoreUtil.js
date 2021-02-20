//UpdateUserEvent
//AddBankCardEvent
//RemoveBankCardEvent
//NewOrderEvent
//AddProductToOrderEvent
//RemoveProductFromOrderEvent
//UserIsAuthEvent

window._storeUtil = (function() {
    return { 
        fire: function(eventName) {
          $A.get('e.c:' + eventName).fire();
        },
        
        fireWithParams: function(eventName, params) {
          $A.get('e.c:' + eventName)
            .setParams(params)
            .fire();
        }
    };
}());


