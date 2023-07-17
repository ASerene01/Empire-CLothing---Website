<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="statemanagement.SessionManage"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="model.PasswordEncryptionWithAes"%>
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
	
	
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String enryptedpassword = request.getParameter("password");
	String userType = request.getParameter("userType");
	String picture = request.getParameter("picture");	 
	String password = PasswordEncryptionWithAes.decrypt(enryptedpassword, username);
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
    <section class="formboxcontainer">
      <!--heading-->
      <div class="formsection">
        <h1 style="color: lightblue; font-size: 25px; font-weight: bold">
          Create an Account
        </h1>
        <!--start of the form -->
        <form
          name="formcontainer"
          id="registration-form"
          action="${pageContext.request.contextPath}/ProfileUpdateAdmin" method="post" enctype="multipart/form-data">
           <% 
	String registerMessage = (String) request.getAttribute("registerMessage");
	%>
	<% if (registerMessage != null) { %>
		    <div class="error-message"><%=registerMessage%></div>
		<% } %>
          <!--start of the first division of form where firstname, lastname, email, phone number and gender are present-->
          <div class="container">
          <input type="hidden" name="userId" value="<%=userId%>"/>
            <div class="details">
              <span> First Name: </span>
              <input
                type="text"
                name="firstName"
                value = "<%=firstName%>"
                id="fname"
                required
              />
            </div>
            <div class="details">
              <span> Last Name: </span>
              <input
                type="text"
                name="lastName"
                value = "<%=lastName%>"
                id="lname"
                required
              />
            </div>
            <div class="details">
              <span>Username: </span>
              <input
                type="text"
                name="userName"
                value = "<%=username%>"
                id="uname"
                required
              />
            </div>
            <div class="details">
              <span>Email: </span>
              <input
                type="text"
                name="email"
                value = "<%=email%>"
                id="email"
                required
              />
            </div>

            <div class="details">
              <span>Phone number: </span>
              <input
                type="text"
                name="phoneNumber"
                value = "<%=phoneNumber%>"
                id="phone"
                required
              />
            </div>
            <div class="details">
              <span>Password: </span>
              <input
                type="text"
                name="password"
                value = "<%=password%>"
                id="password"
                required
              />
              <input type="hidden" name="userType" value="<%=userType%>" />
            </div>
		
            <br>
            <br>
          <div>
            <button>Update Account</button>
          </div>
          </div>
        </form>
        <br>
        <br>
         <form method="post" action = "${pageContext.request.contextPath}/View/Pages/ProfileUpdateAdminPicture.jsp">
         				<input type="hidden" name="userId" value="<%=userId%>"/>
                        <input type="hidden" name="firstName" value="<%=firstName%>"/>
                        <input type="hidden" name="lastName" value="<%=lastName%>" />
                        <input type="hidden" name="username" value="<%=username%>" />
                        <input type="hidden" name="email" value="<%=email%>" />
                        <input type="hidden" name="phoneNumber" value="<%=phoneNumber%>" />
                        <input type="hidden" name="password" value="<%=password%>" />
                        <input type="hidden" name="userType" value="<%=userType%>" />
                        <input type="hidden" name="picture" value="<%=picture%>" />
                        <button type="submit">Change the existing Picture</button> 
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
