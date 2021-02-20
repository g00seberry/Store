({
  removeProductFromCart: function(component, helper) {
    component.set("v.errors", "");

    let action = component.get("c.RemoveProductFromCart");

    action.setParams({
      orderDetailId: component.get("v.orderDetail.Id")
    });

    action.setCallback(this, function(response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        _storeUtil.fireWithParams(
            "RemoveProductFromOrderEvent", 
            {
                "productData": JSON.parse(response.getReturnValue())
            }
        );
      } else {
        let error = response.getError();
        component.set("v.errors", error[0].message);
      }
    });

    $A.enqueueAction(action);
  }
});