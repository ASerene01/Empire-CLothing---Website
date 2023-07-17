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
import model.User;
import resources.MyConstants;
import model.EditUser;
import model.PasswordEncryptionWithAes;


@WebServlet(asyncSupported = true, urlPatterns = { "/ProfileUpdateAdmin" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class ProfileUpdateAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String username = request.getParameter("userName");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		String encryptedPassword = PasswordEncryptionWithAes.encrypt(username, password);
		EditUser userModel = new EditUser(userId, firstName, lastName, username, encryptedPassword, email, phoneNumber, userType);
		DbConnection con = new DbConnection();
		int result = con.updateUser(MyConstants.UPDATE_USER_INFO, userModel);
		
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Registered");
			
			 RequestDispatcher dispatcher = request.getRequestDispatcher("/View/Pages/ViewProfileAdmin.jsp");
			 dispatcher.forward(request, response);
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response);
		}else {
			request.setAttribute("registerMessage", "Something Went Wrong");
			request.getRequestDispatcher("/View/Pages/ProfileUpdateAdmin.jsp").forward(request, response);
		}
		
	}

}
