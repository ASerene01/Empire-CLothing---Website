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
%>
<!DOCTYPE html>
<html>
<head>
	<meta name="Description" content="shopping System">
	<meta name="keyword" content="E-commerce">
	<meta name="author" content="Amit Baniya">
	<meta http-equiv="refresh" content="">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/StyleSheet/page.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/StyleSheet/productcss.css">
	<title>Empire - Online Shopping System</title>
</head>
<body style = "background-color: #141617;">
<header class="header">
		<div class="headersection">		
		<a href = "#" class = "logocontainer" style="justify-content: right;">
			<img src="${pageContext.request.contextPath}/View/Pictures/logo.png" class="logo"   alt="logo">
		</a>
		
		<form  action="
		    				<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/LogoutServlet<%
		   					}%>
		    			"
		    	method="post" class = "loginButton">
			   		<a class="loginButton">
			
            <button class = "button">
            <%if(mySession.checkUser(user)){%>
				    		Logout
				   		<%}else{%>
				    		Login
				   		<%}%>
            
            </button>
			
		</a>
			   	
		    	</form>
		  <a href="../LoginPage/Login.html" class="logincontainer">
			<ion-icon name="person-circle-outline" class="icon"></ion-icon>
			
		</a>
		
		
		</div>
							
		<form method="post" class="search-container" action = "${pageContext.request.contextPath}/View/Pages/AdminSearch.jsp">
			<input type="search" placeholder="Search" class="search-input" name="searchInput">
			<button>
			Search
			</button>
			
			</form>
		 <nav class="navtable">
      <!-- navigation bar -->
      <ul class="navigation">
        <li><a href="${pageContext.request.contextPath}/View/Pages/homeAdmin.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/View/Pages/User.jsp">Users</a></li>
        <li><a href="<%if(mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/ViewProfileAdmin.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					}%>"><%if(mySession.checkUser(user)){%>
				    		View Profile
				   		<%}else{%>
				    		Register
				   		<%}%></a></li>
         <li><a href="${pageContext.request.contextPath}/View/Pages/AboutUsAdmin.jsp">About us</a></li>
        <li><a href="${pageContext.request.contextPath}/View/Pages/ContactUsAdmin.jsp">Contact Us</a></li>
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
	<div class="navigationforProduct">
		<a href="${pageContext.request.contextPath}/View/Pages/AddNewProduct.jsp">Add New Product</a>
	
	</div>
	
<!--start of navigation from where all the main pages can be accessed-->
			<% 
	String registerMessage = (String) request.getAttribute("registerMessage");
	%>
	<% if (registerMessage != null) { %>
		    <div class="added-message"><%=registerMessage%></div>
		<% } %>
		</header>

<!--start of middle section where the main purpose of page is shown-->
	<section class="flexcontainer">
	<!--start of sidenav division-->
	
		
	<!--end of sidenav division-->
<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="allProducts" dataSource="${dbConnection}">
		SELECT productId, productName, productBrand, productCategory, productPrice, productStock, productSearchTag, productPicture FROM product
	</sql:query>
	
<div class="flexcolumn2">
 	    <div class="productflex">
 	    <c:forEach var="product" items="${allProducts.rows}">
            <div class="products">
            	<div class="imagecartcontainer">
                	<img src="${pageContext.request.contextPath}/View/Pictures/Products/${product.productPicture}" class="productimage" alt="...">
                	<form method="post" class= "editButtonForm" action = "${pageContext.request.contextPath}/View/Pages/EditProduct.jsp">
                		<input type="hidden" name="productId" value="${product.productId}"/>
                        <input type="hidden" name="productName" value="${product.productName}" />
                        <input type="hidden" name="productCategory" value="${product.productCategory}" />
                        <input type="hidden" name="productBrand" value="${product.productBrand}" />
                        <input type="hidden" name="productPrice" value="${product.productPrice}" />
                        <input type="hidden" name="productStock" value="${product.productStock}" />
                        <input type="hidden" name="productPicture" value="${product.productPicture}" />
                        <input type="hidden" name="productSearchTag" value="${product.productSearchTag}" />
                        <button type="submit" class= "editButton">Update</button>
               	</form>
                	
					<form method="post" class= "deleteButtonForm" action = "${pageContext.request.contextPath}/ProductDelete">
                        <input type="hidden" name="productId" value="${product.productId}" />
                        <button type="submit" class= "deleteButton">Delete</button>
               	</form>
               	
               	
                </div>
                <div class="producttext">
                    	<a href="https://iremaxnepal.com.np/product/remax-wirelessgaming-headphone-rb-750hb/" class="productlinkcolor">
							<b class = "productname">${product.productName}</b><br></a>
							<text class = "productpricecolor">Price: Rs. ${product.productCategory} </text><br>
							<text class="productStock">Stock: ${product.productStock}</text>
                </div>
            </div>
      	</c:forEach>
        </div>
	</div>
	
	
	
<!--end of the second division of the middle section-->
	</section>
<!--end of middle section-->

<!--start of footer section where all the columns and row are made using table tag-->
	<footer style = "background-color: #222426">
		<table style="width: 100%; table-layout:fixed; color: white;" >
			<br>
			<br>
			<tr align="left">
				<th rowspan="2">
					<a href="../Home/home.html">
						<img src="../logo.png" width="40%">
					</a>
				</th>
				<th class="footerheadingcolor">
					PAGES
				</th>
				<th>
					<a href="../Products/productpage.html" class="footerheadingcolor">
						PRODUCTS
					</a>
				</th>
				<th>
					<a href="../Contact/contactpage.html" class="footerheadingcolor">
					CUSTOMER CARE
				</th>
			</tr>
			<tr>
				<td>
					<a href="#" class="linkcolor">
						Home<br>
					</a>
					<a href="../Products/productpage.html" class="linkcolor">
						Products<br>
					</a>
					<a href="../Blog/blogpage.html" class="linkcolor">
						Blog<br>
					</a>
					<a href="../Research/researchpage.html" class="linkcolor">
						Research<br>
					</a>
					<a href="../Contact/contactpage.html" class="linkcolor">
						Contact Us<br>
					</a>
				</td>

				<td>
					<a href="../Products/productpage.html#headphonesection" class="linkcolor">
						Headphone
					</a><br>
					<a href="../Products/productpage.html#microphonesection" class="linkcolor">
						Microphone
					</a><br>
					<a href="../Products/productpage.html#speakersection" class="linkcolor">
						Speaker
					</a><br>
					<a href="../Products/productpage.html#cablesection" class="linkcolor">
						Cable
					</a><br>
					<a href="../Products/productpage.html#watchsection" class="linkcolor">
						Watch
				</td>

				<td>
					<a href="..Contact/contactpage.html" class="linkcolor">
					Contact Information<br>
					Feedback<br>
					</a>
					<br>
					<br>
					<br>
				</td>
			</tr>
			<tr align="center">
				<td colspan="4"  class="copyright">
					<br>
					<br>
					<hr>
					<br>
					<a href="https://www.instagram.com/" class="linkcolor">
						<img src="../instagram.png" width="2%">&nbsp;&nbsp;
					</a>
					<a href="https://www.facebook.com/" class="linkcolor">
						<img src="../facebook.png" width="2%">
					</a>
					<br>
					&copyEmpireELectronics.
					<br>
					<br>
				</td>
			</tr>
		</table>
	</footer>
<!--end of footer section-->

<!--connects the external js to this website-->
<script src="../cart.js"></script>
<!--below two scripts is used to import the different logos for the website called ion-icon-->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
	</body>
</html>