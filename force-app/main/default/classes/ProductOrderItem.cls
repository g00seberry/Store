public class ProductOrderItem{
        public Product__c product;
        public OrderDetail__c orderDetail;
        
        public ProductOrderItem(Product__c product_r, OrderDetail__c orderDetail_r){
            product = product_r;
            orderDetail = orderDetail_r;
        }  
}