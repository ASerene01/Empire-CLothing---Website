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
	DbConnection dbConn = new DbConnection();
	String userId = null;
	String cartQuantity = "0";
	// Deleting item on database when delete button is clicked.
	if (request.getParameter("deleteId") != null) {
	    String id = request.getParameter("deleteId");
	    dbConn.deleteUser(MyConstants.DELETE_USER, id);
	}
	
	if(user != null){
		ResultSet userData = dbConn.selectWhereQuery(MyConstants.GET_ALL_INFO_BY_USERNAME, user);
		userId = userData.getString("userId");
		cartQuantity = dbConn.getCartQuantity(MyConstants.CART_NUMBER_UPDATE, userId);
		/* cartTotal = dbConn.getCartTotal(MyConstants.CART_TOTAL,userId); */
	}
	
	String query = "SELECT * FROM product ORDER BY productCategory, productname";
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
		<a href = "${pageContext.request.contextPath}/home.jsp" class = "logocontainer" style="justify-content: right;">
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
		  <a href="<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/ViewProfile.jsp<%
		   					}%>" class="logincontainer">
			<ion-icon name="person-circle-outline" class="icon"></ion-icon>
			
		</a>
		<div class="cartcontainer">
			<a href="<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/Cart.jsp<%
		   					}%>" class="cartlink">
				<ion-icon name="cart-outline"></ion-icon>
				<label>Cart </label>
				<span class="cartnumber"><%=cartQuantity%></span>
			</a>	
		</div>
		
		</div>
							
		
		<form method="post" class="search-container" action = "${pageContext.request.contextPath}/View/Pages/Search.jsp">
			<input type="search" placeholder="Search" class="search-input" name="searchInput">
			<button>
			Search
			</button>
			
			</form>
	
		 <nav class="navtable">
      <!-- navigation bar -->
      <ul class="navigation">
        <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
        <li><a href="<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/Orders.jsp<%
		   					}%>">Orders</a></li>
        <li><a href="<%if(mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/ViewProfile.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/CreateAccount.jsp<%
		   					}%>"><%if(!mySession.checkUser(user)){%>
				    			Register
				   		<%}else{%>
				    		View Profile
				   		<%}%></a></li>
        <li><a href="${pageContext.request.contextPath}/View/Pages/AboutUs.jsp">About us</a></li>
        <li><a href="${pageContext.request.contextPath}/View/Pages/ContactUs.jsp">Contact Us</a></li>
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



<!--start of navigation from where all the main pages can be accessed-->
		
		</header>

<!--start of middle section where the main purpose of page is shown-->
	<section class="flexcontainer">
	<!--start of sidenav division-->
	
		<div class="sidenav-container">
  <div class="sidenav-heading">
    <h3>Products</h3>
  </div>
  <ul class="sidenav-list">
        <li><a href="${pageContext.request.contextPath}/View/Pages/homeSortbyPrice.jsp" class="productlinkcolor">Sort by Price</a></li>
    <li><a href="${pageContext.request.contextPath}/View/Pages/homeGroupByCategory.jsp" class="productlinkcolor">Group By Category</a></li>
    <li><a href="${pageContext.request.contextPath}/View/Pages/homeSortbyRating.jsp" class="productlinkcolor">Sort By Rating</a></li>
  </ul>
</div>
	<!--end of sidenav division-->

	<!--start of division where all products are displayed-->
	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="allProducts" dataSource="${dbConnection}">
		<%=query %>
	</sql:query>
	
<div class="flexcolumn2">
 	    <div class="productflex">
 	    <c:forEach var="product" items="${allProducts.rows}">
            <div class="products">
            	<div class="imagecartcontainer">
                	<img src="${pageContext.request.contextPath}/View/Pictures/Products/${product.productPicture}" class="productimage" alt="...">
                	<form method="post" class= "cartForm" action = "${pageContext.request.contextPath}/View/Pages/EditProduct.jsp">
                		<input type="hidden" name="productId" value="${product.productId}"/>
                        <input type="hidden" name="productName" value="${product.productName}" />
                        <input type="hidden" name="productCategory" value="${product.productCategory}" />
                        <input type="hidden" name="productBrand" value="${product.productBrand}" />
                        <input type="hidden" name="productPrice" value="${product.productPrice}" />
                        <input type="hidden" name="productStock" value="${product.productStock}" />
                        <input type="hidden" name="productPicture" value="${product.productPicture}" />
                        <input type="hidden" name="productSearchTag" value="${product.productSearchTag}" />
                        <button type="submit" class= "cart">Add to Cart</button>
               	</form>
                	
                </div>
                <div class="producttext">
                    	<a href="https://iremaxnepal.com.np/product/remax-wirelessgaming-headphone-rb-750hb/" class="productlinkcolor">
							<b class = "productname">${product.productName}</b><br></a>
							<text class = "productpricecolor">Price: Rs. ${product.productPrice} </text><br>
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


<!--connects the external js to this website-->
<script src="../cart.js"></script>
<!--below two scripts is used to import the different logos for the website called ion-icon-->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
	</body>
</html>d