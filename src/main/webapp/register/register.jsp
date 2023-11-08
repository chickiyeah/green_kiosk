<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String cPath = request.getContextPath();
%>

<html>
<head>
	<title>회원가입</title>
	<link rel="stylesheet" href="<%=cPath %>/assets/css/register.css">
</head>
<script>
function maxLengthCheck(object) {  
	if (object.value.length > parseInt(object.attributes.maxlength)) {
		object.value = object.value.slice(0, object.max.length);
	}
}

function register() {
	let regfrm = document.regForm;
	
	let id = regfrm.mem_id;
	let pw = regfrm.mem_pw;
	let re_pw = regfrm.loginPwConfirm;
	let name = regfrm.mem_name;
	let phone = regfrm.mem_phone;
	
	if (id.value.trim() === "") {
		alert("아이디를 입력해주세요.");
		id.focus();
	} else {
		if (pw.value.trim() === "") {
			alert("비밀번호를 입력해주세요.");
			pw.focus();
		} else {
			if (re_pw.value.trim() === "") {
				alert("비밀번호 확인을 입력해주세요.")
				re_pw.focus();
			} else {
				if (pw.value != re_pw.value) {
					alert("비밀번호가 서로 일치 하지 않습니다.");
					pw.focus();
				} else {
					if (name.value.trim() === "") {
						alert("이름을 입력해주세요.");
						name.focus();
					} else {
						if (phone.value.trim() === "") {
							alert("핸드폰 번호를 입력해주세요.");
							phone.focus();
						} else {
							if (phone.value.length != 11) {
								alert("전화번호를 11글자 이어야합니다.").
								phone.focus();
							} else {
								regfrm.submit();
							}
						}
					}
				}
			}
		}
	}
}

</script>
<body>
<form action="<%=cPath %>/register/reg_proc.jsp" method="POST" class="joinForm" name="regFrom">
                                                                                               
      <h2>회원가입</h2>
      <div class="textForm">
        <input name="mem_id" type="text" class="id" placeholder="아이디">
      </div>
      <div class="textForm">
        <input name="mem_pw" type="password" class="pw" placeholder="비밀번호">
      </div>
       <div class="textForm">
        <input name="loginPwConfirm" type="password" class="pw" placeholder="비밀번호 확인">
      </div>
      <div class="textForm">
        <input name="mem_name" type="text" class="name" placeholder="이름">
      </div>
      <div class="textForm">
        <input name="mem_phone" type="text" maxlength="11" class="cellphoneNo" oninput="maxLengthCheck(this)" placeholder="전화번호" >
      </div>
      <input type="button" class="btn" value="가 입 하 기"/>
    </form>
</body>
</html>