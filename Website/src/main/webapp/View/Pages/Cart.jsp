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
	String query = "SELECT * from product p, cart c where p.productId = c.productId AND userId = " + userId;
	String query2 = "SELECT c.userId,SUM(p.productPrice*c.cartQuantity) AS Total from product p, cart c where p.productId = c.productId AND userId = " + userId + " GROUP by userId";
	
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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/StyleSheet/cart.css">
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
		
	
		</div>
							
		
		
	
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
		
		<div class="cartbox">
    <!--start of the header division where the headers consists-->
        <div class="cartheader">
            <h5 class="title">PRODUCT</h5>
            <h5 class="price">PRICE</h5>
            <h5 class="quantity">QUANTITY</h5>
            <h5 class="totalprice">TOTAL</h5>
        </div>
    <!--end of the headerdivision-->

    <!--start of the division where all the 
    products in the cart and their information are 
    displayed-->
    
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="allProducts" dataSource="${dbConnection}">
		<%=query %>
	</sql:query>
	
        <div class="cartproducts">
        <c:forEach var="product" items="${allProducts.rows}">
           <div class="cartproduct">
					<form method="post" class= "deleteButtonCart" action = "${pageContext.request.contextPath}/DeleteProductCart">
					<input type="hidden" name="cartId" value="${product.cartId}"/>
						<button>
							X
						</button>
					</form>
				<img src="${pageContext.request.contextPath}/View/Pictures/Products/${product.productPicture}">
				<span> ${product.productName}</span>
			</div>
			<div class="price">
				Rs. ${product.productPrice}
			</div>
			<div class="quantity">
			<form  method="post" class= "subtractButtonCart" action = "${pageContext.request.contextPath}/SubtractCartProduct">
					<input type="hidden" name="userId" value="${product.userId}"/>
					<input type="hidden" name="productId" value="${product.productId}"/>
					<input type="hidden" name="cartId" value="${product.cartId}"/>
						<button>
							-
							
						</button>
					</form>
				
					&nbsp;&nbsp;<span>  ${product.cartQuantity}  </span>&nbsp;&nbsp;
					<form  method="post" class= "addButtonCart" action = "${pageContext.request.contextPath}/AddCartProduct">
					<input type="hidden" name="userId" value="${product.userId}"/>
					<input type="hidden" name="productId" value="${product.productId}"/>
					<input type="hidden" name="cartId" value="${product.cartId}"/>
						<button>
							+
							
						</button>
					</form>
				
			</div>
			<div class="totalprice">
			
				Rs. <c:out value="${product.productPrice * product.cartQuantity}" />
				
			</div>
			
		</c:forEach>
		<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="totalPrice" dataSource="${dbConnection}">
		<%=query2 %>
	</sql:query>
	<c:forEach var="price" items="${totalPrice.rows}">
		<div class="totalcontainer">
			<h4 class="totaltitle">Total</h4>
      <h4 class="totalproducts"><%=cartQuantity %></h4>
     <h4 class="total">Rs. ${price.Total}</h4>
		</div>
		</c:forEach>
        </div>
    <!--end of division which consists the products and their information-->

	
	
    <form  method="post" class= "orderButtonCart" action = "${pageContext.request.contextPath}/OrderProducts">
						<input type="hidden" name="userId" value="<%=userId%>"/>
						<button>
							Order Products
						</button>
					</form>
	
    </div>
    <!--end of middle-->



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
</html>