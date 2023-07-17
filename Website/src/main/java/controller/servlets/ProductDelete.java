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
 * Servlet implementation class ProductDelete
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductDelete" })
public class ProductDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productId = request.getParameter("productId");
		DbConnection con = new DbConnection();
		
		boolean result = con.deleteProduct(MyConstants.DELETE_PRODUCT, productId);
		
		if(result) {
			request.setAttribute("deleteMessage", "Successfully Added a new product");
			 response.sendRedirect(request.getContextPath()+"//View/Pages/homeAdmin.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("/View/Pages/homeAdmin.jsp").forward(request, response);
		}
	}

}
