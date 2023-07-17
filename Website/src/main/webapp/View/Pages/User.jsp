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
		<a href="${pageContext.request.contextPath}/View/Pages/AddNewUser.jsp">Add New User</a>
	
	</div>
	
<!--start of navigation from where all the main pages can be accessed-->
			<% 
	String registerMessage = (String) request.getAttribute("registerMessage");
	%>
	<% if (registerMessage != null) { %>
		    <div class="added-message"><%=registerMessage%></div>
		<% } %>
		<% 
		String deleteMessage = (String) request.getAttribute("deleteMessage");
	%>
	<% if (deleteMessage != null) { %>
		    <div class="added-message"><%=deleteMessage%></div>
		<% } %>
		</header>

<!--start of middle section where the main purpose of page is shown-->
	<section class="flexcontainer">
	<!--end of sidenav division-->
<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/theempireclothing" user="root" password=""/>
	
	<sql:query var="allUsers" dataSource="${dbConnection}">
		SELECT * FROM user;
	</sql:query>
	
<div class="flexcolumn2">
 	    <div class="productflex">
 	    <c:forEach var="user" items="${allUsers.rows}">
            <div class="products">
            	<div class="imagecartcontainer">
                	<img src="${pageContext.request.contextPath}/View/Pictures/Profile/${user.picture}" class="productimage" alt="...">
                	<form method="post" class= "editButtonForm" action = "${pageContext.request.contextPath}/View/Pages/EditUser.jsp">
                		<input type="hidden" name="userId" value="${user.userId}"/>
                		<input type="hidden" name="firstName" value="${user.firstName}"/>
                        <input type="hidden" name="lastName" value="${user.lastName}" />
                        <input type="hidden" name="username" value="${user.username}" />
                        <input type="hidden" name="email" value="${user.email}" />
                        <input type="hidden" name="phoneNumber" value="${user.phoneNumber}" />
                        <input type="hidden" name="password" value="${user.password}" />
                        <input type="hidden" name="picture" value="${user.picture}" />
                        <input type="hidden" name="userType" value="${user.userType}" />
                        <button type="submit" class= "editButton">Update</button>
               	</form>
					<form method="post" class= "deleteButtonForm" action = "${pageContext.request.contextPath}/UserDelete">
                        <input type="hidden" name="username" value="${user.username}" />
                        <button type="submit" class= "deleteButton">Delete</button>
               	</form>
               	
               	</form>
					<form method="post" class= "viewOrderButtonForm" action = "${pageContext.request.contextPath}/View/Pages/OrdersAdmin.jsp">
                        <input type="hidden" name="username" value="${user.username}" />
                        <input type="hidden" name="userId" value="${user.userId}"/>
                        <button type="submit" class= "viewOrderButton">View</button>
               	</form>
                </div>
                <div class="producttext">
                    	<a href="https://iremaxnepal.com.np/product/remax-wirelessgaming-headphone-rb-750hb/" class="productlinkcolor">
							<b class = "productname">${user.firstName} ${user.lastName}</b><br></a>
							<text class = "productpricecolor">${user.userType}</text><br>
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
</html>