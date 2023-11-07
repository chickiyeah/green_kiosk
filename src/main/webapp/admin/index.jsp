<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin/style.css">
<%@ include file="/admin/layouts/header.jsp" %>
</head>
<body>
<br/>
	<div class="layout_left">
		<%@ include file="/admin/layouts/left.jsp" %>
	</div>
	<div class="layout_main">
		<%@ include file="/admin/layouts/main.jsp" %>
	</div>
	<br/>
	
<%-- 	<div class="layout_footer">
		<%@ include file="/admin/layouts/footer.jsp" %>
	</div> --%>
	
	</body>
</head>
<body>

<%@ include file="/admin/layouts/header.jsp" %>

<%@ include file="/admin/layouts/left.jsp" %>

<%@ include file="/admin/layouts/main.jsp" %>

<%@ include file="/admin/layouts/footer.jsp" %>

</body>
</html>