<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String cPath = request.getContextPath();
%>
<html>
<head>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
</head>
<body>

<!-- Sidebar (hidden by default) -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" id="mySidebar">
	<div class="close_div">
		  <a class="close" href="javascript:void(0)" onclick="w3_close()"
		  class="w3-bar-item w3-button">X</a>
		</div>
	  <div class="login">
	  	<div class="inside">
		  	<div class="idpw_warp">
			  	<input title="아이디" class="id" placeholder="아이디" name="id" maxlength="22">
			  	<input title="비밀번호" type="password" id="pw" class="pw" placeholder="비밀번호" maxlength="23" name="pw">
			  	<div class="eyes">
			  		<i id="ps_hide" onclick="password_visable('true')" class="on"></i>
			  		<i id="ps_show" onclick="password_visable('false')" style="display:none" class="off"></i>
			  	</div>
			</div>
			
			<div class="checkbox">
				<input type="checkbox" id="save_id">
				<label id="string_save_id" for="save_id">아이디 저장</label>
			</div>
		</div>
	  </div>
   <button class="w3-bar-item w3-button" onclick="myAccFunc()">햄버거</button>
  <div id="demoAcc" class="w3-bar-block w3-hide w3-white w3-card-4">
    <a href="page/page2.jsp" class="w3-bar-item w3-button">세트</a>
    <a href="page/page3.jsp" class="w3-bar-item w3-button">디저트</a>
    <a href="page/page4.jsp" class="w3-bar-item w3-button">음료수</a>
  </div>

  <button class="w3-bar-item w3-button" onclick="myAccFunc1()">이벤트</button>
  <div id="demoAcc1" class="w3-bar-block w3-hide w3-white w3-card-4">
    <a href="page/page2.jsp" class="w3-bar-item w3-button">1</a>
    <a href="page/page3.jsp" class="w3-bar-item w3-button">2</a>
    <a href="page/page4.jsp" class="w3-bar-item w3-button">3</a>
  </div>
  
  <button class="w3-bar-item w3-button" onclick="myAccFunc2()">고객지원</button>
   <div id="demoAcc2" class="w3-bar-block w3-hide w3-white w3-card-4">
    <a href="page/page2.jsp" class="w3-bar-item w3-button">ㅂ</a>
    <a href="page/page3.jsp" class="w3-bar-item w3-button">ㅈ</a>
    <a href="page/page4.jsp" class="w3-bar-item w3-button">ㄷ</a>
  </div>
  
  
</nav>




<!-- Top menu -->
<div class="w3-top">
  <div class="w3-white w3-xlarge" style="max-width:1300px;margin:auto">
    <div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">☰</div>
    <div class="w3-right w3-padding-16">Mail</div>
    <div class="w3-center w3-padding-16">???가게 메뉴</div>
  </div>
</div>
  
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px">
		
  <!-- First Photo Grid-->
			
			<p style="text-align: center; font-size: 30;">햄버거</p>


   <div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
   	<div class="w3-quarter">
        <img src="<%=cPath %>/assets/images/hamburger0.jpg"  width="300" height="300" alt="hamburger0" style="width:100%">
      <h3>데리버거</h3>
	  <p>쇠고기패티에 달콤 짭짤한 데리소스를 더한 가성비 버거</p>
   </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger1.jpg" width="300" height="300"  alt="hamburger" style="width:100%">
      <h3>더블 데리버거</h3>
      <p>두 장의 패티가 이루는 조화로운 맛에 <br>든든함까지 추가된 더블버거 시리즈</p>
    </div>


    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger2.jpg" width="300" height="300"  alt="hamburger2" style="width:100%">
      <h3>불고기버거</h3>
      <p>두툼한 쇠고기패티와 한국적인 맛의 소스가 잘 조화된 ???매장의 대표 버거</p>

    </div>
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger3.jpg" width="300"  height="300" alt="hamburger3" style="width:100%">
      <h3>더블 불고기버거</h3>
	  <p>불고기 특유의 소스와 쇠고기의 진함을 배로 느끼는 제품</p>
  </div>
  </div>
  
  <!-- Second Photo Grid-->

  <div class="w3-row-padding w3-padding-16 w3-center">
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger4.jpg" width="300" height="300"  alt="hamburger4" style="width:100%">
      <h3>치킨버거</h3>
	  <p>닭고기패티와 데리야끼 소스로 만든 담백하고 달콤한 맛의 치킨버거</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger5.jpg" width="300" height="300"  alt="hamburger5" style="width:100%">
      <h3>더블 치킨버거</h3>
      <p>두 장의 패티가 이루는 조화로운 맛에 든든함까지 추가된 더블버거 시리즈</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger6.jpg" width="300" height="300"  alt="hamburger1" style="width:100%">
		<h3>치즈버거</h3>    
  		<p>부드러운 치즈와 호주산 쇠고기패티의 본연의 맛을 느낄수 있는 치즈버거</p>
    </div>
 
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/hamburger7.jpg"  width="300" height="300"  style="width:100%">
      <h3>더블 클래식치즈버거</h3>
      <p>두 장의 패티가 이루는 조화로운 맛에 든든함까지 추가된 더블 클래식치즈버거</p>
    </div>
  </div>

  <!-- Pagination -->
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="main.jsp" class="w3-bar-item w3-black w3-button">1</a>
      <a href="page/page2.jsp" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="page/page3.jsp" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="page/page4.jsp" class="w3-bar-item w3-button w3-hover-black">4</a>
    </div>
  </div>
  
  <hr id="about">
  
  <!-- Footer -->

    <div class="w3-third w3-serif">
      <h3>인기 태그</h3>
      <p>
        <span class="w3-tag w3-black w3-margin-bottom">???가게 전주점</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">햄버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">수제 버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">감자튀김</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">치킨버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">데리버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">불고기버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">치즈버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">전주 맛집</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">키오스크</span>
      </p>
    </div>

<!-- End page content -->
</div>


<script>
// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}

function myAccFunc() {
	  var x = document.getElementById("demoAcc");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

function myAccFunc1() {
	  var x = document.getElementById("demoAcc1");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

function myAccFunc2() {
	  var x = document.getElementById("demoAcc2");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	    x.previousElementSibling.className += " w3-green";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	    x.previousElementSibling.className = 
	    x.previousElementSibling.className.replace(" w3-green", "");
	  }
	}

</script>

</body>
</html>
