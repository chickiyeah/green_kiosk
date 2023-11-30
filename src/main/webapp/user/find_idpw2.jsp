<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/login/login.css" type="text/css">
<script>
function q_findid(){
	let findfrm = document.findid;
	let name = findfrm.name.value;
	let phone = findfrm.phone.value;
	
	fetch("<%=request.getContextPath()%>/api/user/find_id?name="+name+"&phone="+phone, {
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
}</script>
<style>

* {
    padding: 0;
    margin: 0;
    border: none;
}

body {
    font-size: 14px;
    font-family: 'Roboto', sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh; /* Set the height of the body to 100% of the viewport height */
}

.login-wrapper {
    width: 400px;
    height: 400px;
    padding: 40px;
    box-sizing: border-box;
    background-color: #fff; /* Added a background color for visibility */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.login-wrapper > h2 {
    font-size: 24px;
    color: #6A24FE;
    margin-bottom: 20px;
}

#login-form > input {
    width: 100%;
    height: 48px;
    padding: 0 10px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: #F8F8F8;
}

#login-form > input::placeholder {
    color: #D2D2D2;
}

#login-form > input[type="submit"] {
    color: #fff;
    font-size: 16px;
    background-color: #6A24FE;
    margin-top: 20px;
}

#login-form > input[type="button"] {
    color: #fff;
    font-size: 16px;
    background-color: #6A24FE;
    margin-top: 20px;
}

#login-form > input[type="checkbox"] {
    display: none;
}

#login-form > label {
    color: #999999;
}

#login-form input[type="checkbox"] + label {
    cursor: pointer;
    padding-left: 26px;
    background-image: url("checkbox.png");
    background-repeat: no-repeat;
    background-size: contain;
}

#login-form input[type="checkbox"]:checked + label {
    background-image: url("checkbox-active.png");
    background-repeat: no-repeat;
    background-size: contain;
}
</style>
</head>
<body>
    <div class="login-wrapper">
        <h2>아이디 찾기</h2>
        <form method="post" name="findid" action="javascript:" id="login-form">
            <input type="text" name="name" placeholder="이름">
            <input type="text" name="phone" placeholder="전화번호">
            <input onclick="q_findid()" type="button" value="아이디 찾기">
        </form>
    </div>
        <div class="login-wrapper">
        <h2>비밀번호 찾기</h2>
        <form method="post" action="<%=request.getContextPath() %>/api/user/find_pw" id="login-form">
            <input type="text" required name="id" placeholder="아이디">
            <input type="text" required name="name" placeholder="이름">
            <input type="text" required name="phone" placeholder="전화번호">
            <input type="submit" value="비밀번호 찾기">
        </form>
    </div>
</body>
</html>