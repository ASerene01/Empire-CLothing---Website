package model;

public class ProductOrders {

	String productId,userId,orderQuantity;



	
	public ProductOrders() {}
	
	public ProductOrders(String productId,String userId, String orderQuantity){
		
		this.productId = productId;
		this.userId = userId;
		this.orderQuantity = orderQuantity;
		
	}
	
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(String orderQuantity) {
		this.orderQuantity = orderQuantity;
	}


}
