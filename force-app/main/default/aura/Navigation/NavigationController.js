({
	openLoginModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"login_modal"
             }
         );
	},
    
    openLogoutModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"logout_modal"
             }
         );
	},
    
    openRegisterModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"register_modal"
             }
         );
	},
    
    openProfileModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"profile_modal"
             }
         );
	},
    
    openCartModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"cart_modal"
             }
         );
	},
    
    openOrderListModal : function(component, event, helper) {
         _storeUtil.fireWithParams(
             "OpenModalEvent",
             {
                 "id":"order_list_modal"
             }
         );
	},
})