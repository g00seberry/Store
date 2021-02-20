<aura:application extends="force:slds" controller="AuthController">
  <ltng:require scripts="{!$Resource.StoreUtil}"/>
  <ltng:require styles="{!$Resource.style}" />  
    
  <aura:handler 
                name="init" 
                action="{!c.doInit}" 
                value="{!this}" />
  <aura:handler 
                event="c:UpdateUserEvent" 
                action="{!c.updateUser}" />

  <aura:attribute 
                  name="user" 
                  type="Object" 
                  default="null" />
  <aura:attribute 
                  name="isAuth" 
                  type="Boolean" 
                  default="false" />

  <div class="slds-grid slds-gutters">
    <div class="slds-col slds-size_8-of-12">
      <c:Search /> 
      <c:ProductsContainer />
    </div>
    <div class="slds-col slds-size_4-of-12">
      <div class="sticky-top">
        <c:Navigation isAuth="{! v.isAuth }" />
        <c:ProductPriceFilter />
        <c:ProductCategoryList />
      </div>
    </div>
  </div>

  <c:Modal id="register_modal" fitContent="true">
    <aura:set attribute="content"> 
      <c:RegistrationForm /> 
    </aura:set>
  </c:Modal>

  <c:Modal id="login_modal" fitContent="true">
    <aura:set attribute="content"> 
      <c:LoginForm />
    </aura:set>
  </c:Modal>

  <c:Modal id="logout_modal" fitContent="true">
    <aura:set attribute="content">
      <c:LogoutForm user="{! v.user}" />
    </aura:set>
  </c:Modal>

  <c:Modal id="profile_modal" fitContent="true">
    <aura:set attribute="content">
      <c:UserProfile user="{! v.user}" heading="Профиль пользователя" />
      <c:ResetPasswordForm />
      <c:BankCardFormAdd />
      <c:BankCardList />
    </aura:set>
  </c:Modal>

  <c:Modal id="cart_modal">
    <aura:set attribute="content">
      <c:Cart /> 
    </aura:set>
  </c:Modal>

  <c:Modal id="order_list_modal">
    <aura:set attribute="content"> 
      <c:OrderList /> 
    </aura:set>
  </c:Modal>

  <c:Modal id="checkout_modal" fitContent="true">
    <aura:set attribute="content">
      <c:Checkout user="{! v.user}" /> 
    </aura:set>
  </c:Modal>
</aura:application>