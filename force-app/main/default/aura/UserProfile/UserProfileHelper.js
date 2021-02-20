({
  trySave: function(component) {
    component.set("v.success", "");
    component.set("v.errors", "");

    let action = component.get("c.UpdateUser");
    let currentUser = JSON.stringify(component.get("v.user"));

    action.setParams({
      userRequest: currentUser
    });

    action.setCallback(this, function(response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        _storeUtil.fireWithParams("UpdateUserEvent", {
          "user": response.getReturnValue()
        });

        component.set("v.success", "Профиль обновлён.");
      } else {
        let error = response.getError();
        component.set("v.errors", error[0].message);
      }
    });

    $A.enqueueAction(action);
  }
});