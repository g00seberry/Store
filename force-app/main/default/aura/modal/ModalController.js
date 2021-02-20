({
   openModal: function(component, event, helper) {
       let modalId = component.get('v.id');
       let eventModalId = event.getParam("id");
       
       if(modalId !== eventModalId){
           return;
       }
       
       component.set("v.isOpen", true);
   },
 
   closeModal: function(component, event, helper) {
       let modalId = component.get('v.id');
       let eventModalId = event.getParam("id");
              
       if(!eventModalId || modalId === eventModalId){
           component.set("v.isOpen", false);
       }
   },
})