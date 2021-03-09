public with sharing class OrderController {
    
    @AuraEnabled
    public static Order__c GetOrderById(String orderId){
        return [SELECT
                Id, 
                CUser__c, 
                Status__c,
                StartProcessTime__c
                FROM Order__c 
                WHERE Id=: orderId];
    }
    
    @AuraEnabled
    public static List<Order__c> GetOrders(){
        CUser__c user = AuthController.CheckAuthUser();
        return [SELECT 
                Status__c,
                StartProcessTime__c 
                FROM Order__c 
                WHERE CUser__c=:user.Id  
                AND Status__c !='Cart' ];
    }
    
    @AuraEnabled
    public static Order__c CreateOrder(String bankCardId){
        CUser__c user = AuthController.CheckAuthUser();
        Order__c cart = GetCart();
        
        List<AggregateResult> orderDetailList = [SELECT 
                                                        Product__c,
                                                        SUM(ProductQuantity__c) productQuantity
                                                        FROM OrderDetail__c
                                                        WHERE Order__c= :cart.Id
                                                        GROUP BY Product__c];
        Decimal fullCost = 0; 
        for (AggregateResult orderDetail : orderDetailList) {
            Product__c product = ProductsController.getProduct((String)orderDetail.get('Product__c'));
            Decimal productQuantity = (Decimal)orderDetail.get('productQuantity');
            
            if(product.InStock__c < productQuantity){
                String deleteCount = String.valueOf(productQuantity - (Decimal)product.InStock__c);
                
                throw new AuraHandledException(
                    'Недостаточно на складе, удалите из корзины ' +
                    deleteCount +
                    ' штук товара ' +
                    product.ProductLabel__c
                );   
            }
            else{
                fullCost += product.ProductPrice__c * productQuantity;
                product.InStock__c -= productQuantity;
                update product;
            }
        }
        
        
        cart.Status__c = 'InProcess';
        cart.StartProcessTime__c = Datetime.now();
        
        update cart;
        
        BankCardController.Pay(bankCardId, fullCost);
        
        return cart;
    }
    
    @AuraEnabled
    public static Order__c GetCart(){
        CUser__c user = AuthController.CheckAuthUser();
        
        List<Order__c> cartList = [SELECT 
                                   Id, 
                                   CUser__c, 
                                   Status__c,
                                   StartProcessTime__c
                                   FROM Order__c 
                                   WHERE CUser__c=:user.Id
                                   AND Status__c='Cart'];
        
        if(cartList.size() == 0 ){
            Order__c cart = new Order__c(CUser__c=user.Id);
            insert cart;
            return cart;
        }
        
        return cartList[0];
    }  
    
    @AuraEnabled
    public static String AddProductToCart(Product__c productRequest, Integer productQuantity){
        ValidateAddProduct(productRequest, productQuantity);
        
        CUser__c user = AuthController.CheckAuthUser();   
        Order__c cart = GetCart();
        
        OrderDetail__c orderDetail = new OrderDetail__c(Product__c = productRequest.Id,
                                                        Order__c = cart.Id,
                                                        ProductQuantity__c = productQuantity);
        insert orderDetail;
        return JSON.serialize(new ProductCartItem(productRequest,orderDetail));
    }
    
    @AuraEnabled
    public static String RemoveProductFromCart(String orderDetailId){   
        AuthController.CheckAuthUser();
        
        OrderDetail__c orderDetail = [SELECT 
                                      Id,
                                      Product__c,
                                      Order__c,
                                      ProductQuantity__c
                                      FROM OrderDetail__c 
                                      WHERE Id = :orderDetailId];
        
        Product__C product = [SELECT 
                              Id,
                              InStock__c,
                              ProductDescription__c,
                              ProductLabel__c,
                              ProductPrice__c
                              FROM Product__C 
                              WHERE Id =:orderDetail.Product__c];
        
        delete orderDetail;
        
        return JSON.serialize(new ProductCartItem(product,orderDetail));
    }
    
    @AuraEnabled
    public static String GetProductsAndDetails(String orderId){
        AuthController.CheckAuthUser();   
        Order__c order = GetOrderById(orderId);
        
		List<ProductOrderItem> products = new List<ProductOrderItem>();
        
		List<OrderDetail__c> orderDetails = [SELECT 
                                             Id,
                                             Product__c,
                                             Order__c,
                                             ProductQuantity__c
                                             FROM OrderDetail__c
                                             WHERE Order__c = :order.Id];
        
        for (OrderDetail__c orderDetail : orderDetails) {
            Product__c product = [SELECT 
                                      Id,
                                      InStock__c,
                                      ProductDescription__c,
                                      ProductLabel__c,
                                      ProductPrice__c
                                      FROM Product__C 
                                      WHERE Id =:orderDetail.Product__c];
            
            products.add(new ProductOrderItem(product, orderDetail));
        }
        
        return JSON.serialize(products);
    } 
    
    private static void ValidateAddProduct(Product__C productRequest, Integer productCount){
        Product__C product = [SELECT 
                              Id,
                              InStock__c,
                              ProductDescription__c,
                              ProductLabel__c,
                              ProductPrice__c
                              FROM Product__C 
                              WHERE Id =:productRequest.Id];
        
        if(product.InStock__c < productCount)
        { 
            throw new AuraHandledException('Недостаточно на складе.');
        }
    }   
}