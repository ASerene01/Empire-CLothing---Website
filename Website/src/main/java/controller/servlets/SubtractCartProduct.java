package controller.servlets;

import java.io.IOException;

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
import model.CartSubtract;
import model.Products;
import resources.MyConstants;
/**
 * Servlet implementation class SubtractCartProduct
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/SubtractCartProduct" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class SubtractCartProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String productId = request.getParameter("productId");
		String userId = request.getParameter("userId");
		String cartId = request.getParameter("cartId");
		
	    int result = 0;
		DbConnection con = new DbConnection();
		if(con.isCartThere(userId,productId) > 1) {
			int cartQuantity = con.isCartThere(userId,productId);
			CartSubtract cartModel = new CartSubtract(userId,productId,cartQuantity,cartId);
			 result = con.subtractFromCart(MyConstants.CART_UPDATE, cartModel);
		}else {
			
			con.deleteProductCart(MyConstants.DELETE_PRODUCT_CART, cartId);
			 result = -1;
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
