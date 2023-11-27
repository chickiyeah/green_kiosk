<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/board/layout.css">
<script src="<%=request.getContextPath()%>/assets/js/board/board.js"></script>

<%@ include file="/board/bootstrap.jsp" %>
<%@ include file="/board/layouts/header.jsp" %>
</head>
<body>
	<%@ include file="/board/layouts/sidebar.jsp" %>
	<div class="mainContent" id="mainContent">
		<%@ include file="/board/layouts/main.jsp" %>
	</div>
	
	<script>
		const socket = new WebSocket('ws://nodove.duckdns.org/socket');
		
		socket.onopen = function(event) {
		    console.log('WebSocket 연결이 열렸습니다.');
		};

		socket.onmessage = function(event) {
		    console.log('서버로부터 메시지 수신:', event.data);
		};

		socket.onclose = function(event) {
		    console.log('WebSocket 연결이 닫혔습니다.');
		};

		socket.onerror = function(error) {
		    console.error('WebSocket 오류 발생:', error);
		};

	</script>
</body>
</html>