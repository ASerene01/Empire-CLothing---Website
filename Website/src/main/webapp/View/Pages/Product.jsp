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
		
		<div class="cartcontainer">
			<a href="../products/cart.html" class="cartlink">
				<ion-icon name="cart-outline"></ion-icon>
				<label>Cart </label>
				<span class="cartnumber">0</span>
			</a>	
		</div>
		</div>
							
		<div class="search-container">
			<input type="search" placeholder="Search" class="search-input">
			<button class="search-button"><ion-icon name="search-circle-outline"></ion-icon></button>
		</div>
		 <nav class="navtable">
      <!-- navigation bar -->
      <ul class="navigation">
        <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/Product.jsp">Products</a></li>
        <li><a href="<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/View/Pages/CreateAccount.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/View/Pages/Login.jsp<%
		   					}%>"><%if(mySession.checkUser(user)){%>
				    		View Profile
				   		<%}else{%>
				    		Register
				   		<%}%></a></li>
        <li><a href="./html/Blog.html">Blog</a></li>
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
    <li><a href="#headphonesection" class="productlinkcolor">Headphone</a></li>
    <li><a href="#speakersection" class="productlinkcolor">Speaker</a></li>
    <li><a href="#microphonesection" class="productlinkcolor">Microphone</a></li>
    <li><a href="#cablesection" class="productlinkcolor">Cable</a></li>
    <li><a href="#watchsection" class="productlinkcolor">Watch</a></li>
  </ul>
</div>
	<!--end of sidenav division-->

	<!--start of division where all products are displayed-->
		<div class="flexcolumn2">
		<!--start of  division where the contents of headphone section are present-->
			<div id="headphonesection" class="productsubbgcolor">
			<!--heading of the category in this division-->
				<text class="categoryheading">Headphone</text>
				<br>
			<!--start of division where there are all containers of products which consists
			their picture names and prices-->
				<div class="productflex">
					<div class="products">
						<div class="imagecartcontainer">
							<img src="headphone\remax\remaxblack.jpg" class="productimage">
							<a href="#" class="cart c1p1">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://iremaxnepal.com.np/product/remax-wirelessgaming-headphone-rb-750hb/" class="productlinkcolor">
							<b class = "productname">REMAX WirelessGaming Headphone RB-750HB</b><br></a>
							<text class = "productpricecolor">Price: Rs. 2395 </text><br>
							<text class="productStock">Stock: 10</text>
						</div>
					</div>

					<div class="products">
						<div class="imagecartcontainer">
							<img src="headphone\fantechsolar\fantech1.jpg" class="productimage">
							<a href="#" class="cart c1p2">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://fantechnepal.com/product/fantech-headset-gaming-hg12-solar/" class="productlinkcolor"><b>FANTECH HG12 SOLAR Gaming Headset </b></a><br>
							<text class = "productpricecolor">Price: Rs. 2699 </text>
						</div>
					</div>

					<div class="products">
						<div class="imagecartcontainer">
							<img src="headphone\airpodsmax\airpodgrey.jpg" class="productimage">
							<a href="#" class="cart c1p3">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.apple.com/shop/buy-airpods/airpods-max/space-gray?fnode=493d62f2db49b950db00957e6dd08dd0b9589848808a4c6c638819b464ded8311bdda08f0e07ec8776455d95863846f5053012ed0e9fef6fb863e203412dfa08360ffa86380cce35c4017f6ad1021a0fb540828aae99453b27036ec4e5e9ad819a53f0b1e2820f414650d814f813fa335887601bd964941e32e48e7e0ec0e47c" class="productlinkcolor"><b>Airpods Max</b></a><br>
							<text class = "productpricecolor">Price: Rs. 85000 </text>
						</div>
					</div>

				</div>
			<!--end of the product container division-->
				<br>
			</div>
			

		<!--end of a headphone category division-->

		<!--start of  division where the contents of speaker section are present-->
			<div id="speakersection" class="productsubbgcolor">
			<!--heading of the category in this division-->
				<text class="categoryheading">Speaker</text>
				<br>
			<!--start of division where there are all containers of products which consists
			their picture names and prices-->
				<div class="productflex">
					<div class="products">
						<div class="imagecartcontainer">	
							<img src="speaker\jbl\jblpink.jpg" class="productimage">
							<a href="#" class="cart c2p1">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.bestbuy.com/site/jbl-flip-5-portable-bluetooth-speaker-white-steel/6356536.p?skuId=6356536" class="productlinkcolor"><b>JBL - Flip 5 Portable Bluetooth Speaker</b></a><br>
							<text class = "productpricecolor">Price: Rs. 14800 </text>
						</div>
					</div>
			
					<div class="products">
						<div class="imagecartcontainer">
							<img src="speaker\sony\sony1.jpg" class="productimage">
							<a href="#" class="cart c2p2">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.bhphotovideo.com/c/product/1234284-REG/sony_srshg1_blk_h_ear_go_wireless_speaker.html" class="productlinkcolor"><b>SONY Srshg1/Blk Hi-Res Wireless Speaker- Charcoal Black</b></a><br>
							<text class = "productpricecolor">Price: Rs. 26000 </text>
						</div>
					</div>

					<div class="products">
						<div class="imagecartcontainer">
							<img src="speaker\remax\remax1.jpg" class="productimage">
							<a href="#" class="cart c2p3">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://iremaxnepal.com.np/product/warriors-series-outdoor-bluetooth-speaker-rb-m56/" class="productlinkcolor"><b>Portable Waterproof Bluetooth Speaker RB-M56</b></a><br>
							<text class = "productpricecolor">Price: Rs. 4200 </text>
						</div>
					</div>
					
				</div>
			<!--end of the product container division-->
				<br>
			</div>
		<!--end of a speaker category division-->

		<!--start of  division where the contents of microphone section are present-->
			<div id="microphonesection" class="productsubbgcolor">
			<!--heading of the category in this division-->
				<text class="categoryheading">Microphone</text>
				<br>
			<!--start of division where there are all containers of products which consists
			their picture names and prices-->
				<div class="productflex">
					<div class="products">
						<div class="imagecartcontainer">
							<img src="microphone\thronmax\thronmax1.jpg" class="productimage">
							<a href="#" class="cart c3p1">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://neostore.com.np/product/thronmax-mdrill-dome-plus-usb-microphone" class="productlinkcolor"><b>THRONMAX MDrill Dome Plus USB Microphone</b></a><br>
							<text class = "productpricecolor">Price: Rs. 14800 </text>
						</div>
					</div>


					<div class="products">
						<div class="imagecartcontainer">
							<img src="microphone\boya\boya1.jpg" class="productimage">
							<a href="#" class="cart c3p2">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.olizstore.com/video-photography/microphones/boya-bm2021-cardioid-shotgun-video-microphone.html" class="productlinkcolor"><b>BOYA BM2021 Cardioid shotgun video microphone</b></a><br>
							<text class = "productpricecolor">Price: Rs. 5600 </text>
						</div>
					</div>
					
					<div class="products">
						<div class="imagecartcontainer">
							<img src="microphone\fantech\fantech1.jpg" class="productimage">
							<a href="#" class="cart c3p3">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://fantechnepal.com/product/fantech-mcx01-leviosa-professional-condenser-microphone/" class="productlinkcolor"><b>Fantech MCX01 Leviosa Professional Condenser Microphone</b></a><br>
							<text class = "productpricecolor">Price: Rs. 5999</text>
						</div>
					</div>

				</div>
			<!--end of the product container division-->
				<br>
			</div>
		<!--end of a microphone category division-->
		
		<!--start of  division where the cable of speaker section are present-->
			<div id="cablesection" class="productsubbgcolor">
			<!--heading of the category in this division-->
				<text class="categoryheading">Cable</text>
				<br>
			<!--start of division where there are all containers of products which consists
			their picture names and prices-->
				<div class="productflex">
					<div class="products">
						<div class="imagecartcontainer">
							<img src="cable\anker\anker1.jpg" class="productimage">
							<a href="#" class="cart c4p1">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://bestdealsnepal.com.np/product/anker-powerline-select-3ft/" class="productlinkcolor"><b>ANKER POWERLINE SELECT+ 3FT</b></a><br>
							<text class = "productpricecolor">Price: Rs. 1899 </text>
						</div>
					</div>


					<div class="products">
						<div class="imagecartcontainer">
							<img src="cable\remax\remax.jpg" class="productimage">
							<a href="#" class="cart c4p2">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://iremaxnepal.com.np/product/remax-3-in-1-magnetic-charging-cable-rc-169/" class="productlinkcolor"><b>Remax 3 in 1 Magnetic Charging Cable RC-169</b></a><br>
							<text class = "productpricecolor">Price: Rs. 680 </text>
						</div>
					</div>
					
					<div class="products">
						<div class="imagecartcontainer">
							<img src="cable\unitek\hdmi1.jpg" class="productimage">
							<a href="#" class="cart c4p3">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.dealayo.com/unitek-hdmi-2-0-4k-60hz-cable.html" class="productlinkcolor"><b>Unitek HDMI 2.0 4K 60Hz Cable 1.5M</b></a><br>
							<text class = "productpricecolor">Price: Rs. 600</text>
						</div>
					</div>
					
				</div>
			<!--end of the product container division-->
				<br>
			</div>
		<!--end of a cable category division-->
		
		<!--start of  division where the contents of watch section are present-->
			<div id="watchsection" class="productsubbgcolor">
			<!--heading of the category in this division-->
				<text class = "categoryheading">Watch</text>
				<br>
			<!--start of division where there are all containers of products which consists
			their picture names and prices-->
				<div class="productflex">
					<div class="products">
						<div class="imagecartcontainer">
							<img src="watch\samsung\galaxy1.jpg" class="productimage">
							<a href="#" class="cart c5p1">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://thulo.com/samsung-galaxy-watch-46mm-silver-bluetooth-s-r3800n-gear-s4.html" class="productlinkcolor"><b>Samsung Galaxy Watch  Silver(Gear S4)</b></a><br>
							<text class = "productpricecolor">Price: Rs. 40990 </text>
						</div>
					</div>


					<div class="products">
						<div class="imagecartcontainer">
							<img src="watch\miband\band6.jpg" class="productimage">
							<a href="#" class="cart c5p2">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://bestdealsnepal.com.np/product/xiaomi-mi-band-6/" class="productlinkcolor"><b>XIAOMI MI BAND 6</b></a><br>
							<text class = "productpricecolor">Price: Rs. 5499 </text>
						</div>
					</div>
					
					<div class="products">
						<div class="imagecartcontainer">
							<img src="watch\amazfit\amazfit1.jpg" class="productimage">
							<a href="#" class="cart c5p3`">Add to Cart</a>
						</div>
						<div class="producttext">
							<a href="https://www.olizstore.com/electronics/olizstore-watch/amazfit-t-rex-pro-gps-smartwatch-meteorite-black.html" class="productlinkcolor"><b>Amazfit T-Rex Pro GPS Smartwatch Meteorite Black</b></a><br>
							<text class = "productpricecolor">Price: Rs. 23500</text>
						</div>
					</div>
					
				</div>
			<!--end of the product container division-->
				<br>
			</div>
		<!--end of a watch category division-->

		</div>
<!--end of the second division of the middle section-->
	</section>
<!--end of middle section-->

<!--start of footer section where all the columns and row are made using table tag-->
	<footer style = "background-color: #222426">
		<table style="width: 100%; table-layout:fixed; color: white;" >
			<br>
			<br>
			<tr align="left">
				<th rowspan="2">
					<a href="../Home/home.html">
						<img src="../logo.png" width="40%">
					</a>
				</th>
				<th class="footerheadingcolor">
					PAGES
				</th>
				<th>
					<a href="../Products/productpage.html" class="footerheadingcolor">
						PRODUCTS
					</a>
				</th>
				<th>
					<a href="../Contact/contactpage.html" class="footerheadingcolor">
					CUSTOMER CARE
				</th>
			</tr>
			<tr>
				<td>
					<a href="#" class="linkcolor">
						Home<br>
					</a>
					<a href="../Products/productpage.html" class="linkcolor">
						Products<br>
					</a>
					<a href="../Blog/blogpage.html" class="linkcolor">
						Blog<br>
					</a>
					<a href="../Research/researchpage.html" class="linkcolor">
						Research<br>
					</a>
					<a href="../Contact/contactpage.html" class="linkcolor">
						Contact Us<br>
					</a>
				</td>

				<td>
					<a href="../Products/productpage.html#headphonesection" class="linkcolor">
						Headphone
					</a><br>
					<a href="../Products/productpage.html#microphonesection" class="linkcolor">
						Microphone
					</a><br>
					<a href="../Products/productpage.html#speakersection" class="linkcolor">
						Speaker
					</a><br>
					<a href="../Products/productpage.html#cablesection" class="linkcolor">
						Cable
					</a><br>
					<a href="../Products/productpage.html#watchsection" class="linkcolor">
						Watch
				</td>

				<td>
					<a href="..Contact/contactpage.html" class="linkcolor">
					Contact Information<br>
					Feedback<br>
					</a>
					<br>
					<br>
					<br>
				</td>
			</tr>
			<tr align="center">
				<td colspan="4"  class="copyright">
					<br>
					<br>
					<hr>
					<br>
					<a href="https://www.instagram.com/" class="linkcolor">
						<img src="../instagram.png" width="2%">&nbsp;&nbsp;
					</a>
					<a href="https://www.facebook.com/" class="linkcolor">
						<img src="../facebook.png" width="2%">
					</a>
					<br>
					&copyEmpireELectronics.
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