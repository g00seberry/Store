public class ProductCartItem {
  public Product__c product;
  public OrderDetail__c orderDetail;

  public ProductCartItem(Product__c product_r, OrderDetail__c orderDetail_r) {
    product = product_r;
    orderDetail = orderDetail_r;
  }
}
