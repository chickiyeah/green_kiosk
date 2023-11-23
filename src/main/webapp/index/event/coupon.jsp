<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="user.Member_Mgr" %>
<%@ page import="user.Member_Bean" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="coupon.Coupon_kind_Bean" %>
<%@ page import="coupon.Coupon_kind_Mgr" %>
<%@ page import="coupon.Coupon_Bean" %>
<%@ page import="coupon.Coupon_Mgr" %>
<%@ page import="menu.Manager_Menu" %>
<%@ page import="menu.Menu_menu_Bean" %>
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
	
	Manager_Menu m_mgr = new Manager_Menu();
	Coupon_kind_Mgr c_k_mgr = new Coupon_kind_Mgr();
	Coupon_Mgr c_mgr = new Coupon_Mgr();
	
	int maxsize = 0;
	int printable_count = 0;
	int user_coupon_count = 0;
	
	Vector<Coupon_Bean> user_coupons = c_mgr.getUserCoupon(String.valueOf(mem_id));
	Vector<Coupon_kind_Bean> printable_coupons = c_k_mgr.get_printable(String.valueOf(mem_id));
	
	printable_count = printable_coupons.size();
	user_coupon_count = user_coupons.size();
	
	if (printable_count >= user_coupon_count) {
		maxsize = printable_count;
	} else {
		maxsize = user_coupon_count;
	}
	

	Gson gson = new Gson();
%>
<html>
<head>
<title>W3.CSS Templatee</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=cPath %>/assets/css/reset.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/index.css">
<link rel="stylesheet" href="<%=cPath %>/assets/css/coupon.css">
<script src="<%=request.getContextPath()%>/assets/js/coupon.js"></script>
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
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
<body>
<!-- Sidebar (hidden by default) -->
<%@ include file="/index/base/sidebar.jsp"%>
<!-- Top menu -->
<%@ include file="/index/base/head.jsp" %>
  
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1300px;margin-top:100px">
    <div class="kiosk_pop">
        <div class="inner">
        	<h5 style="text-align:center; font-size: 14px">해당 쿠폰은 <span id="pop_ava_cate">단품, 세트, 사이드, 음료</span> 카테고리 에서만 사용가능합니다.</h5>
            <h2 class="title" style="text-align:center">쿠폰을 적용할 메뉴를 선택해주세요.</h2>
            <div class="kiosk_wrap">
            	<ul class="cate_pops">
            		<li onclick="cate_pop('one')" class="cate_pop one on">단품</li>
            		<li onclick="cate_pop('set')" class="cate_pop set">세트</li>
            		<li onclick="cate_pop('side')" class="cate_pop side">사이드</li>
            		<li onclick="cate_pop('drink')" class="cate_pop drink">음료</li>
            	</ul>
                <div class="kiosk_box" style="display:grid; grid-template-columns: 1fr 1fr;">
                    <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                    <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                                        <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                                        <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                                        <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                                        <div>
                    	<img src="/green_kiosk/assets/images/hamburger0.jpg" style="height:165px">
                    	<span>불고기버거</span>
                    </div>
                </div>
            </div>
            <div class="btn_box">
                <a class="black_line_btn" onclick="document.querySelector('.kiosk_pop').style.display =''" href="javascript:">뒤로가기</a>
            </div>
        </div>
    </div>
	<div class="coupon_title">
		<span style="transform: translate(120%, -110%); position: absolute; font-weight: 900">발급 가능한 쿠폰 ( <%=printable_count %> 개 )</span>
		<span style="transform: translate(525%, -110%); position: absolute; font-weight: 900">사용 가능한 쿠폰 ( <%=user_coupon_count %> 개 )</span>
	</div>
	<div class="coupon_tables" style="display:flex">
		<table border="1" style="width:40%">
			<tr style="background-color: powderblue">
				<th>쿠폰명</th>
				<th width="20%">유효기간</th>
				<th width="20%">발급하기</th>
			</tr>
	<%
		for (Coupon_kind_Bean printable_coupon : printable_coupons) {
			%>
				<tr style="background-color: powderblue" height="12.5%">
					<td height="12.5%" align="center"><%=printable_coupon.getName() %></td>
					<%
						String cates = gson.toJson(printable_coupon.getCategory()).toString().replace("\"","\'");
						String s_vaild = "";
						int vaild_date = printable_coupon.getVaild_date();
						if (vaild_date == -1) {
							%>
								<td align="center">무제한</td>
								<td align="center" style="cursor:pointer" onclick="document.querySelector('.kiosk_pop').style.display = 'flex';cate_pop('one',`<%=cates%>`, '<%=printable_coupon.getName() %>')">발급하기</td>
							<%
						} else {
							s_vaild = vaild_date + " 일";
						}//if
						
						if (vaild_date == 0) {
							%>
								<td align="center" style="background-color:pink" title="비정상 유효기간입니다. 발급이 불가능합니다."><%=s_vaild %></td>
								<td align="center">발급 불가</td>
							<%
						}
						if (vaild_date > 0) {
							%>
								<td align="center"><%=s_vaild %></td>
								<td align="center" style="cursor:pointer" onclick="document.querySelector('.kiosk_pop').style.display = 'flex';cate_pop('one',`<%=cates%>`, '<%=printable_coupon.getName() %>')">발급하기</td>
							<%
						} //if
					%>
				</tr>
			<%
		} //for
		int deffp = 0;
		if (maxsize > printable_count) {
			deffp = maxsize - printable_count;
		}

		for (int i = 0; i < deffp; i++) {
			%>
			<tr style="background-color:powderblue" height="12.5%">
				<td align="center"></td>
				<td align="center"></td>
				<td align="center"></td>
			</tr>
			<%
		}
				%>
		</table>
		
			
		<table border="1" style="width:60%; margin-left: 2%">
			<tr style="background-color:bisque">
				<th width="30%">쿠폰명</th>
				<th width="30%">쿠폰번호</th>
				<th width="15%">남은일수</th>
				<th>선택한 메뉴 명</th>
			</tr>
			<%
			int user_count = 0;
			for (Coupon_Bean user_coupon : user_coupons) {
				String base_code = user_coupon.getCoupon_code();
				String code = base_code.substring(0,3) + " - " + base_code.substring(4, 8) + " - " + base_code.substring(9, 13) + " - " + base_code.substring(14, 18);
				
				int vaild_date = c_k_mgr.get_type_with_name(user_coupon.getCoupon_name()).getVaild_date();
				user_count += 1;
				if (vaild_date != -1) {
					LocalDateTime issueday = user_coupon.getCoupon_issueDate().toLocalDateTime();
					LocalDateTime endday = issueday.plusDays(vaild_date);
					LocalDateTime now = LocalDateTime.now();
					
					if (now.isBefore(endday)) {
					%>
					<tr style="background-color:bisque" height="12.5%">
						<td align="center"><%=user_coupon.getCoupon_name() %></td>
						<td align="center"><%=code %></td>
						<td align="center"><%=vaild_date %> 일</td>
						<td></td>
					</tr>
					<%
					}//if 
				} else {
					%>
					<tr style="background-color:bisque" height="12.5%">
						<td align="center"><%=user_coupon.getCoupon_name() %></td>
						<td align="center"><%=code %></td>
						<td align="center">무제한</td>
					</tr>
					<%
				}
			}//for
			
			int deff = 0;
			if (maxsize > user_count) {
				deff = maxsize - user_count;
			}

			for (int i = 0; i < deff; i++) {
				%>
				<tr style="background-color:bisque" height="12.5%">
					<td align="center"></td>
					<td align="center"></td>
					<td align="center"></td>
					<td align="center"></td>
				</tr>
				<%
			}
					%>
		</table>
	</div>
  
  <hr id="about">
  
  <!-- Footer -->

<%@ include file="/index/base/footer.jsp" %>

<!-- End page content -->
</div>


<script>
<%
	Vector<Menu_menu_Bean> foods = m_mgr.getMenuList(0);
	Map<String, List<Map<String, String>>> cate_food = new HashMap<String, List<Map<String, String>>>();
	List<Map<String, String>> one = new ArrayList<Map<String, String>>();
	List<Map<String, String>> set = new ArrayList<Map<String, String>>();
	List<Map<String, String>> side = new ArrayList<Map<String, String>>();
	List<Map<String, String>> drink = new ArrayList<Map<String, String>>();
	for(Menu_menu_Bean food : foods) {
		String cate = food.getMenu_gubn();
		String name = food.getMenu_name();
		String imgpath = food.getMenu_imgPath();
		String scate = food.getMenu_gubn();
		Map<String, String> menu = new HashMap<String, String>();
		menu.put("name", name);
		menu.put("img", imgpath);
		menu.put("cate", scate);
		if (cate.equals("단품")) {
			one.add(menu);
		}
		
		if (cate.equals("세트")) {
			set.add(menu);
		}
		
		if (cate.equals("사이드")) {
			side.add(menu);
		}
		
		if (cate.equals("음료")) {
			drink.add(menu);
		}
	}
	
%>

const pop_one = JSON.parse('<%=gson.toJson(one).toString()%>')
const pop_set = JSON.parse('<%=gson.toJson(set).toString()%>')
const pop_side = JSON.parse('<%=gson.toJson(side).toString()%>')
const pop_drink = JSON.parse('<%=gson.toJson(drink).toString()%>')

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
