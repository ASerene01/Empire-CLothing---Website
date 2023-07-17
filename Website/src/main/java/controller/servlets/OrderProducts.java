package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.CartAdd;
import model.ProductOrders;
import model.Products;
import resources.MyConstants;
/**
 * Servlet implementation class OrderProducts
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/OrderProducts" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class OrderProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
	    int result = 0;
	    Boolean delete;
		DbConnection con = new DbConnection();
	
		ResultSet cartFetchs = con.GetAllCart(MyConstants.All_CART_PRODUCTS, userId);
		
		try {
			while(cartFetchs.next()) {
				String cartId = (cartFetchs.getString("cartId"));
				String productId = (cartFetchs.getString("productId"));
				String user = (cartFetchs.getString("userId"));
				String cartQuantity = (cartFetchs.getString("cartQuantity"));
				ProductOrders orderModel = new ProductOrders(productId,user,cartQuantity);
				result = con.orderProduct(MyConstants.ORDER_ADD, orderModel);
				
				delete = con.deleteProductCart(MyConstants.DELETE_PRODUCT_CART, cartId);
				System.out.print(result);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Added a new product");
			 response.sendRedirect(request.getContextPath()+"/View/Pages/Cart.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("/View/Pages/Cart.jsp").forward(request, response);
		}
		
	}

}
