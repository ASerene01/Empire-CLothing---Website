package model;

public class CartSubtract {

	String userId, productId,cartId;
	int cartQuantity;


	public CartSubtract() {}
	
	public CartSubtract(String userId, String productId, int cartQuantity,String cartId){
		this.cartQuantity = cartQuantity;
		this.userId = userId;
		this.productId = productId;
		this.cartId = cartId;
		
	}
	public String getCartId() {
		return cartId;
	}

	public void setCartId(String cartId) {
		this.cartId = cartId;
	}



	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	
	public int getCartQuantity() {
		return cartQuantity;
	}

	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}


}
