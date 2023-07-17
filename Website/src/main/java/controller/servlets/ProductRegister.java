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
import model.Products;
import resources.MyConstants;
/**
 * Servlet implementation class ProductRegister
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductRegister" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ProductRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		String productCategory = request.getParameter("productCategory");
		String productBrand = request.getParameter("productBrand");
		String productPrice = request.getParameter("productPrice");
		String productStock = request.getParameter("productStock");
		String productSearchTag = request.getParameter("productSearchTag");
		System.out.print("Hello" + productName);
		Part picture = request.getPart("picture");	
		Products productModel = new Products(productName, productCategory, productBrand, productPrice, productStock, picture, productSearchTag);
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH_FOR_PRODUCTS;
	    String fileName = productModel.getProfilePicture();
	    if(!fileName.isEmpty() && fileName != null)
    		picture.write(savePath + fileName);
		DbConnection con = new DbConnection();
		
		int result = con.registerProduct(MyConstants.PRODUCT_REGISTER, productModel);
		
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Added a new product");
			
			 response.sendRedirect(request.getContextPath()+"//View/Pages/homeAdmin.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("/View/Pages/homeAdmin.jsp").forward(request, response);
		}
		
	}

}
