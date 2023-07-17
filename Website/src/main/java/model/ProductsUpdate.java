package model;


public class ProductsUpdate {
	String productId, productName, productCategory, productBrand, productPrice, productStock, productSearchTag;
	public ProductsUpdate() {}
	
	public ProductsUpdate(String productId, String productName, String productCategory, String productBrand, 
			String productPrice, String productStock, String productSearchTag){
		this.productId = productId;
		this.productName = productName;
		this.productCategory = productCategory;
		this.productBrand = productBrand;
		this.productPrice = productPrice;
		this.productStock = productStock;
		this.productSearchTag = productSearchTag;
	}
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
 
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}

	public String getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductStock() {
		return productStock;
	}

	public void setProductStock(String productStock) {
		this.productStock = productStock;
	}

	public String getProductSearchTag() {
		return productSearchTag;
	}

	public void setProductSearchTag(String productSearchTag) {
		this.productSearchTag = productSearchTag;
	}

	
}
