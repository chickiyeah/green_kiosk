<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mMgr" class="menu.Manager_Menu"  />
<link href="style3.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet">
<script src='https://unpkg.com/micromodal/dist/micromodal.min.js'></script>

<html>

<head>

	 
	 
	 
</head>
<body>
<div class="container">

	 <div class="head color1" align="center">	<h1>KIOSK</h1> <br>
	 </div>
	 <div class="main color2" align="center">	
	 	<div class="page w3-button"onclick="jumoon0()" ><h2>단 품</h2></div>
	 	<div class="page w3-button"onclick="jumoon1()" ><h2>세 트</h2></div>
	 	<div class="page w3-button"onclick="jumoon2()" ><h2>음 료 수</h2></div>
	 	<div class="page w3-button"onclick="jumoon3()" ><h2>사 이 드</h2></div>
	 </div>

	<div class="item1" onclick="hrefTo('item1')">
		<div class="rowbox">
 			<img src="../images/hamburger0.jpg">
 				<div class="colbox">
 				  <span id="hamburger0" style="font-size:36px; margin :10px" >데리버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				 </div>
		</div>
	</div>
	
	<div class="item2" onclick="hrefTo('item2')">
		<div class="rowbox">
 			<img src="../images/hamburger1.jpg" >
 				<div class="colbox">
 				  <span id="hamburger1" style="font-size:36px; margin :10px" >더블 데리버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item3 " onclick="hrefTo('item3')">
		<div class="rowbox">
 			<img src="../images/hamburger2.jpg" >
 				<div class="colbox">
 			 	  <span id="hamburger2" style="font-size:36px; margin :10px" >불고기버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
				</div>
		</div>
	</div>
	
	<div class="item4" onclick="hrefTo('item4')">
		<div class="rowbox">
 			<img src="../images/hamburger3.jpg" >
 				<div class="colbox">
 				  <span id="hamburger3" style="font-size:36px; margin :10px" >더블 불고기버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>
 				</div>
		</div>
	</div>
	
	<div class="item5" onclick="hrefTo('item5')">
		<div class="rowbox">
 			<img src="../images/hamburger4.jpg" >
 				<div class="colbox">
 				  <span id="hamburger4" style="font-size:36px; margin :10px" >치킨버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>
	
	<div class="item6" onclick="hrefTo('item6')">
		<div class="rowbox">
 			<img src="../images/hamburger5.jpg" >
 				<div class="colbox">
 				  <span id="hamburger5" style="font-size:36px; margin :10px" >더블 치킨버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>
	</div>
	
	<div class="item7" onclick="hrefTo('item7')">
		<div class="rowbox">
 			<img src="../images/hamburger6.jpg" >
 				<div class="colbox">
 				  <span id="hamburger6" style="font-size:36px; margin :10px" >치즈버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>
	
	<div class="item8" onclick="hrefTo('item8')">
		<div class="rowbox">
 			<img src="../images/hamburger7.jpg" >
 				<div class="colbox">
 				  <span id="hamburger7" style="font-size:36px; margin :10px" >더블 클래식치즈버거</span>
 				  <span id="don" style="font-size:30px; margin :10px; color:blue;" >3500~</span>

 				</div>
		</div>	
	</div>

	
	
	
	<div class="order" id="totalOrder" >
			  	<div class="price" id ="totalPrice" >
				
				</div>

			  	<div class="Ordermenu" >
			  	<span class="Ordermenu" id="menu" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>
			   </div>

			  	<div class="count" >
			  	<span class="count" id="count" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>  
			    </div>
			  	
			  	<div class="price" >
			  	<span id="price" style="font-size:36px; font-weight: 600; color:black;margin :10px"></span>
				</div>
	
	</div>
	
	
	
		
	
	
	
	
	
</div>
		










<script>
function jumoon0() {
	location.href = "test1-1-4.jsp";
}		
function jumoon1() {
	location.href = "test2.jsp";
}		
function jumoon2() {
	location.href = "test3.jsp";
}		
function jumoon3() {
	location.href = "test4.jsp";
}		
	
	
</script>

</body>
</html>
