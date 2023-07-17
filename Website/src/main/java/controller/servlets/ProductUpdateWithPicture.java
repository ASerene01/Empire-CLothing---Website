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
import model.ProductsUpdateWithPicture;
import resources.MyConstants;
/**
 * Servlet implementation class ProductUpdateWithPicture
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductUpdateWithPicture" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ProductUpdateWithPicture extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productId = request.getParameter("productId");
		String productName = request.getParameter("productName");
		String productCategory = request.getParameter("productCategory");
		String productBrand = request.getParameter("productBrand");
		String productPrice = request.getParameter("productPrice");
		String productStock = request.getParameter("productStock");
		String productSearchTag = request.getParameter("productSearchTag");
		Part picture = request.getPart("picture");	
		ProductsUpdateWithPicture productModel = new ProductsUpdateWithPicture(productId, productName, productCategory, productBrand, productPrice, productStock, picture, productSearchTag);
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH_FOR_PRODUCTS;
	    String fileName = productModel.getProfilePicture();
	    if(!fileName.isEmpty() && fileName != null)
    		picture.write(savePath + fileName);
		DbConnection con = new DbConnection();
		
		boolean result = con.updateProductWithPicture(MyConstants.UPDATE_PRODUCT_PICTURE, productModel);
		if(result) {
			request.setAttribute("registerMessage", "Successfully Added a new product");
			
			 response.sendRedirect(request.getContextPath()+"//View/Pages/homeAdmin.jsp");
			//request.getRequestDispatcher("View/Pages/Login.jsp").forward(request, response)
		}else {
			
			request.getRequestDispatcher("/View/Pages/editProduct.jsp").forward(request, response);
		}
		
	}

}
