<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
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
<title>마이페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/register.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
</head>

<body>
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>
  
  
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px">
		
	<div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
		<!-- 여기부터 작업 시작 -->

<div style="display:flex; justify-content: space-around; height: 90vh;">

									
								<form action="change_pw_p" method="POST" class="joinForm" name="regFrm" style="transform: translate(-39%, -56%)">                                                                     
							      <div class="textForm">
								  <input name="mem_pw" id="mem_id" type="text" class="regi_name" placeholder="비밀번호 변경">
							        <label for="mem_name" style="position:absolute; transform: translateX(-481px) translateY(3px); width:140px;">비밀번호 찾기 : </label>
							      </div>
							      <div class="textForm">
							  	 <input name="mem_pw_re" id="mem_id" type="text" class="regi_name" placeholder="비밀번호 찾기 확인">
							        <label for="mem_name" style="position:absolute; transform: translateX(-504px) translateY(3px); width:154px;">비밀번호 찾기 확인 : </label>
							      </div>
							      <input type="button" onclick="edit()" class="btn" style="transform: translateX(-50%) translateY(360%);" value="수 정 하 기"/>
							 	
							    </form>
								
</div>
  
  <hr id="about">


      </form>
 

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


//회원가입 창 여는 함수
function open_register() {
	let url = "<%=cPath %>/register/register.jsp"
	window.open(url, "회원가입", "width=460, height=600")
}

function q_findid(){
	let findfrm = document.findid;
	let name = findfrm.name.value;
	let phone = findfrm.phone.value;
	
	fetch("<%=cPath%>/api/user/find_id?name="+name+"&phone="+phone, {
		method: "post"
	}).then(response => {
		response.json().then((data) => {
			if (data.result == "") {
				alert("검색된 아이디가 없습니다.\n다른 정보로 다시 시도해보세요.")
			} else {
				alert("검색된 아이디\n"+data.result)
			}
			
		})
	})
}

function open_register() {
	let url = "<%=cPath %>/register/register.jsp"
	window.open(url, "회원가입", "width=460, height=600")
}

function validatePassword() {
	var newPassword = document.getElementById('newPassword').value;
	var confirmPassword = document.getElementById('confirmPassword').value;
	var resultDiv = document.getElementById('result');

	var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;

	if (passwordRegex.test(newPassword)) {
		if (newPassword === confirmPassword) {
			resultDiv.innerHTML = '비밀번호가 일치하며 유효합니다.';
			resultDiv.style.color = 'green';
		}else{
			resultDiv.innerHTML = '비밀번호가 일치하지 않습니다.';
			resultDiv.style.color = 'red';
		}
	}else{
		resultDiv.innerHTML = '비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.';
		resultDiv.style.color = 'red';
	}
}
function edit(){
	if(document.regFrm.mem_pw.value==""){
		alert("변경하실 비밀번호를 입력해주세요.");
		document.regFrm.mem_pw.focus();
		return;
	} else if (document.regFrm.mem_pw.value != document.regFrm.mem_pw_re.value) {
		alert("비밀번호 확인과 비밀번호가 일치하지 않습니다.");
		document.regFrm.mem_pw.focus();
		return;
	} else {
		document.regFrm.action = "<%=cPath%>/user/change_pw_p.jsp";
		document.regFrm.submit();
	}
	
	
}

</script>

</body>
</html>