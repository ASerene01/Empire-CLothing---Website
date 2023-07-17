<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="statemanagement.SessionManage"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<%! SessionManage mySession = new SessionManage(); %>
<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	// Deleting item on database when delete button is clicked.
	if (request.getParameter("deleteId") != null) {
	    String id = request.getParameter("deleteId");
	    dbConn.deleteUser(MyConstants.DELETE_USER, id);
	}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/StyleSheet/page.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/StyleSheet/CreateAccount.css" />
    <title>Create Account</title>
  </head>
  <body style="background-color: #141617">
    <!--Start of header where logo and Cart consists-->
    <header class="header">
      <div class="searchsection">
        <a href="#" class="logocontainer" style="justify-content: center">
          <img src="../Pictures/logo.png" class="logo" alt="logo" width="220px" />
        </a>
      </div>
    </header>
    <!--End of header-->
    <nav class="navtable">
      <!-- navigation bar -->
      <ul class="navigation">
        <li><a href="./html/Home.html">Home</a></li>
        <li><a href="./html/Product.html">Products</a></li>
        <li><a href="./html/Blog.html">Blog</a></li>
        <li><a href="./html/Research.html">Research</a></li>
        <li><a href="./html/Contact.html">Contact Us</a></li>
      </ul>

      <ul class="navigationsmall">
        <li>
          <a href="#"><ion-icon name="home-outline"></ion-icon></a>
        </li>
        <li>
          <a href="./html/Product.html"
            ><ion-icon name="bag-handle-outline"></ion-icon
          ></a>
        </li>
        <li>
          <a href="./html/Blog.html"
            ><ion-icon name="bag-handle-outline"></ion-icon
          ></a>
        </li>
        <li>
          <a href="./html/Research.html"
            ><ion-icon name="bag-handle-outline"></ion-icon
          ></a>
        </li>
        <li>
          <a href="./html/Contact.html"
            ><ion-icon name="bag-handle-outline"></ion-icon
          ></a>
        </li>
      </ul>
    </nav>
    <section class="formboxcontainer">
      <!--heading-->
      <div class="formsection">
        <h1 style="color: lightblue; font-size: 25px; font-weight: bold">
          Add a Product
        </h1>
        <!--start of the form -->
        <form
          name="formcontainer"
          id="registration-form"
          action="${pageContext.request.contextPath}/ProductRegister" method="post" enctype="multipart/form-data">
          <!--start of the first division of form where firstname, lastname, email, phone number and gender are present-->
          <div class="container">
            <div class="details">
              <span> Product Name: </span>
              <input
                type="text"
                name="productName"
                placeholder="Enter your Product Name"
                id="fname"
                required
              />
            </div>
            <div class="details">
              <span> Product Category: </span>
              <input
                type="text"
                name="productCategory"
                placeholder="Enter your Product Category"
                id="lname"
                required
              />
            </div>
            <div class="details">
              <span>Product Brand: </span>
              <input
                type="text"
                name="productBrand"
                placeholder="Enter a Product Brand"
                id="uname"
                required
              />
            </div>
            <div class="details">
              <span>Product Price: </span>
              <input
                type="text"
                name="productPrice"
                placeholder="Enter your Product Price"
                id="email"
                required
              />
            </div>

            <div class="details">
              <span>Product Stock: </span>
              <input
                type="text"
                name="productStock"
                placeholder="Enter your Product Stock"
                id="phone"
                required
              />
            </div>
            <div class="details">
              <span>Product Search Tags: </span>
              <input
                type="text"
                name="productSearchTag"
                placeholder="Enter a Product Search Tags"
                id="password"
                required
              />
            </div>
	
            <div class="profilePicture">
              <span> Choose a profile to upload: </span>
			<input type="file" name="picture" required />
              
            </div>
            <br />
            <br />
          <div>
            <button>Add New Product</button>
          </div>
          </div>
        </form>
      </div>
    </section>
    <!--start of footer section where all the columns and row are made using table tag-->
	<footer style = "background-color: #222426">
		<table style="width: 100%; table-layout:fixed; color: white;" >
			<tr align="center">
				<td colspan="4"  class="copyright">
					<br>
					<a href="https://www.instagram.com/" class="linkcolor">
						<img src="${pageContext.request.contextPath}/View/Pictures/Icons/instagram.png" width="2%">&nbsp;&nbsp;
					</a>
					<a href="https://www.facebook.com/" class="linkcolor">
						<img src="${pageContext.request.contextPath}/View/Pictures/Icons/facebook.png" width="2%">
					</a>
					<br>
					&copyEmpireClothing.
					<br>
					<br>
				</td>
			</tr>
		</table>
	</footer>
<!--end of footer section-->
    
  </body>
  <script
    type="module"
    src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
  ></script>
  <script
    nomodule
    src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
  ></script>
</html>
