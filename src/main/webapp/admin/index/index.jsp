<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자(메뉴)</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/admin/menu_index.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/admin/Accounting/account.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/admin/index.css">
<%@ include file="/admin/admin_check/check.jsp" %>
<%@ include file="/admin/layouts/indexBase.jsp" %>
<%@ include file="/admin/layouts/bootstrap.jsp"%> 
<%@ include file="/admin/layouts/header.jsp" %>

</head>
<body>
<%@ include file="/admin/layouts/left.jsp" %>
<main class="mainContent" id="mainContent">
<%@ include file="/admin/layouts/index/index_main.jsp" %>
</main> 


</body>
</html>

