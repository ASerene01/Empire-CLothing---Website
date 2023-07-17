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
	String userId = request.getParameter("userId");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String password = request.getParameter("password");
	String userType = request.getParameter("userType");
	String picture = request.getParameter("picture");	 
	
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
          Create an Account
        </h1>
        <!--start of the form -->
        <form
          name="formcontainer"
          id="registration-form"
          action="${pageContext.request.contextPath}/UserEditWithPicture" method="post" enctype="multipart/form-data">
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
            </div>
			<div class="userType">
              <span>Select user type: </span><br />
              <text style="width: 30%">Admin</text
              ><input
                type="radio"
                name="userType"
                value="admin"
                <%if(userType.equals("admin")){ %>
                checked
                <%} %>
              />
              <text style="width: 30%">Customer</text
              ><input type="radio" name="userType" value="customer" <%if(userType.equals("customer")){ %>
                checked
                <%} %>/>
            </div>
             <div class="profilePicture">
              <span> Choose a profile to upload: </span>

              <input type="file" id="picture" name="picture" required />
            </div>
            <br />
            <br />
          <div>
            <button>Update Account</button>
          </div>
          </div>
        </form>
      
    </section>
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
