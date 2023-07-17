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
	 userId = request.getParameter("userId");
	if(user != null){
		cartQuantity = dbConn.getCartQuantity(MyConstants.CART_NUMBER_UPDATE, userId);
		/* cartTotal = dbConn.getCartTotal(MyConstants.CART_TOTAL,userId); */
	}
	String query = "SELECT * from product p, orderTable c where p.productId = c.productId AND userId = " + userId;
	String query2 = "SELECT c.userId,SUM(p.productPrice*c.orderQuantity) AS Total from product p, orderTable c where p.productId = c.productId AND userId = " + userId + " GROUP by userId";
	String query3 = "SELECT c.userId,SUM(c.orderQuantity) AS Total from product p, orderTable c where p.productId = c.productId AND userId = " + userId + " GROUP by userId";
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
					
				<img src="${pageContext.request.contextPath}/View/Pictures/Products/${product.productPicture}">
				<span> ${product.productName}</span>
			</div>
			<div class="price">
				Rs. ${product.productPrice}
			</div>
			<div class="quantity">
			
				
					&nbsp;&nbsp;<span>  ${product.orderQuantity}  </span>&nbsp;&nbsp;
					
				
			</div>
			<div class="totalprice">
			
				Rs. <c:out value="${product.productPrice * product.orderQuantity}" />
				
			</div>
			
		</c:forEach>
		<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	
		<div class="totalcontainer">
			<h4 class="totaltitle">Total</h4>
			<sql:query var="totalPrice" dataSource="${dbConnection}">
		<%=query3 %>
	</sql:query>
	<c:forEach var="quantity" items="${totalPrice.rows}">
      <h4 class="totalproducts">${quantity.Total}</h4> </c:forEach>
      <sql:query var="totalPrice" dataSource="${dbConnection}">
		<%=query2 %>
	</sql:query>
	<c:forEach var="price" items="${totalPrice.rows}">
     <h4 class="total">Rs. ${price.Total}</h4>
     </c:forEach>
		</div>
		
        </div>
    <!--end of division which consists the products and their information-->

	
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