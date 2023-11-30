<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="user.Member_Mgr" %>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.Vector"%>
<%@ page import="user.Member_Bean" %>
<jsp:useBean id="rcMgr" class="user.Member_Mgr"/>
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


	int listSize = 0;    //현재 읽어온 자료의 수
	Vector<Menu_menu_Bean> vlist = null;
	int numb = 0; 
    
    vlist = rcMgr.getMgrcList();
    
 
%>
<html>
<head>
<link rel="shortcut icon" href="#">
<title>W3.CSS Templatee</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6{font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
</head>
<script>
//회원가입 창 여는 함수
function open_register() {
	let url = "<%=cPath %>/register/register.jsp"
	window.open(url, "회원가입", "width=460, height=600")
}
</script>
<body leftmargin="0" topmargin="0">
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px">
		
  <!-- First Photo Grid-->
			
<div class="w3-container w3-teal">
  <h1>추천 메뉴</h1>
</div>
<div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
    <br/>
	
	<br>
	
			    <%     
         
          listSize = vlist.size();
	      if (vlist.isEmpty()) {
	   	   out.println("등록된 목록이 없습니다.");
	   	   
	      } else {
		  for (int i = 0;i<listSize; i++) {
			  Menu_menu_Bean menu_bean = vlist.get(i);
			int menu_no = menu_bean.getMenu_no();
			String menu_name = menu_bean.getMenu_name();
			String menu_gubn = menu_bean.getMenu_gubn();
			int menu_isSale = menu_bean.getMenu_isSale();
			String menu_imgPath = menu_bean.getMenu_imgPath();
			String menu_component = menu_bean.getMenu_component();
			int menu_price = menu_bean.getMenu_price();
			int menu_sell_amount = menu_bean.getMenu_sell_amount();
			int menu_recommend = menu_bean.getMenu_recommend();
			String menu_content = menu_bean.getMenu_content();
			int menu_isUse = menu_bean.getMenu_isUse();
			int menu_couponable = menu_bean.getMenu_couponable();
	  %>					

					  
						<div class="w3-quarter" style="max-width: 300px;">
						    <img src="<%=menu_imgPath%>" alt="<%=menu_name%>" style="width:100%; height:300px">
					      <h3><%=menu_name%></h3>
						  <p><%=menu_content %></p>
					   </div>

					<%}//for%>
			<%
				}//if
				%> 
  
		

        </div>
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

</script>
        
    </body>
</html>