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
	String query = "Select *from product";
	if(user != null){
		ResultSet userData = dbConn.selectWhereQuery(MyConstants.GET_ALL_INFO_BY_USERNAME, user);
		userId = userData.getString("userId");
		cartQuantity = dbConn.getCartQuantity(MyConstants.CART_NUMBER_UPDATE, userId);
	}
	
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
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inconsolata&display=swap" rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap" rel="stylesheet">
	<title>Empire - Online Shopping System</title>
	<style>
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			text-decoration: none;
		}
		.about_container{
			display: flex;
			
			height: 700px;
			flex-direction: column;
		}

		.about_pic{
			height: 400px;
			width: 100%;
		}

		.about_text{
			font-family: 'Inconsolata', monospace;
			position: absolute;
  			top: 50%;
  			left: 50%;
  			transform: translate(-50%, -50%);
			font-size: 48px;
			color: white;
			letter-spacing: 30px;
			text-shadow: 3px 3px #DA2657;
		}

		.about_pic img{
			width: 100%;
			height: 100%;
		}

		.about_desc{
			font-family: 'Poppins', sans-serif;
			color: white;
			/*border: 2px solid yellow;*/
			margin-top: 40px;
			margin-left: 150px;
			margin-right: 150px;
		}

		.h_container{
			display: flex;
			height: 100px;
			align-items: center;
		}

		.h_logo{
			width: 200px;
			height: 60px;
			margin-left: 133px;
		}

		.h_logo img{
			width: 100%;
			height: 100%;
		}

		.navtable ul{
			margin: 10px;
		}


	</style>
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
			<a href="${pageContext.request.contextPath}/View/Pages/Cart.jsp" class="cartlink">
				<ion-icon name="cart-outline"></ion-icon>
				<label>Cart </label>
				<span class="cartnumber"><%=cartQuantity%></span>
			</a>	
		</div>
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
	<!--End of header-->


<!--start of middle section where the main purpose of page is shown-->
	<div class="about_container">
		<div class="about_pic"> 
			<div class="about_text">ABOUT EMPIRE</div> 
			<img src="${pageContext.request.contextPath}/View/Pictures/about_photo.jpg" alt="">
		</div>
		<dir class="about_desc">
			Empire has been and will continue to be one of the best and renowned clothing store in the country. We have been providing and producing hand made and extremely well built clothes for everyone.
			Lorem ipsum dolor, sit amet consectetur adipisicing elit. Temporibus iusto, illo consectetur delectus tempora blanditiis atque! Assumenda nobis, corporis vero saepe rem pariatur ex perspiciatis repudiandae nulla, reiciendis iste. At nemo nihil laborum inventore dolorem, totam corrupti explicabo ipsa? Eos quam inventore magnam aspernatur vero facilis magni a provident eius?
		</dir>
	</div>

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
</html>