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
import model.UserAdmin;
import resources.MyConstants;
import model.PasswordEncryptionWithAes;
/**
 * Servlet implementation class UserRegisterFromAdmin
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/UserRegisterFromAdmin" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class UserRegisterFromAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String userName = request.getParameter("userName");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		String encryptedPassword = PasswordEncryptionWithAes.encrypt(userName, password);
		Part picture = request.getPart("picture");	
		UserAdmin userModel = new UserAdmin(firstName, lastName, userName, encryptedPassword, email, phoneNumber, userType, picture);
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = userModel.getProfilePicture();
	    if(!fileName.isEmpty() && fileName != null)
    		picture.write(savePath + fileName);
	    
		DbConnection con = new DbConnection();
		
		int result = con.registerUserForAdmin(MyConstants.USER_REGISTER_FOR_ADMIN, userModel);
		
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Registered");
			
			 RequestDispatcher dispatcher = request.getRequestDispatcher("/View/Pages/User.jsp");
			 dispatcher.forward(request, response);
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("registerMessage", "User Already Exists");
			request.getRequestDispatcher("/View/Pages/AddNewUser.jsp").forward(request, response);
		}else {
			
			request.getRequestDispatcher("/View/Pages/AddNewUser.jsp").forward(request, response);
		}
	}

}
