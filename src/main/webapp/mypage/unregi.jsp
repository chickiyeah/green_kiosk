<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="orders.Orders_Bean" %>
<%@ page import="orders.Orders_Mgr" %>
<%@ page import="user.Member_Mgr" %>
<%@ page import="user.Member_Bean" %>
<%@ page import="java.util.Vector" %>
<%@ include file="/index/base/head_import.jsp"%>
<script> let res = "false"; </script>
<%
	Orders_Mgr mgr = new Orders_Mgr();
	String cPath = request.getContextPath();

	Object mem_id = session.getAttribute("mem_id");
	Object failed_count = session.getAttribute("failed_count");
	Object pw_ok = session.getAttribute("pw_ok");
	
	Member_Mgr u_mgr = new Member_Mgr();
	Member_Bean bean = u_mgr.getMember(String.valueOf(mem_id));
	String mem_ac = "";
	if (bean == null) {
		%> <script> alert("로그인 상태가 아닙니다.");location.href="<%=cPath %>/"</script> <%
	} else {
		bean.getMem_ac();
	}
	
	
	Vector<Orders_Bean> orders = mgr.getOrdersByUser(String.valueOf(mem_id)); %>
<html>
<head>
<title>마이페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/mypage.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/register.css">
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

function edit() {
	let frm = document.querySelector(".joinform")
	let name = frm.mem_name.value
	let phone = frm.mem_phone.value
	let url = "<%=cPath %>/api/user/update?name="+name+"&phone="+phone
	
	fetch(url, {
		method: "post"
	}).then(response => {
		response.json().then((res) => {
			let result = res.result;
			
			if (result == "success") {
				alert("개인정보를 성공적으로 변경했습니다.");
				location.reload();
			} else {
				alert("개인정보 변경중 오류가 발생하였습니다.");
			}
		})
	})
}
</script>
<body>
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>
  
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px;height:920px;width:1300px">
		
	<div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
		<table border="1" class="mypage" cellspacing="0" cellpadding="2" width="1250">
			<tr>
				<td colspan="2" height="5%">
					<div class="top">
						<span class="title"><b>마이페이지</b></span>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center">
					<div class="setting">
						<div class="order" onclick="location.href='<%=cPath %>/mypage/personal.jsp'">
							<span class="title">개인정보 확인/수정</span>
						</div>
						
						<div class="order" onclick="location.href='<%=cPath %>/mypage/order.jsp'">
							<span class="title">주문내역</span>
						</div>	
						
						<div class="mile" onclick="location.href='<%=cPath %>/mypage/mile.jsp'">
							<span class="title">마일리지 적립/사용내역</span>
						</div>
						
						<div class="unregi" style="background-color: orangered; border-color: darkorchid; border-width: 3px;" onclick="location.href='<%=cPath %>/mypage/unregi.jsp'">
							<span class="title">회원탈퇴</span>
						</div>
					</div>
				</td>
				<!-- 해당 위치 고정 -->
				<td rowspan="4" width="80%">
				
					<table cellspacing="0" cellpadding="2" width="100%" height="100%">
						<tr>
							<td>
							<!-- 내용 위치 고정 이 사이에 -->
								<form action="NewFile1.jsp" method="POST" class="joinForm" name="regFrom" style="transform: translate(-20%, -30%)">                                                                     
							      <div class="textForm">
							        <input name="mem_id" type="text" class="regi_name" placeholder="아이디">
							        <label for="mem_id" style="position:absolute; transform: translateX(-415px) translateY(3px); width:100px;">아이디 : </label>
							      </div>
							      <div class="textForm">
							        <input name="mem_pw" type="text" maxlength="11" class="cellphoneNo" oninput="maxLengthCheck(this)" placeholder="비밀번호">
							      	<label for="mem_pw" style="position:absolute; transform: translateX(-427px) translateY(3px); width:100px;">비밀번호 : </label>
							      </div>

							      <input type="submit" class="btn" style="transform: translateX(-50%) translateY(100%);" value="회 원 탈 퇴"/>
							    </form>
							  </td>
							<!-- 내용 위치 고정 이 사이에 -->
						</tr>
					</table>
				</td>
				<!-- 해당 위치 고정 -->
			</tr>
		</table>
	</div>

  
  <hr id="about">
  
  <!-- Footer -->

<%@ include file="/index/base/footer.jsp" %>

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
