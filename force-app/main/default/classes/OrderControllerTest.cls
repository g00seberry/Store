@isTest
public class OrderControllerTest {
    @isTest
    public static void AddProductToCartTest() {
        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;

        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        try {   
            OrderController.AddProductToCart(product, 1);
            System.assertEquals(true, true);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
        
    }

    @isTest
    public static void AddProductToCartOutOfStockTest() {
        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;
        
        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        try {   
            OrderController.AddProductToCart(product, 20);
            System.assertEquals(true, false);
        } catch (Exception e) {
            System.assertEquals(true, true);
        }
        
    }

    @isTest
    public static void RemoveProductFromCartTest() {
        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;

        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        try {   
            ProductCartItem orderData = (ProductCartItem)JSON.deserialize(OrderController.AddProductToCart(product, 1), ProductCartItem.class);
            ProductCartItem orderDataDel = (ProductCartItem)JSON.deserialize(OrderController.RemoveProductFromCart(orderData.orderDetail.Id), ProductCartItem.class);

            System.assertEquals(true, orderData.orderDetail.Id == orderDataDel.orderDetail.Id);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
        
    }

    @isTest
    public static void GetProductsAndDetailstTest() {
        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;

        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        try {   
            ProductCartItem orderData = (ProductCartItem)JSON.deserialize(OrderController.AddProductToCart(product, 1), ProductCartItem.class);

            List<ProductOrderItem> orderDataList = (List<ProductOrderItem>)JSON.deserialize(OrderController.GetProductsAndDetails(orderData.orderDetail.Order__c), List<ProductOrderItem>.class);

            System.assertEquals(true, orderDataList.size() == 1);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
        
    }
    
    @isTest
    public static void GetProductsAndDetailstInvalidOrderTest() {
        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;

        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        try {   
            List<ProductOrderItem> orderDataList = (List<ProductOrderItem>)JSON.deserialize(OrderController.GetProductsAndDetails('000000000000000000'), List<ProductOrderItem>.class);

            System.assertEquals(true, false);
        } catch (Exception e) {
            System.assertEquals(true, true);
        }
        
    }

    @isTest
    public static void CreateOrderTest() {
        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );
        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        BankCard__c cardRequest = new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
        );
        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(cardRequest));

        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);
        insert product;
        OrderController.AddProductToCart(product, 1);

        try {   
            Order__c order = OrderController.CreateOrder(card.Id);

            System.assertEquals(true, order.Status__c == 'InProcess');
        } catch (Exception e) {
            System.assertEquals(true, false);
        }  
    }

    @isTest
    public static void CreateOrderOutOfStockTest() {
        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );
        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        BankCard__c cardRequest = new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
        );
        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(cardRequest));

        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);

        insert product;

        OrderController.AddProductToCart(product, 10);
        OrderController.AddProductToCart(product, 10);

        try {   
            Order__c order = OrderController.CreateOrder(card.Id);

            System.assertEquals(true, false);
        } catch (Exception e) {
            System.assertEquals(true, true);
        }
        
    }

    @isTest
    public static void GetOrdersTest() {
        CUser__c user = CUserControllerTest.CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );
        user.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(user));

        BankCard__c cardRequest = new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
        );
        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(cardRequest));

        Product__C product = ProductsControllerTest.CreateTestProduct('name', 1000, 'productLabel', 'productDescription', 10);
        insert product;
        OrderController.AddProductToCart(product, 1);

        try {   
            Order__c order = OrderController.CreateOrder(card.Id);
            List<Order__c> orders = OrderController.GetOrders();

            System.assertEquals(true, orders.size() == 1);
        } catch (Exception e) {
            System.assertEquals(true, false);
        }
        
    }
}
