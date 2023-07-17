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
	<title>Empire - Online Shopping System</title>
	<style>
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			text-decoration: none;
		}

        .main_contact{
            display: flex;
            justify-content: center;
            margin: 10px;
            
        }

		.navtable ul{
			margin: 10px;
		}

        .contact_picContainer{
            display: flex;
            
            
        }

        .contact_pic{
            width: 400px;
        }

        .contact_pic img{
            width: 100%;
            height: 100%;
        }

        .contact_form{
            display: flex;
            flex-direction: column;
            padding: 50px;
            height: 600px;
            justify-content: center;
        }

        span{
            color: white;
            font-family: 'Poppins', sans-serif;
        }

        .input-wrapper input {
            background-color: #eee;
            border: none;
            padding: 10px;
            font-size: 13px;
            width: 450px;
            border-radius: 1rem;
            color: rgb(0, 0, 0);
            box-shadow: 0 0.4rem #ffffff;
            cursor: pointer;
          }
          
        .input-wrapper input:focus {
            outline-color: #DA2657;
        }

        button {
			padding: 1.3em 3em;
			font-size: 12px;
			text-transform: uppercase;
			letter-spacing: 2.5px;
			font-weight: 500;
			color: #000;
			background-color: #fff;
			border: none;
			border-radius: 45px;
			box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
			transition: all 0.3s ease 0s;
			cursor: pointer;
			outline: none;
			width: 450px;
		}
		  
		button:hover {
			background-color: #DA2657;
			box-shadow: 0px 15px 20px #cd4f71;
			color: #fff;
			transform: translateY(-7px);
		}
		  
		  button:active {
			transform: translateY(-1px);
    	}

		.but /*used for styling the button*/
		{
			background-color: #DA2657;
			border-radius: 20px;
			margin-top: 10px;
			margin-bottom: 10px;
		}

        
		button:hover /*changing color of the button when hovering your mouse over it*/
		{
			background-color: #a52044;
			transition: 0.3s;
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

<!--start of middle section where the main purpose of page is shown-->
    <div class="main_contact">
        <div class="contact_picContainer">
            <div class="contact_pic">
                <img src="${pageContext.request.contextPath}/View/Pictures/contact pict.jpeg">
            </div>
        </div>
        <form action="">
            <div class="contact_form">
                <span style="font-size: 25px;">GET IN TOUCH</span><br>
                <span>Full name</span><br>
                <div class="input-wrapper">
                    <input type="text" placeholder="Enter your full name" name="text" class="input">
                </div><br>
                <span>Email</span><br>
                <div class="input-wrapper">
                    <input type="text" placeholder="Enter your email" name="text" class="input">
                </div><br>
                <span>Phone number</span><br>
                <div class="input-wrapper">
                    <input type="text" placeholder="Enter your phone number" name="text" class="input">
                </div><br>
                <span>Enter your message</span><br>
                <div class="input-wrapper">
                    <input type="text" placeholder="Message" name="text" class="input" style="padding-bottom:70px">
                </div><br><br>
                <button>
					Submit
					
				</button>
            </div>
        </form>
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