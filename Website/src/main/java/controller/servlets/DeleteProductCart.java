package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class DeleteProductCart
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/DeleteProductCart" })
public class DeleteProductCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cartId = request.getParameter("cartId");
		DbConnection con = new DbConnection();
		
		boolean result = con.deleteProductCart(MyConstants.DELETE_PRODUCT_CART, cartId);
		
		if(result) {
			request.setAttribute("deleteMessage", "Successfully Added a new product");
			 response.sendRedirect(request.getContextPath()+"//View/Pages/Cart.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("/View/Pages/Cart.jsp").forward(request, response);
		}
	}

}