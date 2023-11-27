<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="user.Member_Mgr" %>
<%@ page import="user.Member_Bean" %>
<%@ include file="/index/base/head_import.jsp"%>
<%
	String cPath = request.getContextPath();

	Object mem_id = session.getAttribute("mem_id");
	Member_Mgr u_mgr = new Member_Mgr();
	Member_Bean bean = null;
	String mem_ac = "user";
	if (mem_id != null) {
		bean = u_mgr.getMember(String.valueOf(mem_id));
		mem_ac = bean.getMem_ac();
	}
%>
<html>
<head>
<title>W3.CSS Templatee</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
</head>
<script>
//회원가입 창 여는 함수
function open_register() {
	let url = "<%=cPath %>/register/register.jsp"
	window.open(url, "회원가입", "width=460, height=600")
}
</script>
<body>
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>
  
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px">

<div class="w3-container w3-teal">
  <h1>디저트</h1>
</div>
  <!-- First Photo Grid-->
  <div class="w3-row-padding w3-padding-16 w3-center" id="food">

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/potato.jpg" width="300" height="300"  alt="potato" style="width:100%">
      <h3>포테이토</h3>
      <p>바로 튀겨낸 바삭바삭한 후렌치 포테이토</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/potato1.jpg" width="300" height="300"  alt="potato1" style="width:100%">
		<h3>양념감자</h3>    
		<p>시즈닝(오니언, 치즈, 칠리)을 한가지를 선택해 뿌려먹는 포테이토</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/potato.jpg" width="300" height="300"  alt="potato" style="width:100%">
      <h3>포테이토(L)</h3>
      <p>바로 튀겨낸 바삭바삭한 후렌치 포테이토</p>

    </div>
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/cheese.jpg" width="300"  height="300" alt="cheese" style="width:100%">
      <h3>치즈스틱</h3>
	  <p>통모짜렐라치즈에 튀김옷을 입혀 만든 바삭하고 고소한 ???가게 대표 디저트 메뉴</p>
  </div>
  </div>

  <div class="w3-row-padding w3-padding-16 w3-center">
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/cheese2.jpg" width="300"  height="300" alt="cheese2" style="width:100%">
      <h3>치즈볼</h3>
	  <p>달콤하고 고소한 치즈가 가득한 치즈볼</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/chicken.jpg" width="300" height="300"  alt="chicken" style="width:100%">
      <h3>치킨너겟</h3>
      <p>닭안심살과 닭가슴살로 만든 담백하고 촉촉한 치킨너겟</p>
    </div>

    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/ojingeo.jpg" width="300" height="300"  alt="ojingeo" style="width:100%">
      <h3>오징어링</h3>
      <p>오징어로 리얼한 식감과 풍미가 가득한 디저트</p>
    </div>
 
    <div class="w3-quarter">
      <img src="<%=cPath %>/assets/images/potato3.jpg" width="300" height="300"  alt="potato3" style="width:100%">
      <h3>웨지포테이토</h3>
      <p>국내산 감자를 이용한 고소하고 바삭한 웨지포테이토</p>
    </div>
  </div>

  <!-- Pagination -->
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="<%=cPath %>/index.jsp" class="w3-bar-item w3-black w3-button">1</a>
      <a href="<%=cPath %>/index/page/page2.jsp" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="<%=cPath %>/index/page/page3.jsp" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="<%=cPath %>/index/page/page4.jsp" class="w3-bar-item w3-button w3-hover-black">4</a>
    </div>
  </div>
  
  
  <hr id="about">
  

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
