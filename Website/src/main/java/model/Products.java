package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class Products {
	String productName, productCategory, productBrand, productPrice, productStock, productSearchTag, profilePicture, productRating;
	public Products() {}
	
	public Products(String productName, String productCategory, String productBrand, 
			String productPrice, String productStock, Part part, String productSearchTag){
		this.productName = productName;
		this.productCategory = productCategory;
		this.productBrand = productBrand;
		this.productPrice = productPrice;
		this.productStock = productStock;
		this.productSearchTag = productSearchTag;
		this.profilePicture = getImageUrl(part);
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

	public String getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(Part part) {
		this.profilePicture = getImageUrl(part);
	}

	public String getProductRating() {
		return productRating;
	}

	public void setProductRating(String productRating) {
		this.productRating = productRating;
	}


private String getImageUrl(Part part) {
	String savePath = MyConstants.IMAGE_DIR_SAVE_PATH_FOR_PRODUCTS;
	File fileSaveDir = new File(savePath);
	String profilePicture = null;
	if (!fileSaveDir.exists()) {
		fileSaveDir.mkdir();
	}
	String contentDisp = part.getHeader("content-disposition");
	String[] items = contentDisp.split(";");
	for (String s : items) {
		if (s.trim().startsWith("filename")) {
			profilePicture = s.substring(s.indexOf("=") + 2, s.length() - 1);
		}
	}
	if(profilePicture == null || profilePicture.isEmpty()) {
		profilePicture = "download.png";
	}
	return profilePicture;
}
}
