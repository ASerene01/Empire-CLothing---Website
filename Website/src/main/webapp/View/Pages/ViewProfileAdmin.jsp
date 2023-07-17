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
	String cartQuantity = null;
	// Deleting item on database when delete button is clicked.
	if (request.getParameter("deleteId") != null) {
	    String id = request.getParameter("deleteId");
	    dbConn.deleteUser(MyConstants.DELETE_USER, id);
	}
	if(user != null){
		ResultSet userData = dbConn.selectWhereQuery(MyConstants.GET_ALL_INFO_BY_USERNAME, user);
		userId = userData.getString("userId");
		cartQuantity = dbConn.getCartQuantity(MyConstants.CART_NUMBER_UPDATE, userId);
	}
	String query = "Select *from user WHERE userId = " + userId;
	
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
	<style>
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			text-decoration: none;
			
		}

		.main_profile{
			display: flex;
			align-items: center;
			flex-direction: column;
			margin-top: 10px;
			
		}

		.profile_title{
			font-family: 'Inconsolata', monospace;
			color: #DA2657;
			font-size: 32px;
			letter-spacing: 10px;
			padding: 10px;
		}

		.profile_info{
			display: flex;
			flex-direction: column;
			align-items: center;
		}

		.profile_infoImg{
			display: flex;
			flex-direction: column;
			align-items: center;
			width: 120px;
			height: 120px;
			padding: 10px;
			margin-bottom: 2px;
			
		}

		.profile_infoImg img{
			border-radius: 50%;
			width: 100%;
			height: 100%;
		}

		.input-style {
			width: 260px;
			padding: 10px;
			border: 2px solid #ccc;
			border-radius: 5px;
			font-size: 14px;
			color: #555;
			outline: none;
			font-family: 'Poppins', sans-serif;
			margin-left: 70px;
		}
		  
		.input-style:focus {
			border-color: #DA2657;
			box-shadow: 0 0 0 0.2rem #ffffffca;
		}

		.user_text{
			color: white;
			font-family: 'Poppins', sans-serif;
			font-size: 14px;
		}

		.text{
			color: white;
			font-family: 'Poppins', sans-serif;
			font-size: 14px;
		}

		  .profile_user{
			margin-top: 15px;
			margin-bottom: 15px;
		}

		.update_button {
			font-size: 17px;
			padding: 0.5em 2em;
			border: transparent;
			box-shadow: 2px 2px 4px rgba(0,0,0,0.4);
			background: #DA2657;
			color: white;
			border-radius: 4px;
			width: 236px;
		}
		   
		.update_button:hover {
			background: #9e1a3e;
		}
		   
		.update_button:active {
			transform: translate(0em, 0.2em);
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


<!--start of navigation from where all the main pages can be accessed-->
		
		</header>
		<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="allUsers" dataSource="${dbConnection}">
		<%=query %>
	</sql:query>
	
 	    <c:forEach var="user" items="${allUsers.rows}">
          
            
                	<form method="post" class= "main_profile" action = "${pageContext.request.contextPath}/View/Pages/ProfileUpdateAdmin.jsp">
                	<div class="profile_title">
			<label>PROFILE INFORMATION</label>
		</div>
			<div class="profile_info">
			<div class="profile_infoImg">
				<img src="${pageContext.request.contextPath}/View/Pictures/Profile/${user.picture}" alt="">
				<span class="text">UserName: ${user.username}</span><br>
			</div>
			</div>
			<div class="profile_desc">
			<div class="profile_user">
				<span class="user_text">First name : ${user.firstName}</span> 
				</div>
			<div class="profile_user">
				<span class="user_text">Last name: ${user.lastName}</span> 
				</div>
			<div class="profile_user">
				<span class="user_text">Email: ${user.email} </span> 
				</div>
			<div class="profile_user">
				<span class="user_text">Phone no: ${user.phoneNumber}</span> 
				</div>
				</div>
				
                		<input type="hidden" name="userId" value="${user.userId}"/>
                		<input type="hidden" name="firstName" value="${user.firstName}"/>
                        <input type="hidden" name="lastName" value="${user.lastName}" />
                        <input type="hidden" name="username" value="${user.username}" />
                        <input type="hidden" name="email" value="${user.email}" />
                        <input type="hidden" name="phoneNumber" value="${user.phoneNumber}" />
                        <input type="hidden" name="password" value="${user.password}" />
                        <input type="hidden" name="picture" value="${user.picture}" />
                        <input type="hidden" name="userType" value="${user.userType}" />
                        <div style="margin-top: 30px; margin-bottom: 30px">
			<button class="update_button" type = "submit"><span class="text">Update profile</span></button>
		</div>
               	</form>
				
      	</c:forEach>
     

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