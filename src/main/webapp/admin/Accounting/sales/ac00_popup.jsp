<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
			String CouponInfo = request.getParameter("CouponInfo");
	%>
	<h1><%=CouponInfo%></h1>
</body>
</html>