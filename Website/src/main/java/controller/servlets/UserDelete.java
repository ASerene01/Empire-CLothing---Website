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
 * Servlet implementation class UserDelete
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/UserDelete" })
public class UserDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		DbConnection con = new DbConnection();
		System.out.print("Hello" + username);
		boolean result = con.deleteUser(MyConstants.DELETE_USER, username);
		
		if(result) {
			request.setAttribute("deleteMessage", "Successfully Added a new product");
			System.out.print("Hello");
			 response.sendRedirect(request.getContextPath()+"//View/Pages/User.jsp");
			 System.out.print("Hello");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			request.setAttribute("deleteMessage", "Delete Unsuccessful");
			request.getRequestDispatcher("/View/Pages/homeAdmin.jsp").forward(request, response);
		}
	}

}
