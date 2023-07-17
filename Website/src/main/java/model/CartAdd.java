package model;

public class CartAdd {

		String userId, productId;
		int cartQuantity;
	

		public CartAdd() {}
		
		public CartAdd(String userId, String productId, int cartQuantity){
			this.cartQuantity = cartQuantity;
			this.userId = userId;
			this.productId = productId;
			
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
