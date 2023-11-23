<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check edit's type</title>
</head>
<body>
		<%
			String type = request.getParameter("type");
			int menu_no = 0;
			int component_no = 0;
			
			if (type.equals("m")){
				if (request.getParameter("menu_no") != null && !request.getParameter("menu_no").isEmpty())
				{
					menu_no = Integer.parseInt(request.getParameter("menu_no"));		
	                response.sendRedirect("Edit.jsp?menu_no=" + menu_no); 
				} 
			} else if (type.equals("c")) {
				if (request.getParameter("component_no") != null && !request.getParameter("component_no").isEmpty()) {
					component_no = Integer.parseInt(request.getParameter("component_no"));
					response.sendRedirect("componentEdit.jsp?component_no=" + component_no);
				}
			}
		%>
</body>
</html>