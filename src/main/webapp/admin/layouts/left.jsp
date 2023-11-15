<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.PrintWriter" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

	<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
	  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
	    <i class="fa fa-remove"></i>
	  </a>
	  <br/>
	  <h4 class="w3-bar-item"><b>Menu</b></h4>
	  <hr/>
	  <% String menuType = null;
	  if(request.getParameter("menuType") == null)
	  {
		  menuType = "main";
	  }
	  if (request.getParameter("menuType") != null && !request.getParameter("menuType").isEmpty())
	  {
		  menuType = request.getParameter("menuType");
	  } else if (request.getParameter("menuType") == null && menuType == null){
	  
			  PrintWriter script = response.getWriter();
			  script.println("<script>");
			  script.println("alert('정상 접근이 아닙니다!')");
			  script.println("history.back()");
			  script.println("</script>");
		  }
	  %>
	  <%
	  //menu page 일 경우 
	  if(menuType.equals("menu")) { %>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('all')">전체</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('single')">단품</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('set')">세트</a>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('drink')">음료</a>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('side')">사이드</a>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('component')">재료</a>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('onSale')">이벤트</a>
	  <%
	  //Event page 일 경우 
	  } else if (menuType.equals("Event")){ %>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('component')">재료</a>
  	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="updateMenu('onSale')">이벤트 등록된 상품</a>
	  <% 
	  //Accounting page 일 경우
	  } else { %>
	  <a class="w3-bar-item w3-button w3-hover-black" href="#" onclick="<%=request.getContextPath()%>/admin/login/logout.html">로그아웃</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="loadContent('<%=request.getContextPath()%>/admin/Accounting/sales/ac00.jsp')">거래내역관리</a>
	  <a class="w3-bar-item w3-button w3-hover-black" href="javascript:void(0)" onclick="loadContent('<%=request.getContextPath()%>/admin/Accounting/inventory/iv00.jsp')">재고관리</a>
	  <%} %>
	</nav>
	
</body>
</html>
