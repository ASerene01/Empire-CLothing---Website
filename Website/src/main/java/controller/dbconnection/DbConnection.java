package controller.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.CartAdd;
import model.CartSubtract;
import model.EditUser;
import model.EditUserCustomer;
import model.EditUserWithPicture;
import model.PasswordEncryptionWithAes;
import model.ProductOrders;
import model.User;
import model.UserAdmin;
import model.Products;
import model.ProductsUpdate;
import model.ProductsUpdateWithPicture;
import resources.MyConstants;

public class DbConnection {
	public static Connection getConnection(){
		try {
			Class.forName(MyConstants.DRIVER_NAME);
			Connection connection = DriverManager.getConnection(
					MyConstants.DB_URL,
					MyConstants.DB_USER_NAME,
					MyConstants.DB_USER_PASSWORD);
			return connection;
		}catch(SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	//	Start region Read operation
	public List<User> getAllUser(String query) {
        List<User> dataList = new ArrayList();
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
	            Statement stmt = dbConnection.createStatement();
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	            	User data = new User();
	                data.setFirstName(rs.getString("firstName"));
	                data.setLastName(rs.getString("lastName"));
	                data.setUsername(rs.getString("username"));
	                data.setPassword(rs.getString("password"));
	                data.setEmail(rs.getString("email"));
	                data.setPhoneNumber(rs.getString("phoneNumber"));
	                data.setEmail(rs.getString("picture"));
	                dataList.add(data);
	            }
	            rs.close();
	            stmt.close();
	            dbConnection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		}
        return dataList;
	}
	
	
	public ResultSet selectWhereQuery(String query, String id) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, id);
				
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					
				}
				return result;
			} catch (SQLException e) {
				return null;
			}
		}else {
			return null;
		}
	}

	public Boolean isUserAlreadyRegistered(String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.CHECK_LOGIN_INFO);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;		
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
						
	}
	
	public Boolean isUserRegistered(String query, String username, String password) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				//Statement statement = dbConnection.createStatement();
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				
				if(result.next()) {
					String userDb = result.getString("username");
					String passwordDb  = result.getString("password");
					String userType = result.getString("userType");
					String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, username);
					if(decryptedPwd!=null && userDb.equals(username) && decryptedPwd.equals(password) && userType.toLowerCase().equals(MyConstants.Customer)) return true;
					else return false;
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
		
	public int isAdmin(String username, String password) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.IS_USER);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				
				if(result.next()) {
					String passwordDb  = result.getString("password");
					String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, username);
					String userType = result.getString("userType");
					
					if(userType.toLowerCase().equals(MyConstants.ADMIN) && decryptedPwd.equals(password)) return 1;
					else return 0;
				}
				else return -1;
			} catch (SQLException e) { return -2; }
		}else { return -3; }
	}
	//	End region Read operation

	//	Start region Create operation
	public int registerUser(String query, User userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				if(isUserAlreadyRegistered(userModel.getUsername())) return -1;
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, userModel.getPassword());
				statement.setString(5, userModel.getEmail());
				statement.setString(6, userModel.getPhoneNumber());
				statement.setString(7, userModel.getProfilePicture());
				int result = statement.executeUpdate();
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) { return -2; }
		}else { return -3; }
	}
	//	End region Create operation
	public int registerUserForAdmin(String query, UserAdmin userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				
				if(isUserAlreadyRegistered(userModel.getUsername())) return -1;
				PreparedStatement statement = dbConnection.prepareStatement(query);
				
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, userModel.getPassword());
				statement.setString(5, userModel.getEmail());
				statement.setString(6, userModel.getPhoneNumber());
				statement.setString(7, userModel.getUserType());
				statement.setString(8, userModel.getProfilePicture());
			
				int result = statement.executeUpdate();
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) { return -2; }
		}else { return -3; }
	}
	//	Start region Update operation
	public int updateUser(String query, EditUser userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			
			try {
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, userModel.getEmail());
				statement.setString(5, userModel.getPhoneNumber());
				statement.setString(6, userModel.getPassword());
				statement.setString(7, userModel.getUserType());
				statement.setString(8, userModel.getUserId());
				int result = statement.executeUpdate();
				
				if(result>=0)return 1;
				else return 0;
			} catch (SQLException e) { return -2; }
		}else { return -3; }
	}
	public int updateUser(String query, EditUserCustomer userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			
			try {
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, userModel.getEmail());
				statement.setString(5, userModel.getPhoneNumber());
				statement.setString(6, userModel.getPassword());
				statement.setString(7, userModel.getUserType());
				statement.setString(8, userModel.getUserId());
				int result = statement.executeUpdate();
				
				if(result>=0)return 1;
				else return 0;
			} catch (SQLException e) { return -2; }
		}else { return -3; }
	}
	public int updateUserWithPicture(String query, EditUserWithPicture userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, userModel.getEmail());
				statement.setString(5, userModel.getPhoneNumber());
				statement.setString(6, userModel.getPassword());
				statement.setString(7, userModel.getUserType());
				statement.setString(8, userModel.getProfilePicture());
				statement.setString(9, userModel.getUserId());
				int result = statement.executeUpdate();
				
				if(result>=0)return 1;
				else return 0;
			} catch (SQLException e) { return -2; }
		}else { return -3; }
	}
	//	End region Update operation
	
	//	Start region Delete operation
	public Boolean deleteUser(String query, String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation
	
//	Start region Create operation for products
	public int registerProduct(String query, Products userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getProductName());
				statement.setString(2, userModel.getProductCategory());
				statement.setString(3, userModel.getProductBrand());
				statement.setString(4, userModel.getProductPrice());
				statement.setString(5, userModel.getProductStock());
				statement.setString(6, userModel.getProductSearchTag());
				statement.setString(7, userModel.getProfilePicture());
				int result = statement.executeUpdate();
				
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) { return -2; }
		}else { return -3; }
	}
//		End region Create operation
	
	//	Start region Delete operation
	public Boolean deleteProduct(String query, String productId) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productId);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation
	public Boolean updateProduct(String query, ProductsUpdate productModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productModel.getProductName());
				statement.setString(2, productModel.getProductCategory());
				statement.setString(3, productModel.getProductBrand());
				statement.setString(4, productModel.getProductPrice());
				statement.setString(5, productModel.getProductStock());
				statement.setString(6, productModel.getProductSearchTag());
				statement.setString(7, productModel.getProductId());
				
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation

public Boolean updateProductWithPicture(String query, ProductsUpdateWithPicture productModel) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			PreparedStatement statement = dbConnection.prepareStatement(query);
			statement.setString(1, productModel.getProductName());
			statement.setString(2, productModel.getProductCategory());
			statement.setString(3, productModel.getProductBrand());
			statement.setString(4, productModel.getProductPrice());
			statement.setString(5, productModel.getProductStock());
			statement.setString(6, productModel.getProductSearchTag());
			statement.setString(7, productModel.getProfilePicture());
			statement.setString(8, productModel.getProductId());
			int result = statement.executeUpdate();
			if(result>=0)return true;
			else return false;
		} catch (SQLException e) { return null; }
	}else { return null; }
}
//	End region Delete operation
//Start region Create operation for products
public int addToCart(String query, CartAdd userModel) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			PreparedStatement statement = dbConnection.prepareStatement(query);
			if(isCartThere(userModel.getUserId(),userModel.getProductId()) >= 1) {
				String cartQuantity =  String.valueOf(Integer.valueOf((userModel.getCartQuantity()))+1);
				statement.setString(1, cartQuantity);
				statement.setString(2, userModel.getUserId());
				statement.setString(3, userModel.getProductId());
			}
			else {
			statement.setString(1, userModel.getUserId());
			statement.setString(2, userModel.getProductId());
			statement.setInt(3, userModel.getCartQuantity());
			}
			int result = statement.executeUpdate();
			if(result>=0) return 1;
			else return 0;
		} catch (Exception e) { return -2; }
	}else { return -3; }
}
public int subtractFromCart(String query, CartSubtract cartModel) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			int result = 0;
			
			PreparedStatement statement = dbConnection.prepareStatement(query);
			if(isCartThere(cartModel.getUserId(),cartModel.getProductId()) >= 1) {
				String cartQuantity =  String.valueOf(Integer.valueOf((cartModel.getCartQuantity()))-1);
				statement.setString(1, cartQuantity);
				statement.setString(2, cartModel.getUserId());
				statement.setString(3, cartModel.getProductId());
				result = statement.executeUpdate();
			}
			
			if(result>=0) return 1;
			else return 0;
		} catch (Exception e) { return -2; }
	}else { return -3; }
}
//	End region Create operation
public int isCartThere(String userId, String productId) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			PreparedStatement statement = dbConnection.prepareStatement(MyConstants.CART_INFO);
			statement.setString(1, userId);
			statement.setString(2, productId);
			ResultSet result = statement.executeQuery();
			if(result.next()) {
				int cartQuantity = result.getInt("cartQuantity");	
				return cartQuantity;
			}else return -1;
		} catch (SQLException e) { return -2; }
	}else { return -3; }
					
}
public String getCartQuantity(String query, String id) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			
			PreparedStatement statement = dbConnection.prepareStatement(query);
			statement.setString(1, id);
			
			ResultSet result = statement.executeQuery();
			if(result.next()) {}
			
			String cartQuantity = result.getString("sumofcart");
			
			return cartQuantity;
		} catch (SQLException e) {
			return "0";
		}
	}else {
		return "0";
	}

}
//Start region Delete operation
public Boolean deleteProductCart(String query, String cartId) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			PreparedStatement statement = dbConnection.prepareStatement(query);
			statement.setString(1, cartId);
			int result = statement.executeUpdate();
			if(result>=0)return true;
			else return false;
		} catch (SQLException e) { return null; }
	}else { return null; }
}
//	End region Delete operation

public int orderProduct(String query, ProductOrders orderModel) {
	Connection dbConnection = getConnection();
	if(dbConnection != null) {
		try {
			
			PreparedStatement statement = dbConnection.prepareStatement(query);
			statement.setString(1, orderModel.getProductId());
			statement.setString(2, orderModel.getUserId());
			statement.setString(3, orderModel.getOrderQuantity());
			System.out.print(statement.toString());
			int result = statement.executeUpdate();
			
			if(result>=0) return 1;
			else return 0;
		} catch (SQLException e) { return -2; }
	}else { return -3; }
}
public ResultSet GetAllCart(String query, String userId) {
	Connection dbConnection = getConnection();
	
	if(dbConnection != null) {
		try {
			
			PreparedStatement statement = dbConnection.prepareStatement(query);
			statement.setString(1, userId);
			ResultSet result = statement.executeQuery();
			return result;
		} catch (SQLException e) { return null; }
	}else { return null; }
					
}
}


