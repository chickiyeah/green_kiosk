<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>메뉴 관리 페이지</h1>
<%
	String mem_id = null;
	if(session.getAttribute("mem_id")!= null){
		mem_id=(String)session.getAttribute("mem_id");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 페이지 입니다!')");
		script.println("location.href=");
		script.println("</script>");
	}
%>
%>

</body>
</html>