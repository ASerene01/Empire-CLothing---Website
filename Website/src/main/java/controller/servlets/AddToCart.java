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
import model.Products;
import resources.MyConstants;
/**
 * Servlet implementation class AddToCart
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AddToCart" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String productId = request.getParameter("productId");
		String userId = request.getParameter("userId");
	    int result;
		DbConnection con = new DbConnection();
		if(con.isCartThere(userId,productId) >= 1) {
			int cartQuantity = con.isCartThere(userId,productId);
			CartAdd cartModel = new CartAdd(userId,productId,cartQuantity);
			 result = con.addToCart(MyConstants.CART_UPDATE, cartModel);
		}
		else {
			int cartQuantity = 1;
			CartAdd cartModel = new CartAdd(userId,productId,cartQuantity);
		 result = con.addToCart(MyConstants.CART_ADD, cartModel);
		}
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Added a new product");
			 response.sendRedirect(request.getContextPath()+"/home.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("home.jsp").forward(request, response);
		}
		
	}

}
