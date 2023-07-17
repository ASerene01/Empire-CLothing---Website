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
      <div class="searchsection">
        <a href="#" class="logocontainer" style="justify-content: center">
          <img src="../Pictures/logo.png" class="logo" alt="logo" width="220px" />
        </a>
      </div>
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
          action="${pageContext.request.contextPath}/UserRegisterFromAdmin" method="post" enctype="multipart/form-data">
           <% 
	String registerMessage = (String) request.getAttribute("registerMessage");
	%>
	<% if (registerMessage != null) { %>
		    <div class="error-message"><%=registerMessage%></div>
		<% } %>
          <!--start of the first division of form where firstname, lastname, email, phone number and gender are present-->
          <div class="container">
            <div class="details">
              <span> First Name: </span>
              <input
                type="text"
                name="firstName"
                placeholder="Enter your First Name"
                id="fname"
                required
              />
            </div>
            <div class="details">
              <span> Last Name: </span>
              <input
                type="text"
                name="lastName"
                placeholder="Enter your Last Name"
                id="lname"
                required
              />
            </div>
            <div class="details">
              <span>Username: </span>
              <input
                type="text"
                name="userName"
                placeholder="Enter a desired username"
                id="uname"
                required
              />
            </div>
            <div class="details">
              <span>Email: </span>
              <input
                type="text"
                name="email"
                placeholder="Enter your Email"
                id="email"
                required
              />
            </div>

            <div class="details">
              <span>Phone number: </span>
              <input
                type="text"
                name="phoneNumber"
                placeholder="Enter your phone number"
                id="phone"
                required
              />
            </div>
            <div class="details">
              <span>Password: </span>
              <input
                type="text"
                name="password"
                placeholder="Enter a password"
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
                checked
              />
              <text style="width: 30%">Customer</text
              ><input type="radio" name="userType" value="customer"/>
            </div>
            <div class="profilePicture">
              <span> Choose a profile to upload: </span>

              <input type="file" id="picture" name="picture" required />
            </div>
            <br />
            <br />
          <div>
            <button>Create Account</button>
          </div>
          </div>
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
