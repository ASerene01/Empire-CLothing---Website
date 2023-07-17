package resources;

import java.io.File;

public class MyConstants {
	// Start Region: Database Configuration
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/theempireclothing";
	public static final String DB_USER_NAME = "root"; 		
	public static final String DB_USER_PASSWORD= ""; 
	
	public static final String ADMIN = "admin";
	public static final String Customer = "customer";
	
	public static final String IMAGE_DIR = "Java Preferences\\Empire Clothing\\src\\main\\webapp\\View\\Pictures\\Profile\\";
	public static final String IMAGE_DIR_FOR_PRODUCTS = "Java Preferences\\Empire Clothing\\src\\main\\webapp\\View\\Pictures\\Products\\";
	public static final String IMAGE_DIR_SAVE_PATH = "D:" + File.separator + IMAGE_DIR;
	public static final String IMAGE_DIR_SAVE_PATH_FOR_PRODUCTS = "D:" + File.separator + IMAGE_DIR_FOR_PRODUCTS;
	
	// End Region: Database Configuration
	
	// Start Region: Select Query
	public static final String CHECK_LOGIN_INFO = "SELECT username, password, userType FROM user WHERE username = ?";
	public static final String GET_ALL_INFO = "SELECT * FROM user";
	public static final String GET_ALL_INFO_BY_USERNAME = "SELECT * FROM user WHERE username = ?";
	public static final String GET_ALL_INFO_BY_USERID = "SELECT * FROM user WHERE userId = ?";
	public static final String IS_USER = "SELECT username, password, userType FROM user WHERE username = ?";
	
	// Start Region: Insert Query
	public static final String USER_REGISTER = "INSERT INTO user"
			+ "(firstName, lastName, username, password, email, phoneNumber, picture)"
			+ " VALUES(?,?,?,?,?,?,?)";
	public static final String USER_REGISTER_FOR_ADMIN = "INSERT INTO user"
			+ "(firstName, lastName, username, password, email, phoneNumber, userType, picture)"
			+ " VALUES(?,?,?,?,?,?,?,?)";
	// End Region: Insert Query
	
	// Start Region: Update Query
	public static final String UPDATE_USER_INFO = "UPDATE user SET firstName=?, "
				+ "lastName=?, username=?, email=?, phoneNumber=?, password=?, userType=? WHERE userId=?";
	public static final String UPDATE_USER_INFO_PICTURE = "UPDATE user SET firstName=?, "
			+ "lastName=?, username=?, email=?, phoneNumber=?, password=?, userType=?, picture=? WHERE userId=?";
	// End Region: Update Query
		
	// Start Region: Delete Query
	public static final String DELETE_USER = "DELETE FROM user WHERE username=?";
	// End Region: Delete Query

	//Start Region: Insert Query for product
		public static final String PRODUCT_REGISTER = "INSERT INTO product"
				+ "(productName, productCategory, productBrand, productPrice, productStock, productSearchTag, productPicture)"
				+ " VALUES(?,?,?,?,?,?,?)";
		public static final String UPDATE_PRODUCT_NOPICTURE = "UPDATE product SET productName=?, "
				+ "productCategory=?, productBrand=?, productPrice=?, productStock=?, productSearchTag=? WHERE productid=?";
		public static final String UPDATE_PRODUCT_PICTURE = "UPDATE product SET productName=?, "
				+ "productCategory=?, productBrand=?, productPrice=?, productStock=?, productSearchTag=?, productPicture=? WHERE productid=?";
		// End Region: Insert Query
		public static final String DELETE_PRODUCT = "DELETE FROM product WHERE productId=?";
		// End Region: Delete Query
		
		//Cart
		public static final String CART_ADD = "INSERT INTO cart"
				+ "(userId, productId, cartQuantity)"
				+ " VALUES(?,?,?)";
			public static final String CART_INFO = "SELECT * FROM cart WHERE userId = ? AND productId = ?  ";
			public static final String CART_UPDATE = "UPDATE cart SET "+"cartQuantity=? WHERE userId = ? AND productId = ? ";
			public static final String CART_NUMBER_UPDATE = "SELECT SUM(cartQuantity) as sumofcart, userId FROM `cart` WHERE userId = ? GROUP BY userId ";
			public static final String DELETE_PRODUCT_CART = "DELETE FROM cart WHERE cartId = ?";
			public static final String All_CART_PRODUCTS = "SELECT * from product p, cart c where p.productId = c.productId AND userId = ?";
			
			public static final String ORDER_ADD = "INSERT INTO `orderTable`(`productId`,`userId`,`orderQuantity`) VALUES (?,?,?);";
}


