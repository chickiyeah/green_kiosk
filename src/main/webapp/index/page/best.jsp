<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="user.Member_Mgr" %>
<%@ page import="user.Member_Bean" %>
<%@ page import="orders.Orders_Mgr" %>
<%@ page import="orders.Orders_Bean" %>
<%@ page import="menu.Manager_Menu" %>
<%@ page import="menu.Menu_menu_Bean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Comparator" %>
<%@ page import= "java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ include file="/index/base/head_import.jsp"%>

<%
Orders_Mgr o_mgr = new Orders_Mgr();
Manager_Menu m_mgr = new Manager_Menu();
Vector<Orders_Bean> orders = o_mgr.getAllOrders();
String order_foods = "";
for (Orders_Bean order : orders) {
	order_foods += order.getOrder_foods()+",";
}
order_foods = order_foods.substring(0, order_foods.length()-1);
	String cPath = request.getContextPath();

	Object mem_id = session.getAttribute("mem_id");
	Member_Mgr u_mgr = new Member_Mgr();
	Member_Bean bean = null;
	String mem_ac = "user";
	if (mem_id != null) {
		bean = u_mgr.getMember(String.valueOf(mem_id));
		mem_ac = bean.getMem_ac();
	}
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
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="<%=cPath %>/assets/js/index.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
</style>
</head>
<script>
let mapSort1 = null;
var menuType = "all";
var priceSumdaily = [0,0,0,0,0,0,0];
var priceSumDate = ['','','','','','',''];
var menuAmountMap = new Map();
var keyValuePairs  = [];
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

<div class="w3-container w3-teal">
  <h1>인기 메뉴</h1>
</div>
   <div class="w3-row-padding w3-padding-16 w3-center w3-tooltip" id="food">
    <br/>
	
	<br>
	
			    <% 
	
	Gson gson = new Gson();

		order_foods += "]";
		order_foods = "[" +order_foods;
		System.out.println(order_foods);
		List<List<Map<String, Object>>> parsedList = gson.fromJson(order_foods, new TypeToken<List<List<Map<String, Object>>>>() {}.getType());
		
		Map<String, Integer> menuMap = new HashMap<>();
		String productInfo = "";
		
		for (List<Map<String, Object>> parsedData : parsedList) {
			for (Map<String, Object> order : parsedData ) {
				String menuName = String.valueOf(order.get("name"));
			    Object value = order.get("amount");
			    if (menuMap.containsKey(menuName)) {
			       menuMap.put(menuName, (menuMap.get(menuName)+Integer.parseInt(String.valueOf(value))));
			    } else {
			       menuMap.put(menuName, Integer.parseInt(String.valueOf(value)));
			    }	
			}
		}
		List<Map.Entry<String, Integer>> entryList = new ArrayList<>(menuMap.entrySet());
		 Comparator<Map.Entry<String, Integer>> valueComparator = Map.Entry.comparingByValue();

	        // Sort the entryList using the custom comparator
entryList.sort(new Comparator<Map.Entry<String, Integer>>() {
    @Override
    public int compare(Map.Entry<String, Integer> entry1, Map.Entry<String, Integer> entry2) {
        // Implement your comparison logic here
        // For example, compare entry1.getValue() and entry2.getValue()
        return entry2.getValue().compareTo(entry1.getValue());
    }
});

	        // Create a new LinkedHashMap to preserve the order
	        Map<String, Integer> sortedMap = new LinkedHashMap<>();
        for (Map.Entry<String, Integer> entry : entryList) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }
		Object[] names = sortedMap.keySet().toArray();
		
		for (Object name : names) {
			System.out.println(name);
			Menu_menu_Bean food = m_mgr.getMenuwithName(String.valueOf(name));

			if (food != null) {
				%>
			
						  <div class="w3-quarter" style="max-width: 300px;">
           <img src="<%=food.getMenu_imgPath() %>" alt="<%=food.getMenu_imgPath()%>" style="width:100%; height:300px">
           <h3><%= name %></h3>
           <p><%= food.getMenu_content() %></p>
       </div>
			
			<%
			}}
				
		productInfo = productInfo.replaceAll(", $", "");

		%>    
         
  
		

        </div>
    </div>

  <!-- Pagination -->
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="<%=cPath %>/index.jsp" class="w3-bar-item w3-black w3-button">1</a>
      <a href="<%=cPath %>/index/page/page2.jsp" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="<%=cPath %>/index/page/page3.jsp" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="<%=cPath %>/index/page/page4.jsp" class="w3-bar-item w3-button w3-hover-black">4</a>
    </div>
  </div>
  
  <hr id="about">
  
  <!-- Footer -->

    <div class="w3-third w3-serif">
      <h3>인기 태그</h3>
      <p>
        <span class="w3-tag w3-black w3-margin-bottom">???가게 전주점</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">햄버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">수제 버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">감자튀김</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">치킨버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">데리버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">불고기버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">치즈버거</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">전주 맛집</span>
        <span class="w3-tag w3-dark-grey w3-small w3-margin-bottom">키오스크</span>
      </p>
    </div>

<!-- End page content -->
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